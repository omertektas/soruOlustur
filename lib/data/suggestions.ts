import "server-only";
import { slugify } from "../slug";
import type { ServerSupabase } from "../supabase/server";
import type { CatalogChoice } from "../validation";

/*
 * Community suggestions for new professions and topics.
 * Suggestions are created unpublished through security-definer database functions
 * (suggest_profession / suggest_topic) and published when an admin approves a question.
 */

export type CatalogKind = "profession" | "topic";

const SUGGEST_FUNCTION: Record<CatalogKind, string> = {
  profession: "suggest_profession",
  topic: "suggest_topic",
};

const TABLE: Record<CatalogKind, string> = {
  profession: "professions",
  topic: "topics",
};

export class SuggestionError extends Error {
  constructor(public readonly code: "INVALID_NAME" | "SUGGESTION_LIMIT" | "UNKNOWN") {
    super(code);
  }
}

/** Returns the id for an existing choice, or the id of the (possibly new) suggested entry. */
export async function resolveCatalogChoice(
  supabase: ServerSupabase,
  kind: CatalogKind,
  choice: CatalogChoice
): Promise<number> {
  if (choice.kind === "existing") return choice.id;

  const slug = slugify(choice.name);
  if (!slug) throw new SuggestionError("INVALID_NAME");

  const { data, error } = await supabase.rpc(SUGGEST_FUNCTION[kind], { p_slug: slug, p_name: choice.name });
  if (error) {
    if (error.message.includes("SUGGESTION_LIMIT")) throw new SuggestionError("SUGGESTION_LIMIT");
    if (error.message.includes("INVALID_NAME")) throw new SuggestionError("INVALID_NAME");
    throw new SuggestionError("UNKNOWN");
  }
  return Number(data);
}

/** Makes a suggested profession or topic public (admin only, enforced by RLS). */
export async function publishCatalogEntry(supabase: ServerSupabase, kind: CatalogKind, id: number) {
  const { error } = await supabase.from(TABLE[kind]).update({ is_published: true }).eq("id", id);
  if (error) throw error;
}
