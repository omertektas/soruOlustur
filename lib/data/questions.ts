import "server-only";
import type { ServerSupabase as SupabaseClient } from "../supabase/server";
import { createPublicSupabase } from "../supabase/public";
import type { OwnQuestion, QuestionDetail, QuestionSummary, ReviewQuestion } from "../types";
import type { QuestionContent } from "../validation";
import {
  DETAIL_COLUMNS,
  OWN_COLUMNS,
  REVIEW_COLUMNS,
  SUMMARY_COLUMNS,
  rows,
  toDetail,
  toOwn,
  toReview,
  toSummary,
  type QuestionRow,
} from "./mappers";

/* ---------- Public reads (approved questions only) ---------- */

interface ListOptions {
  professionId?: number;
  topicId?: number;
  limit?: number;
}

export async function listApprovedQuestions(options: ListOptions = {}): Promise<QuestionSummary[]> {
  let query = createPublicSupabase().from("questions").select(SUMMARY_COLUMNS).eq("status", "approved");
  if (options.professionId) query = query.eq("profession_id", options.professionId);
  if (options.topicId) query = query.eq("topic_id", options.topicId);

  const { data, error } = await query.order("created_at", { ascending: true }).limit(options.limit ?? 1000);
  if (error) throw error;
  return rows<QuestionRow>(data).map(toSummary);
}

export async function listLatestQuestions(limit: number): Promise<QuestionSummary[]> {
  const { data, error } = await createPublicSupabase()
    .from("questions")
    .select(SUMMARY_COLUMNS)
    .eq("status", "approved")
    .order("reviewed_at", { ascending: false, nullsFirst: false })
    .order("created_at", { ascending: false })
    .limit(limit);
  if (error) throw error;
  return rows<QuestionRow>(data).map(toSummary);
}

export async function getApprovedQuestionBySlug(slug: string): Promise<QuestionDetail | null> {
  const { data, error } = await createPublicSupabase()
    .from("questions")
    .select(DETAIL_COLUMNS)
    .eq("status", "approved")
    .eq("slug", slug)
    .maybeSingle();
  if (error) throw error;
  return data ? toDetail(data as unknown as QuestionRow) : null;
}

/** Related questions from the same topic, same profession first. */
export async function listRelatedQuestions(question: QuestionDetail, limit = 6): Promise<QuestionSummary[]> {
  const { data, error } = await createPublicSupabase()
    .from("questions")
    .select(SUMMARY_COLUMNS)
    .eq("status", "approved")
    .eq("topic.slug", question.topic.slug)
    .neq("id", question.id)
    .limit(limit * 2);
  if (error) throw error;
  return rows<QuestionRow>(data)
    .map(toSummary)
    .sort(
      (a, b) =>
        Number(b.profession.slug === question.profession.slug) - Number(a.profession.slug === question.profession.slug)
    )
    .slice(0, limit);
}

/** Strips characters that would break PostgREST filter syntax. */
function sanitizeSearch(term: string): string {
  return term.replace(/[%_,()*\\"'.:]/g, " ").replace(/\s+/g, " ").trim().slice(0, 80);
}

export async function searchApprovedQuestions(term: string, limit = 50): Promise<QuestionSummary[]> {
  const clean = sanitizeSearch(term);
  if (clean.length < 2) return [];
  const pattern = `%${clean.replace(/ /g, "%")}%`;
  const { data, error } = await createPublicSupabase()
    .from("questions")
    .select(SUMMARY_COLUMNS)
    .eq("status", "approved")
    .or(`title.ilike.${pattern},answer.ilike.${pattern}`)
    .limit(limit);
  if (error) throw error;
  return rows<QuestionRow>(data).map(toSummary);
}

export interface SitemapQuestion {
  slug: string;
  updatedAt: string;
  professionSlug: string;
  topicSlug: string;
}

export async function listQuestionsForSitemap(): Promise<SitemapQuestion[]> {
  const { data, error } = await createPublicSupabase()
    .from("questions")
    .select("slug, updated_at, profession:professions!inner(slug), topic:topics!inner(slug)")
    .eq("status", "approved")
    .limit(50000);
  if (error) throw error;
  return rows<{ slug: string; updated_at: string; profession: { slug: string }; topic: { slug: string } }>(data).map(
    (r) => ({ slug: r.slug, updatedAt: r.updated_at, professionSlug: r.profession.slug, topicSlug: r.topic.slug })
  );
}

/* ---------- Session-scoped operations (caller passes the client; RLS applies) ---------- */

export async function slugExists(supabase: SupabaseClient, slug: string): Promise<boolean> {
  // RLS hides other users' pending questions, so this checks approved and own rows only;
  // the unique constraint in the database is the final guard for rare collisions.
  const { count, error } = await supabase
    .from("questions")
    .select("id", { count: "exact", head: true })
    .eq("slug", slug);
  if (error) throw error;
  return (count ?? 0) > 0;
}

interface NewQuestion {
  authorId: string;
  slug: string;
  professionId: number;
  topicId: number;
  content: QuestionContent;
}

export async function insertPendingQuestion(supabase: SupabaseClient, question: NewQuestion) {
  const { content } = question;
  return supabase.from("questions").insert({
    slug: question.slug,
    title: content.title,
    answer: content.answer,
    tip: content.tip,
    difficulty: content.difficulty,
    profession_id: question.professionId,
    topic_id: question.topicId,
    author_id: question.authorId,
    status: "pending",
  });
}

export async function listOwnQuestions(supabase: SupabaseClient, authorId: string): Promise<OwnQuestion[]> {
  const { data, error } = await supabase
    .from("questions")
    .select(OWN_COLUMNS)
    .eq("author_id", authorId)
    .order("created_at", { ascending: false });
  if (error) throw error;
  return rows<QuestionRow>(data).map(toOwn);
}

export async function listQuestionsByStatus(
  supabase: SupabaseClient,
  status: "pending" | "approved" | "rejected",
  limit = 50
): Promise<ReviewQuestion[]> {
  const { data, error } = await supabase
    .from("questions")
    .select(REVIEW_COLUMNS)
    .eq("status", status)
    .order(status === "pending" ? "created_at" : "reviewed_at", { ascending: status === "pending" })
    .limit(limit);
  if (error) throw error;
  return rows<QuestionRow>(data).map(toReview);
}

export async function countPendingQuestions(supabase: SupabaseClient): Promise<number> {
  const { count, error } = await supabase
    .from("questions")
    .select("id", { count: "exact", head: true })
    .eq("status", "pending");
  if (error) throw error;
  return count ?? 0;
}

export async function reviewQuestion(
  supabase: SupabaseClient,
  id: string,
  reviewerId: string,
  decision: { status: "approved" } | { status: "rejected"; reason: string }
) {
  return supabase
    .from("questions")
    .update({
      status: decision.status,
      rejection_reason: decision.status === "rejected" ? decision.reason : null,
      reviewed_by: reviewerId,
      reviewed_at: new Date().toISOString(),
    })
    .eq("id", id)
    .select(
      "slug, profession:professions!inner(id, slug, is_published), topic:topics!inner(id, slug, is_published)"
    )
    .single();
}
