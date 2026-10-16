"use server";

import { revalidatePath } from "next/cache";
import { requireAdmin } from "@/lib/auth";
import { reviewQuestion } from "@/lib/data/questions";
import { routes } from "@/lib/site";
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

  // Yayına giren veya kaldırılan sorunun göründüğü tüm sayfaları yenile
  const row = data as unknown as { slug: string; profession: { slug: string }; topic: { slug: string } };
  revalidatePath(routes.home);
  revalidatePath(routes.question(row.slug));
  revalidatePath(routes.profession(row.profession.slug));
  revalidatePath(routes.topic(row.profession.slug, row.topic.slug));
  revalidatePath("/sitemap.xml");
  revalidatePath(routes.admin);
}

export async function approveQuestion(formData: FormData) {
  await review(formData, "approved");
}

export async function rejectQuestion(formData: FormData) {
  await review(formData, "rejected");
}
