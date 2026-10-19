"use server";

import { revalidatePath } from "next/cache";
import { getSessionUser } from "@/lib/auth";
import { insertPendingQuestion, slugExists } from "@/lib/data/questions";
import { resolveCatalogChoice, SuggestionError } from "@/lib/data/suggestions";
import { randomSuffix, slugify } from "@/lib/slug";
import { internalRoutes } from "@/lib/site";
import { createServerSupabase } from "@/lib/supabase/server";
import { validateQuestionInput, type QuestionField } from "@/lib/validation";

export type SubmitState = {
  status: "idle" | "success" | "error";
  message?: string;
  errors?: Partial<Record<QuestionField, string>>;
  values?: Record<string, string>;
  attempt: number;
};

export async function submitQuestion(prev: SubmitState, formData: FormData): Promise<SubmitState> {
  const attempt = prev.attempt + 1;
  const values = Object.fromEntries(
    ["title", "answer", "tip", "difficulty", "professionId", "topicId", "newProfession", "newTopic"].map((k) => [k, String(formData.get(k) ?? "")])
  );

  // Honeypot: bots fill the hidden field; pretend success and drop the submission
  if (String(formData.get("website") ?? "") !== "") return { status: "success", attempt };

  const user = await getSessionUser();
  if (!user) return { status: "error", message: "Oturumunuz sona ermiş. Lütfen tekrar giriş yapın.", values, attempt };

  const parsed = validateQuestionInput(formData);
  if (!parsed.ok) return { status: "error", errors: parsed.errors, message: "Lütfen işaretli alanları düzeltin.", values, attempt };

  const supabase = await createServerSupabase();
  const { profession, topic, ...content } = parsed.data;

  let professionId: number;
  let topicId: number;
  try {
    professionId = await resolveCatalogChoice(supabase, "profession", profession);
    topicId = await resolveCatalogChoice(supabase, "topic", topic);
  } catch (e) {
    const code = e instanceof SuggestionError ? e.code : "UNKNOWN";
    const message =
      code === "SUGGESTION_LIMIT"
        ? "Onay bekleyen 5 meslek veya konu öneriniz var. Bunlar incelendikten sonra yeni öneri yapabilirsiniz."
        : code === "INVALID_NAME"
          ? "Yeni meslek veya konu adı yalnızca harf, rakam ve boşluk içermeli."
          : "Öneriniz kaydedilemedi. Lütfen biraz sonra tekrar deneyin.";
    return { status: "error", message, values, attempt };
  }

  const base = slugify(content.title) || "soru";
  const slug = (await slugExists(supabase, base)) ? `${base}-${randomSuffix()}` : base;

  const { error } = await insertPendingQuestion(supabase, { authorId: user.id, slug, professionId, topicId, content });
  if (error) {
    const message = error.message.includes("PENDING_LIMIT")
      ? "Onay bekleyen 10 sorunuz var. Bunlar incelendikten sonra yeni soru ekleyebilirsiniz."
      : error.code === "23505"
        ? "Bu soru başlığı zaten kullanılıyor. Başlığı biraz değiştirip tekrar deneyin."
        : "Soru kaydedilemedi. Lütfen biraz sonra tekrar deneyin.";
    return { status: "error", message, values, attempt };
  }

  revalidatePath(internalRoutes.account);
  revalidatePath(internalRoutes.admin);
  revalidatePath(internalRoutes.adminQuestions());
  return { status: "success", attempt };
}
