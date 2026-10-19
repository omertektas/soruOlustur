import "server-only";
import type { ServerSupabase } from "../supabase/server";
import type { UserRole } from "../types";
import { rows } from "./mappers";

/*
 * Admin-only statistics. Every function calls a security-definer database function
 * that raises ADMIN_ONLY unless the signed-in user has the admin role.
 */

export interface AdminOverview {
  questionsPublished: number;
  questionsPending: number;
  usersTotal: number;
  usersLast7Days: number;
  viewsToday: number;
  visitorsToday: number;
  views30Days: number;
  visitors30Days: number;
}

export interface TrafficDay {
  /** ISO date, YYYY-MM-DD (Europe/Istanbul) */
  day: string;
  views: number;
  visitors: number;
}

export interface TopPage {
  path: string;
  views: number;
  visitors: number;
}

export interface AdminUser {
  id: string;
  email: string;
  displayName: string;
  role: UserRole;
  createdAt: string;
  lastSignInAt: string | null;
  emailConfirmed: boolean;
  approvedQuestions: number;
  pendingQuestions: number;
}

export async function getAdminOverview(supabase: ServerSupabase): Promise<AdminOverview> {
  const { data, error } = await supabase.rpc("admin_overview");
  if (error) throw error;
  const o = (data ?? {}) as Record<string, number>;
  return {
    questionsPublished: Number(o.questions_published ?? 0),
    questionsPending: Number(o.questions_pending ?? 0),
    usersTotal: Number(o.users_total ?? 0),
    usersLast7Days: Number(o.users_last_7_days ?? 0),
    viewsToday: Number(o.views_today ?? 0),
    visitorsToday: Number(o.visitors_today ?? 0),
    views30Days: Number(o.views_30_days ?? 0),
    visitors30Days: Number(o.visitors_30_days ?? 0),
  };
}

export async function getTraffic(supabase: ServerSupabase, days: number): Promise<TrafficDay[]> {
  const { data, error } = await supabase.rpc("admin_traffic", { p_days: days });
  if (error) throw error;
  return rows<{ day: string; views: number; visitors: number }>(data).map((r) => ({
    day: r.day,
    views: Number(r.views),
    visitors: Number(r.visitors),
  }));
}

export async function getTopPages(supabase: ServerSupabase, days: number, limit: number): Promise<TopPage[]> {
  const { data, error } = await supabase.rpc("admin_top_pages", { p_days: days, p_limit: limit });
  if (error) throw error;
  return rows<{ path: string; views: number; visitors: number }>(data).map((r) => ({
    path: r.path,
    views: Number(r.views),
    visitors: Number(r.visitors),
  }));
}

export async function listUsers(supabase: ServerSupabase): Promise<AdminUser[]> {
  const { data, error } = await supabase.rpc("admin_list_users");
  if (error) throw error;
  type Row = {
    id: string;
    email: string;
    display_name: string;
    role: UserRole;
    created_at: string;
    last_sign_in_at: string | null;
    email_confirmed: boolean;
    approved_questions: number;
    pending_questions: number;
  };
  return rows<Row>(data).map((r) => ({
    id: r.id,
    email: r.email,
    displayName: r.display_name,
    role: r.role,
    createdAt: r.created_at,
    lastSignInAt: r.last_sign_in_at,
    emailConfirmed: r.email_confirmed,
    approvedQuestions: Number(r.approved_questions),
    pendingQuestions: Number(r.pending_questions),
  }));
}
