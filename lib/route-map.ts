/**
 * Public (Turkish, SEO-friendly) URL prefixes mapped to their internal route folders.
 *
 * The app/ directory uses English folder names. next.config.ts rewrites each public
 * prefix to its internal route and permanently redirects the internal prefix to the
 * public one, so every page is reachable at exactly one URL.
 */
export const ROUTE_MAP = [
  { public: "/mulakat-sorulari", internal: "/interview-questions" },
  { public: "/soru", internal: "/questions" },
  { public: "/ara", internal: "/search" },
  { public: "/giris", internal: "/login" },
  { public: "/soru-ekle", internal: "/submit" },
  { public: "/hesabim", internal: "/account" },
  { public: "/yonetim", internal: "/admin" },
] as const;

type RouteKey = "interviewQuestions" | "question" | "search" | "login" | "submit" | "account" | "admin";

const KEYS: RouteKey[] = ["interviewQuestions", "question", "search", "login", "submit", "account", "admin"];

export const PUBLIC_PREFIX = Object.fromEntries(KEYS.map((k, i) => [k, ROUTE_MAP[i].public])) as Record<RouteKey, string>;
export const INTERNAL_PREFIX = Object.fromEntries(KEYS.map((k, i) => [k, ROUTE_MAP[i].internal])) as Record<RouteKey, string>;
