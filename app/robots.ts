import type { MetadataRoute } from "next";
import { absoluteUrl, routes, siteConfig } from "@/lib/site";

export default function robots(): MetadataRoute.Robots {
  return {
    rules: {
      userAgent: "*",
      allow: "/",
      disallow: [routes.admin, routes.account, routes.submit, routes.login(), routes.search(), "/auth/"],
    },
    sitemap: absoluteUrl("/sitemap.xml"),
    host: siteConfig.url,
  };
}
