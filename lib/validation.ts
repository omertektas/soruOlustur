import { DIFFICULTIES, type Difficulty } from "./types";

export const QUESTION_LIMITS = {
  title: { min: 10, max: 200 },
  answer: { min: 20, max: 10000 },
  tip: { max: 400 },
} as const;

export interface QuestionInput {
  title: string;
  answer: string;
  tip: string | null;
  difficulty: Difficulty;
  professionId: number;
  topicId: number;
}

export type QuestionField = keyof QuestionInput;

export type ValidationResult =
  | { ok: true; data: QuestionInput }
  | { ok: false; errors: Partial<Record<QuestionField, string>> };

const text = (form: FormData, key: string) => String(form.get(key) ?? "").trim();

export function validateQuestionInput(form: FormData): ValidationResult {
  const errors: Partial<Record<QuestionField, string>> = {};

  const title = text(form, "title").replace(/\s+/g, " ");
  const answer = text(form, "answer");
  const tipRaw = text(form, "tip");
  const difficulty = text(form, "difficulty");
  const professionId = Number(text(form, "professionId"));
  const topicId = Number(text(form, "topicId"));

  const { title: t, answer: a, tip } = QUESTION_LIMITS;
  if (title.length < t.min || title.length > t.max) errors.title = `Soru ${t.min}–${t.max} karakter arasında olmalı.`;
  if (answer.length < a.min || answer.length > a.max) errors.answer = `Cevap ${a.min}–${a.max} karakter arasında olmalı.`;
  if (tipRaw.length > tip.max) errors.tip = `İpucu en fazla ${tip.max} karakter olabilir.`;
  if (!DIFFICULTIES.includes(difficulty as Difficulty)) errors.difficulty = "Bir zorluk seviyesi seçin.";
  if (!Number.isInteger(professionId) || professionId <= 0) errors.professionId = "Bir meslek seçin.";
  if (!Number.isInteger(topicId) || topicId <= 0) errors.topicId = "Bir konu seçin.";

  if (Object.keys(errors).length > 0) return { ok: false, errors };

  return {
    ok: true,
    data: {
      title,
      answer,
      tip: tipRaw || null,
      difficulty: difficulty as Difficulty,
      professionId,
      topicId,
    },
  };
}

/** Allows only same-site relative paths (prevents open redirects). */
export function safeNextPath(value: unknown, fallback = "/"): string {
  const path = typeof value === "string" ? value : "";
  return path.startsWith("/") && !path.startsWith("//") && !path.startsWith("/\\") ? path : fallback;
}
