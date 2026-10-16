import { createClient } from "@supabase/supabase-js";
import { getSupabaseEnv } from "./env";

/**
 * Çerez kullanmayan, yalnızca herkese açık veriyi okuyan istemci.
 * Statik / ISR sayfalarda kullanılır; böylece sayfalar önbelleğe alınabilir.
 */
export function createPublicSupabase() {
  const { url, anonKey } = getSupabaseEnv();
  return createClient(url, anonKey, {
    auth: { persistSession: false, autoRefreshToken: false, detectSessionInUrl: false },
  });
}
