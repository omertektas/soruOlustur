import { createBrowserClient } from "@supabase/ssr";

export function createBrowserSupabase() {
  // Tarayıcı paketine yalnızca NEXT_PUBLIC_ değişkenleri girer; burada doğrudan okunmalıdır.
  return createBrowserClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!
  );
}
