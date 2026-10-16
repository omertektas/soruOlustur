import type { Metadata } from "next";
import { absoluteUrl, siteConfig } from "./site";
import type { QuestionDetail } from "./types";
import { markdownToPlain } from "./markdown";

interface PageMetaInput {
  title: string;
  description: string;
  path: string;
  noIndex?: boolean;
}

/** Consistent title, description, canonical and Open Graph tags for every page. */
export function pageMetadata({ title, description, path, noIndex }: PageMetaInput): Metadata {
  return {
    title,
    description,
    alternates: { canonical: path },
    openGraph: {
      title,
      description,
      url: absoluteUrl(path),
      siteName: siteConfig.name,
      locale: siteConfig.locale,
      type: "website",
    },
    twitter: { card: "summary_large_image", title, description },
    robots: noIndex ? { index: false, follow: true } : undefined,
  };
}

export interface Crumb {
  name: string;
  path: string;
}

export function breadcrumbJsonLd(crumbs: Crumb[]) {
  return {
    "@context": "https://schema.org",
    "@type": "BreadcrumbList",
    itemListElement: crumbs.map((c, i) => ({
      "@type": "ListItem",
      position: i + 1,
      name: c.name,
      item: absoluteUrl(c.path),
    })),
  };
}

export function questionJsonLd(q: QuestionDetail, path: string) {
  const author = q.authorName
    ? { "@type": "Person", name: q.authorName }
    : { "@type": "Organization", name: siteConfig.name, url: siteConfig.url };
  return {
    "@context": "https://schema.org",
    "@type": "QAPage",
    url: absoluteUrl(path),
    inLanguage: "tr-TR",
    mainEntity: {
      "@type": "Question",
      name: q.title,
      text: q.title,
      answerCount: 1,
      dateCreated: q.createdAt,
      author,
      acceptedAnswer: {
        "@type": "Answer",
        text: markdownToPlain(q.answer, 5000),
        dateCreated: q.createdAt,
        url: absoluteUrl(path),
        author,
      },
    },
  };
}

export function websiteJsonLd() {
  return {
    "@context": "https://schema.org",
    "@type": "WebSite",
    name: siteConfig.name,
    url: siteConfig.url,
    inLanguage: "tr-TR",
    publisher: { "@type": "Organization", name: siteConfig.publisher, url: siteConfig.url },
    potentialAction: {
      "@type": "SearchAction",
      target: { "@type": "EntryPoint", urlTemplate: `${siteConfig.url}/ara?q={search_term_string}` },
      "query-input": "required name=search_term_string",
    },
  };
}
