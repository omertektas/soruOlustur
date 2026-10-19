/**
 * Public (Turkish, SEO-friendly) URL prefixes mapped to their internal route folders.
 *
 * The app/ directory uses English folder names. next.config.ts rewrites each public
 * prefix to its internal route and permanently redirects the internal prefix to the
 * public one, so every page is reachable at exactly one URL.
 */
export const ROUTES = {
  interviewQuestions: { public: "/mulakat-sorulari", internal: "/interview-questions" },
  question: { public: "/soru", internal: "/questions" },
  search: { public: "/ara", internal: "/search" },
  login: { public: "/giris", internal: "/login" },
  submit: { public: "/soru-ekle", internal: "/submit" },
  account: { public: "/hesabim", internal: "/account" },
  admin: { public: "/yonetim", internal: "/admin" },
  adminQuestions: { public: "/yonetim/sorular", internal: "/admin/questions" },
  adminUsers: { public: "/yonetim/kullanicilar", internal: "/admin/users" },
} as const;

export type RouteKey = keyof typeof ROUTES;

const pick = (side: "public" | "internal") =>
  Object.fromEntries(Object.entries(ROUTES).map(([key, route]) => [key, route[side]])) as Record<RouteKey, string>;

export const PUBLIC_PREFIX = pick("public");
export const INTERNAL_PREFIX = pick("internal");

/** Route pairs ordered so nested prefixes (e.g. /yonetim/sorular) match before their parents. */
export function routePairsBy(side: "public" | "internal") {
  return Object.values(ROUTES).sort((a, b) => b[side].length - a[side].length);
}
