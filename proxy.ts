import type { NextRequest } from "next/server";
import { updateSession } from "@/lib/supabase/session";

export async function proxy(request: NextRequest) {
  return updateSession(request);
}

// Runs only on routes that need a session, so public pages stay fully cacheable.
// Matchers use the public (Turkish) URLs because the proxy runs before rewrites.
export const config = {
  matcher: ["/giris", "/soru-ekle", "/hesabim", "/yonetim/:path*", "/auth/:path*"],
};
