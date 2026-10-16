"use server";

import { revalidatePath } from "next/cache";
import { getSessionUser } from "@/lib/auth";
import { insertPendingQuestion, slugExists } from "@/lib/data/questions";
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
    ["title", "answer", "tip", "difficulty", "professionId", "topicId"].map((k) => [k, String(formData.get(k) ?? "")])
  );

  // Honeypot: bots fill the hidden field; pretend success and drop the submission
  if (String(formData.get("website") ?? "") !== "") return { status: "success", attempt };

  const user = await getSessionUser();
  if (!user) return { status: "error", message: "Oturumunuz sona ermiş. Lütfen tekrar giriş yapın.", values, attempt };

  const parsed = validateQuestionInput(formData);
  if (!parsed.ok) return { status: "error", errors: parsed.errors, message: "Lütfen işaretli alanları düzeltin.", values, attempt };

  const supabase = await createServerSupabase();
  const base = slugify(parsed.data.title) || "soru";
  const slug = (await slugExists(supabase, base)) ? `${base}-${randomSuffix()}` : base;

  const { error } = await insertPendingQuestion(supabase, user.id, slug, parsed.data);
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
  return { status: "success", attempt };
}
