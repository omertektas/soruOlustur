import type {
  Difficulty,
  OwnQuestion,
  Profession,
  QuestionDetail,
  QuestionStatus,
  QuestionSummary,
  ReviewQuestion,
  Topic,
} from "../types";

/* Database rows (snake_case) → domain types (camelCase) */

export interface ProfessionRow {
  id: number;
  slug: string;
  name: string;
  short_name: string;
  description: string;
}

export interface TopicRow {
  id: number;
  slug: string;
  name: string;
}

export interface QuestionRow {
  id: string;
  slug: string;
  title: string;
  difficulty: Difficulty;
  created_at: string;
  updated_at?: string;
  answer?: string;
  tip?: string | null;
  status?: QuestionStatus;
  rejection_reason?: string | null;
  profession: { slug: string; name: string; short_name: string; is_published?: boolean };
  topic: { slug: string; name: string; is_published?: boolean };
  author?: { display_name: string } | null;
}

export const PROFESSION_COLUMNS = "id, slug, name, short_name, description";
export const TOPIC_COLUMNS = "id, slug, name";

const RELATIONS =
  "profession:professions!inner(slug, name, short_name, is_published), topic:topics!inner(slug, name)";
export const SUMMARY_COLUMNS = `id, slug, title, difficulty, created_at, ${RELATIONS}`;
export const DETAIL_COLUMNS = `id, slug, title, difficulty, created_at, updated_at, answer, tip, ${RELATIONS}, author:profiles!questions_author_id_fkey(display_name)`;
export const OWN_COLUMNS = `${SUMMARY_COLUMNS}, status, rejection_reason`;
const REVIEW_RELATIONS =
  "profession:professions!inner(slug, name, short_name, is_published), topic:topics!inner(slug, name, is_published)";
export const REVIEW_COLUMNS = `id, slug, title, difficulty, created_at, updated_at, answer, tip, status, rejection_reason, ${REVIEW_RELATIONS}, author:profiles!questions_author_id_fkey(display_name)`;

export function toProfession(row: ProfessionRow): Profession {
  return {
    id: row.id,
    slug: row.slug,
    name: row.name,
    shortName: row.short_name,
    description: row.description,
  };
}

export function toTopic(row: TopicRow): Topic {
  return { id: row.id, slug: row.slug, name: row.name };
}

export function toSummary(row: QuestionRow): QuestionSummary {
  return {
    id: row.id,
    slug: row.slug,
    title: row.title,
    difficulty: row.difficulty,
    createdAt: row.created_at,
    profession: {
      slug: row.profession.slug,
      name: row.profession.name,
      shortName: row.profession.short_name,
    },
    topic: { slug: row.topic.slug, name: row.topic.name },
  };
}

export function toDetail(row: QuestionRow): QuestionDetail {
  return {
    ...toSummary(row),
    answer: row.answer ?? "",
    tip: row.tip ?? null,
    updatedAt: row.updated_at ?? row.created_at,
    authorName: row.author?.display_name ?? null,
  };
}

export function toOwn(row: QuestionRow): OwnQuestion {
  return {
    ...toSummary(row),
    status: row.status ?? "pending",
    rejectionReason: row.rejection_reason ?? null,
  };
}

export function toReview(row: QuestionRow): ReviewQuestion {
  return {
    ...toDetail(row),
    status: row.status ?? "pending",
    rejectionReason: row.rejection_reason ?? null,
    suggestsNewProfession: row.profession.is_published === false,
    suggestsNewTopic: row.topic.is_published === false,
  };
}

/** The Supabase client is used without generated types, so rows are typed here. */
export function rows<T>(data: unknown): T[] {
  return (Array.isArray(data) ? data : []) as T[];
}
