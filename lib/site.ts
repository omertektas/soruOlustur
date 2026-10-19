import { INTERNAL_PREFIX, PUBLIC_PREFIX } from "./route-map";

export const siteConfig = {
  name: "Mülakat Defteri",
  shortDescription: "Yazılım ve mühendislik mülakat soruları",
  description:
    "Frontend, backend, full stack, oyun geliştirme, network, gömülü sistemler ve elektrik-elektronik mühendisliği mülakat soruları; kısa, net cevaplar ve örneklerle.",
  url: (process.env.NEXT_PUBLIC_SITE_URL ?? "https://www.oftechsolutions.com").replace(/\/+$/, ""),
  locale: "tr_TR",
  publisher: "OFTECHSOLUTIONS",
} as const;

export function absoluteUrl(path = "/"): string {
  return `${siteConfig.url}${path.startsWith("/") ? path : `/${path}`}`;
}

function buildRoutes(prefix: typeof PUBLIC_PREFIX) {
  return {
    home: "/",
    profession: (slug: string) => `${prefix.interviewQuestions}/${slug}`,
    topic: (professionSlug: string, topicSlug: string) => `${prefix.interviewQuestions}/${professionSlug}/${topicSlug}`,
    question: (slug: string) => `${prefix.question}/${slug}`,
    search: (q?: string) => (q ? `${prefix.search}?q=${encodeURIComponent(q)}` : prefix.search),
    login: (next?: string) => (next ? `${prefix.login}?next=${encodeURIComponent(next)}` : prefix.login),
    submit: prefix.submit,
    account: prefix.account,
    admin: prefix.admin,
    adminQuestions: (status?: string) => (status ? `${prefix.adminQuestions}?status=${status}` : prefix.adminQuestions),
    adminUsers: prefix.adminUsers,
    authCallback: "/auth/callback",
    signOut: "/auth/sign-out",
  };
}

/** URLs shown to users and search engines (links, canonical tags, sitemap). */
export const routes = buildRoutes(PUBLIC_PREFIX);

/** Route folder paths, used for cache revalidation. */
export const internalRoutes = buildRoutes(INTERNAL_PREFIX);
