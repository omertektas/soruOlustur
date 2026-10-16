"use server";

import { redirect } from "next/navigation";
import { absoluteUrl, routes } from "@/lib/site";
import { createServerSupabase } from "@/lib/supabase/server";
import { safeNextPath } from "@/lib/validation";

export type AuthState = { error?: string; message?: string; email?: string };

const EMAIL_RE = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

function readCredentials(formData: FormData) {
  return {
    email: String(formData.get("email") ?? "").trim().toLowerCase(),
    password: String(formData.get("password") ?? ""),
    next: safeNextPath(formData.get("next"), routes.submit),
  };
}

export async function signIn(_prev: AuthState, formData: FormData): Promise<AuthState> {
  const { email, password, next } = readCredentials(formData);
  if (!EMAIL_RE.test(email) || !password) return { error: "E-posta ve şifrenizi girin.", email };

  const supabase = await createServerSupabase();
  const { error } = await supabase.auth.signInWithPassword({ email, password });
  if (error) {
    const unconfirmed = error.message.toLowerCase().includes("confirm");
    return {
      error: unconfirmed
        ? "E-posta adresiniz henüz doğrulanmamış. Gelen kutunuzdaki bağlantıya tıklayın."
        : "E-posta veya şifre hatalı.",
      email,
    };
  }
  redirect(next);
}

export async function signUp(_prev: AuthState, formData: FormData): Promise<AuthState> {
  const { email, password, next } = readCredentials(formData);
  const displayName = String(formData.get("displayName") ?? "").trim().slice(0, 40);

  if (displayName.length < 2) return { error: "Görünen adınız en az 2 karakter olmalı.", email };
  if (!EMAIL_RE.test(email)) return { error: "Geçerli bir e-posta adresi girin.", email };
  if (password.length < 8) return { error: "Şifre en az 8 karakter olmalı.", email };

  const supabase = await createServerSupabase();
  const { data, error } = await supabase.auth.signUp({
    email,
    password,
    options: {
      data: { display_name: displayName },
      emailRedirectTo: absoluteUrl(`${routes.authCallback}?next=${encodeURIComponent(next)}`),
    },
  });
  if (error) {
    return {
      error: error.message.toLowerCase().includes("registered")
        ? "Bu e-posta ile zaten bir hesap var. Giriş yapmayı deneyin."
        : "Kayıt sırasında bir sorun oluştu. Lütfen tekrar deneyin.",
      email,
    };
  }

  // When email confirmation is disabled, Supabase returns a session right away.
  if (data.session) redirect(next);

  return {
    message: `${email} adresine bir doğrulama bağlantısı gönderdik. Bağlantıya tıkladıktan sonra giriş yapabilirsiniz.`,
    email,
  };
}
