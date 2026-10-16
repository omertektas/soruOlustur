"use client";

import { useActionState, useState } from "react";
import { signIn, signUp, type AuthState } from "./actions";

export function LoginForm({ next, initialError }: { next: string; initialError?: string }) {
  const [mode, setMode] = useState<"login" | "register">("login");
  const [loginState, loginAction, loginPending] = useActionState<AuthState, FormData>(signIn, {
    error: initialError,
  });
  const [registerState, registerAction, registerPending] = useActionState<AuthState, FormData>(signUp, {});

  const state = mode === "login" ? loginState : registerState;
  const pending = mode === "login" ? loginPending : registerPending;

  return (
    <div className="auth-card">
      <div className="tabs-inline" role="tablist">
        <button type="button" role="tab" aria-selected={mode === "login"} onClick={() => setMode("login")}>
          Giriş yap
        </button>
        <button type="button" role="tab" aria-selected={mode === "register"} onClick={() => setMode("register")}>
          Kayıt ol
        </button>
      </div>

      {state.message ? (
        <p className="notice notice-success" role="status">
          {state.message}
        </p>
      ) : (
        <form action={mode === "login" ? loginAction : registerAction} className="form" key={mode}>
          <input type="hidden" name="next" value={next} />
          {mode === "register" && (
            <div className="field">
              <label htmlFor="displayName">Görünen ad</label>
              <input id="displayName" name="displayName" className="input" autoComplete="nickname" required minLength={2} maxLength={40} />
              <small className="muted">Eklediğin soruların altında bu ad görünür.</small>
            </div>
          )}
          <div className="field">
            <label htmlFor="email">E-posta</label>
            <input id="email" name="email" type="email" className="input" autoComplete="email" required defaultValue={state.email} />
          </div>
          <div className="field">
            <label htmlFor="password">Şifre</label>
            <input
              id="password"
              name="password"
              type="password"
              className="input"
              autoComplete={mode === "login" ? "current-password" : "new-password"}
              required
              minLength={mode === "register" ? 8 : undefined}
            />
            {mode === "register" && <small className="muted">En az 8 karakter.</small>}
          </div>
          {state.error && (
            <p className="notice notice-error" role="alert">
              {state.error}
            </p>
          )}
          <button type="submit" className="btn btn-lg btn-block" disabled={pending}>
            {pending ? "Lütfen bekleyin…" : mode === "login" ? "Giriş yap" : "Hesap oluştur"}
          </button>
        </form>
      )}
    </div>
  );
}
