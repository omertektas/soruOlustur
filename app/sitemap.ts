import type { MetadataRoute } from "next";
import { getProfessions } from "@/lib/data/catalog";
import { listQuestionsForSitemap } from "@/lib/data/questions";
import { absoluteUrl, routes } from "@/lib/site";

export const revalidate = 3600;

export default async function sitemap(): Promise<MetadataRoute.Sitemap> {
  const [professions, questions] = await Promise.all([getProfessions(), listQuestionsForSitemap()]);

  const topicPages = new Map<string, string>();
  for (const q of questions) {
    const path = routes.topic(q.professionSlug, q.topicSlug);
    const prev = topicPages.get(path);
    if (!prev || prev < q.updatedAt) topicPages.set(path, q.updatedAt);
  }
  const latest = questions.reduce((max, q) => (q.updatedAt > max ? q.updatedAt : max), "");

  return [
    { url: absoluteUrl("/"), lastModified: latest || undefined, changeFrequency: "daily", priority: 1 },
    ...professions.map((p) => ({
      url: absoluteUrl(routes.profession(p.slug)),
      changeFrequency: "daily" as const,
      priority: 0.9,
    })),
    ...[...topicPages].map(([path, lastModified]) => ({
      url: absoluteUrl(path),
      lastModified,
      changeFrequency: "weekly" as const,
      priority: 0.8,
    })),
    ...questions.map((q) => ({
      url: absoluteUrl(routes.question(q.slug)),
      lastModified: q.updatedAt,
      changeFrequency: "monthly" as const,
      priority: 0.7,
    })),
  ];
}
