"use server";

import { revalidatePath } from "next/cache";
import { requireAdmin } from "@/lib/auth";
import { reviewQuestion } from "@/lib/data/questions";
import { internalRoutes } from "@/lib/site";
import { createServerSupabase } from "@/lib/supabase/server";

async function review(formData: FormData, decision: "approved" | "rejected") {
  const admin = await requireAdmin();
  const id = String(formData.get("id") ?? "");
  if (!id) return;
  const reason = String(formData.get("reason") ?? "").trim().slice(0, 300) || "Yayın kriterlerine uygun bulunmadı.";

  const supabase = await createServerSupabase();
  const { data, error } = await reviewQuestion(
    supabase,
    id,
    admin.id,
    decision === "approved" ? { status: "approved" } : { status: "rejected", reason }
  );
  if (error) throw new Error(`İnceleme kaydedilemedi: ${error.message}`);

  // Refresh every cached page that lists or shows this question
  const row = data as unknown as { slug: string; profession: { slug: string }; topic: { slug: string } };
  revalidatePath(internalRoutes.home);
  revalidatePath(internalRoutes.question(row.slug));
  revalidatePath(internalRoutes.profession(row.profession.slug));
  revalidatePath(internalRoutes.topic(row.profession.slug, row.topic.slug));
  revalidatePath("/sitemap.xml");
  revalidatePath(internalRoutes.admin);
}

export async function approveQuestion(formData: FormData) {
  await review(formData, "approved");
}

export async function rejectQuestion(formData: FormData) {
  await review(formData, "rejected");
}
