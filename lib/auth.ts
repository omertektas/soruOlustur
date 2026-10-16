import "server-only";
import { redirect } from "next/navigation";
import { routes } from "./site";
import { createServerSupabase } from "./supabase/server";
import type { SessionUser, UserRole } from "./types";

export async function getSessionUser(): Promise<SessionUser | null> {
  const supabase = await createServerSupabase();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) return null;

  const { data: profile } = await supabase
    .from("profiles")
    .select("display_name, role")
    .eq("id", user.id)
    .maybeSingle();

  const p = profile as unknown as { display_name: string; role: UserRole } | null;
  return {
    id: user.id,
    email: user.email ?? null,
    displayName: p?.display_name ?? user.email?.split("@")[0] ?? "Kullanıcı",
    role: p?.role ?? "user",
  };
}

export async function requireUser(nextPath: string): Promise<SessionUser> {
  const user = await getSessionUser();
  if (!user) redirect(routes.login(nextPath));
  return user;
}

export async function requireAdmin(): Promise<SessionUser> {
  const user = await requireUser(routes.admin);
  if (user.role !== "admin") redirect(routes.home);
  return user;
}
