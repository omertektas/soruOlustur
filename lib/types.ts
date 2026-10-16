export const DIFFICULTIES = ["kolay", "orta", "zor"] as const;
export type Difficulty = (typeof DIFFICULTIES)[number];

export const DIFFICULTY_LABELS: Record<Difficulty, string> = {
  kolay: "Kolay",
  orta: "Orta",
  zor: "Zor",
};

export type QuestionStatus = "pending" | "approved" | "rejected";

export const STATUS_LABELS: Record<QuestionStatus, string> = {
  pending: "Onay bekliyor",
  approved: "Yayında",
  rejected: "Reddedildi",
};

export interface Profession {
  id: number;
  slug: string;
  name: string;
  shortName: string;
  description: string;
}

export interface ProfessionWithCount extends Profession {
  questionCount: number;
}

export interface Topic {
  id: number;
  slug: string;
  name: string;
}

export interface TopicWithCount extends Topic {
  questionCount: number;
}

export interface QuestionSummary {
  id: string;
  slug: string;
  title: string;
  difficulty: Difficulty;
  createdAt: string;
  profession: Pick<Profession, "slug" | "name" | "shortName">;
  topic: Pick<Topic, "slug" | "name">;
}

export interface QuestionDetail extends QuestionSummary {
  answer: string;
  tip: string | null;
  updatedAt: string;
  authorName: string | null;
}

export interface OwnQuestion extends QuestionSummary {
  status: QuestionStatus;
  rejectionReason: string | null;
}

export interface ReviewQuestion extends QuestionDetail {
  status: QuestionStatus;
  rejectionReason: string | null;
}

export type UserRole = "user" | "admin";

export interface SessionUser {
  id: string;
  email: string | null;
  displayName: string;
  role: UserRole;
}
