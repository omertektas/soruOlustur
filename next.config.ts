import type { NextConfig } from "next";
import { ROUTE_MAP } from "./lib/route-map";

const nextConfig: NextConfig = {
  poweredByHeader: false,

  // Serve the Turkish public URLs from the English route folders.
  async rewrites() {
    return ROUTE_MAP.flatMap(({ public: from, internal: to }) => [
      { source: from, destination: to },
      { source: `${from}/:path*`, destination: `${to}/:path*` },
    ]);
  },

  // Keep a single canonical URL per page: internal paths redirect to the public ones.
  async redirects() {
    return ROUTE_MAP.flatMap(({ public: to, internal: from }) => [
      { source: from, destination: to, permanent: true },
      { source: `${from}/:path*`, destination: `${to}/:path*`, permanent: true },
    ]);
  },

  async headers() {
    return [
      {
        source: "/:path*",
        headers: [
          { key: "X-Content-Type-Options", value: "nosniff" },
          { key: "Referrer-Policy", value: "strict-origin-when-cross-origin" },
          { key: "X-Frame-Options", value: "SAMEORIGIN" },
        ],
      },
    ];
  },
};

export default nextConfig;
