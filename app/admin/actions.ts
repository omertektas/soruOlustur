"use server";

import { revalidatePath } from "next/cache";
import { requireAdmin } from "@/lib/auth";
import { reviewQuestion } from "@/lib/data/questions";
import { publishCatalogEntry } from "@/lib/data/suggestions";
import { internalRoutes } from "@/lib/site";
import { createServerSupabase } from "@/lib/supabase/server";

type ReviewedRow = {
  slug: string;
  profession: { id: number; slug: string; is_published: boolean };
  topic: { id: number; slug: string; is_published: boolean };
};

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
  const row = data as unknown as ReviewedRow;

  // Approving a question also publishes the profession/topic it suggested.
  let catalogChanged = false;
  if (decision === "approved") {
    if (!row.profession.is_published) {
      await publishCatalogEntry(supabase, "profession", row.profession.id);
      catalogChanged = true;
    }
    if (!row.topic.is_published) {
      await publishCatalogEntry(supabase, "topic", row.topic.id);
      catalogChanged = true;
    }
  }

  // Refresh every cached page that lists or shows this question.
  // A new profession also appears in the footer of every page, so refresh the whole layout.
  revalidatePath(internalRoutes.home, catalogChanged ? "layout" : "page");
  revalidatePath(internalRoutes.question(row.slug));
  revalidatePath(internalRoutes.profession(row.profession.slug));
  revalidatePath(internalRoutes.topic(row.profession.slug, row.topic.slug));
  revalidatePath("/sitemap.xml");
  revalidatePath(internalRoutes.admin);
  revalidatePath(internalRoutes.adminQuestions());
}

export async function approveQuestion(formData: FormData) {
  await review(formData, "approved");
}

export async function rejectQuestion(formData: FormData) {
  await review(formData, "rejected");
}
