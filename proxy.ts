import type { NextRequest } from "next/server";
import { updateSession } from "@/lib/supabase/session";

export async function proxy(request: NextRequest) {
  return updateSession(request);
}

// Herkese açık sayfalar önbellekten hızlı sunulsun diye yalnızca oturum gereken yollarda çalışır.
export const config = {
  matcher: ["/giris", "/soru-ekle", "/hesabim", "/yonetim/:path*", "/auth/:path*"],
};
