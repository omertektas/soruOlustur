import { DIFFICULTIES, type Difficulty } from "./types";

export const QUESTION_LIMITS = {
  title: { min: 10, max: 200 },
  answer: { min: 20, max: 10000 },
  tip: { max: 400 },
  catalogName: { min: 2, max: 60 },
} as const;

/** Form value used when the user suggests a new profession or topic. */
export const NEW_CATALOG_ENTRY = "new";

/** Either an existing profession/topic, or the name of a new one the user suggests. */
export type CatalogChoice = { kind: "existing"; id: number } | { kind: "new"; name: string };

export interface QuestionContent {
  title: string;
  answer: string;
  tip: string | null;
  difficulty: Difficulty;
}

export interface QuestionInput extends QuestionContent {
  profession: CatalogChoice;
  topic: CatalogChoice;
}

export type QuestionField = keyof QuestionContent | "profession" | "topic";

export type ValidationResult =
  | { ok: true; data: QuestionInput }
  | { ok: false; errors: Partial<Record<QuestionField, string>> };

const text = (form: FormData, key: string) => String(form.get(key) ?? "").trim();

function readCatalogChoice(form: FormData, idField: string, nameField: string): CatalogChoice | null {
  const value = text(form, idField);
  if (value === NEW_CATALOG_ENTRY) {
    const name = text(form, nameField).replace(/\s+/g, " ");
    const { min, max } = QUESTION_LIMITS.catalogName;
    return name.length >= min && name.length <= max ? { kind: "new", name } : null;
  }
  const id = Number(value);
  return Number.isInteger(id) && id > 0 ? { kind: "existing", id } : null;
}

export function validateQuestionInput(form: FormData): ValidationResult {
  const errors: Partial<Record<QuestionField, string>> = {};

  const title = text(form, "title").replace(/\s+/g, " ");
  const answer = text(form, "answer");
  const tipRaw = text(form, "tip");
  const difficulty = text(form, "difficulty");
  const profession = readCatalogChoice(form, "professionId", "newProfession");
  const topic = readCatalogChoice(form, "topicId", "newTopic");

  const { title: t, answer: a, tip, catalogName: c } = QUESTION_LIMITS;
  if (title.length < t.min || title.length > t.max) errors.title = `Soru ${t.min}–${t.max} karakter arasında olmalı.`;
  if (answer.length < a.min || answer.length > a.max) errors.answer = `Cevap ${a.min}–${a.max} karakter arasında olmalı.`;
  if (tipRaw.length > tip.max) errors.tip = `İpucu en fazla ${tip.max} karakter olabilir.`;
  if (!DIFFICULTIES.includes(difficulty as Difficulty)) errors.difficulty = "Bir zorluk seviyesi seçin.";
  if (!profession) errors.profession = `Bir meslek seçin veya ${c.min}–${c.max} karakterlik yeni bir meslek adı yazın.`;
  if (!topic) errors.topic = `Bir konu seçin veya ${c.min}–${c.max} karakterlik yeni bir konu adı yazın.`;

  if (!profession || !topic || Object.keys(errors).length > 0) return { ok: false, errors };

  return {
    ok: true,
    data: { title, answer, tip: tipRaw || null, difficulty: difficulty as Difficulty, profession, topic },
  };
}

/** Allows only same-site relative paths (prevents open redirects). */
export function safeNextPath(value: unknown, fallback = "/"): string {
  const path = typeof value === "string" ? value : "";
  return path.startsWith("/") && !path.startsWith("//") && !path.startsWith("/\\") ? path : fallback;
}
