import "server-only";
import { createPublicSupabase } from "../supabase/public";
import type { Profession, ProfessionWithCount, Topic, TopicWithCount } from "../types";
import {
  PROFESSION_COLUMNS,
  TOPIC_COLUMNS,
  rows,
  toProfession,
  toTopic,
  type ProfessionRow,
  type TopicRow,
} from "./mappers";

/* Profession and topic catalog: public, cacheable reads */

export async function getProfessions(): Promise<Profession[]> {
  const { data, error } = await createPublicSupabase()
    .from("professions")
    .select(PROFESSION_COLUMNS)
    .eq("is_published", true)
    .order("sort_order");
  if (error) throw error;
  return rows<ProfessionRow>(data).map(toProfession);
}

export async function getProfessionsWithCounts(): Promise<ProfessionWithCount[]> {
  const supabase = createPublicSupabase();
  const [professions, counts] = await Promise.all([
    getProfessions(),
    supabase.from("questions").select("profession_id").eq("status", "approved"),
  ]);
  if (counts.error) throw counts.error;

  const tally = new Map<number, number>();
  for (const row of rows<{ profession_id: number }>(counts.data)) {
    tally.set(row.profession_id, (tally.get(row.profession_id) ?? 0) + 1);
  }
  return professions.map((p) => ({ ...p, questionCount: tally.get(p.id) ?? 0 }));
}

export async function getProfessionBySlug(slug: string): Promise<Profession | null> {
  const { data, error } = await createPublicSupabase()
    .from("professions")
    .select(PROFESSION_COLUMNS)
    .eq("is_published", true)
    .eq("slug", slug)
    .maybeSingle();
  if (error) throw error;
  return data ? toProfession(data as unknown as ProfessionRow) : null;
}

export async function getTopics(): Promise<Topic[]> {
  const { data, error } = await createPublicSupabase()
    .from("topics")
    .select(TOPIC_COLUMNS)
    .eq("is_published", true)
    .order("name");
  if (error) throw error;
  return rows<TopicRow>(data).map(toTopic);
}

export async function getTopicBySlug(slug: string): Promise<Topic | null> {
  const { data, error } = await createPublicSupabase()
    .from("topics")
    .select(TOPIC_COLUMNS)
    .eq("is_published", true)
    .eq("slug", slug)
    .maybeSingle();
  if (error) throw error;
  return data ? toTopic(data as unknown as TopicRow) : null;
}

/** Topics that have published questions for a profession, ordered by question count. */
export async function getTopicsForProfession(professionId: number): Promise<TopicWithCount[]> {
  const { data, error } = await createPublicSupabase()
    .from("questions")
    .select("topic:topics!inner(id, slug, name)")
    .eq("status", "approved")
    .eq("profession_id", professionId);
  if (error) throw error;

  const tally = new Map<number, TopicWithCount>();
  for (const row of rows<{ topic: TopicRow }>(data)) {
    const current = tally.get(row.topic.id);
    if (current) current.questionCount++;
    else tally.set(row.topic.id, { ...toTopic(row.topic), questionCount: 1 });
  }
  return [...tally.values()].sort((a, b) => b.questionCount - a.questionCount || a.name.localeCompare(b.name, "tr"));
}
