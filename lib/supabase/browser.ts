import { createBrowserClient } from "@supabase/ssr";

export function createBrowserSupabase() {
  // Only NEXT_PUBLIC_ variables are inlined into the browser bundle, so read them directly here.
  return createBrowserClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!
  );
}
