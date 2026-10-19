"use client";

import { usePathname } from "next/navigation";
import { useEffect } from "react";
import { PUBLIC_PREFIX } from "@/lib/route-map";
import { createBrowserSupabase } from "@/lib/supabase/browser";

const LAST_VISIT_KEY = "md-last-visit-day";

/** True on the visitor's first page view of the day (Istanbul time). Stored in localStorage, no cookies. */
function isFirstViewToday(): boolean {
  try {
    const today = new Date().toLocaleDateString("en-CA", { timeZone: "Europe/Istanbul" });
    if (localStorage.getItem(LAST_VISIT_KEY) === today) return false;
    localStorage.setItem(LAST_VISIT_KEY, today);
    return true;
  } catch {
    return false;
  }
}

/**
 * Counts one page view per navigation. Only the path and a daily "new visitor" flag are sent;
 * no IP address, cookie or user id is stored. Admin pages and automated browsers are skipped.
 */
export function PageViewTracker() {
  const pathname = usePathname();

  useEffect(() => {
    // The browser URL is the public (Turkish) path, even when Next.js rewrote it internally.
    const path = window.location.pathname;
    if (path.startsWith(PUBLIC_PREFIX.admin) || navigator.webdriver) return;

    createBrowserSupabase()
      .rpc("track_page_view", { p_path: path, p_new_visitor: isFirstViewToday() })
      .then(
        () => undefined,
        () => undefined
      );
  }, [pathname]);

  return null;
}
