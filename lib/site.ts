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

export const routes = {
  home: "/",
  profession: (slug: string) => `/mulakat-sorulari/${slug}`,
  topic: (professionSlug: string, topicSlug: string) => `/mulakat-sorulari/${professionSlug}/${topicSlug}`,
  question: (slug: string) => `/soru/${slug}`,
  search: (q?: string) => (q ? `/ara?q=${encodeURIComponent(q)}` : "/ara"),
  login: (next?: string) => (next ? `/giris?next=${encodeURIComponent(next)}` : "/giris"),
  submit: "/soru-ekle",
  account: "/hesabim",
  admin: "/yonetim",
} as const;
