"use client";

import Link from "next/link";
import { useEffect, useMemo, useState } from "react";
import { createBrowserSupabase } from "@/lib/supabase/browser";
import { routes } from "@/lib/site";

type MenuState =
  | { status: "loading" }
  | { status: "guest" }
  | { status: "user"; name: string; isAdmin: boolean };

/**
 * Reads the session in the browser so public pages can stay static and cached.
 */
export function UserMenu() {
  const supabase = useMemo(() => createBrowserSupabase(), []);
  const [state, setState] = useState<MenuState>({ status: "loading" });

  useEffect(() => {
    let active = true;

    async function load() {
      const {
        data: { user },
      } = await supabase.auth.getUser();
      if (!active) return;
      if (!user) {
        setState({ status: "guest" });
        return;
      }
      const { data } = await supabase.from("profiles").select("display_name, role").eq("id", user.id).maybeSingle();
      const profile = data as unknown as { display_name: string; role: string } | null;
      if (!active) return;
      setState({
        status: "user",
        name: profile?.display_name ?? user.email?.split("@")[0] ?? "Hesabım",
        isAdmin: profile?.role === "admin",
      });
    }

    load();
    const { data: sub } = supabase.auth.onAuthStateChange(() => {
      load();
    });
    return () => {
      active = false;
      sub.subscription.unsubscribe();
    };
  }, [supabase]);

  if (state.status === "loading") return <div className="usermenu" aria-hidden="true" />;

  if (state.status === "guest") {
    return (
      <div className="usermenu">
        <Link href={routes.login()} className="btn btn-ghost">
          Giriş yap
        </Link>
        <Link href={routes.submit} className="btn">
          Soru ekle
        </Link>
      </div>
    );
  }

  return (
    <div className="usermenu">
      {state.isAdmin && (
        <Link href={routes.admin} className="navlink">
          Yönetim
        </Link>
      )}
      <Link href={routes.account} className="navlink">
        {state.name}
      </Link>
      <Link href={routes.submit} className="btn">
        Soru ekle
      </Link>
    </div>
  );
}
