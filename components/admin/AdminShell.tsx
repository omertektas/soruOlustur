import Link from "next/link";
import type { ReactNode } from "react";
import { countPendingQuestions } from "@/lib/data/questions";
import { routes } from "@/lib/site";
import { createServerSupabase } from "@/lib/supabase/server";

export type AdminSection = "overview" | "questions" | "users";

/** Shared frame for every admin page: title and section tabs (with the pending-question badge). */
export async function AdminShell({ active, title, children }: { active: AdminSection; title: string; children: ReactNode }) {
  const pending = await countPendingQuestions(await createServerSupabase());
  const tabs: { key: AdminSection; label: string; href: string; badge?: number }[] = [
    { key: "overview", label: "Genel bakış", href: routes.admin },
    { key: "questions", label: "Sorular", href: routes.adminQuestions(), badge: pending },
    { key: "users", label: "Kullanıcılar", href: routes.adminUsers },
  ];

  return (
    <div className="admin">
      <header className="admin-head">
        <p className="eyebrow">Yönetim paneli</p>
        <h1>{title}</h1>
      </header>
      <nav className="admin-tabs" aria-label="Yönetim bölümleri">
        {tabs.map((t) => (
          <Link key={t.key} href={t.href} className="admin-tab" aria-current={t.key === active ? "page" : undefined}>
            {t.label}
            {t.badge ? <span className="admin-badge">{t.badge}</span> : null}
          </Link>
        ))}
      </nav>
      {children}
    </div>
  );
}

export function StatTile({
  label,
  value,
  note,
  tone,
  href,
}: {
  label: string;
  value: string;
  note?: string;
  tone?: "attention";
  href?: string;
}) {
  const body = (
    <>
      <span className="stat-label">{label}</span>
      <span className="stat-value">{value}</span>
      {note && <span className="stat-note">{note}</span>}
    </>
  );
  const className = `stat${tone === "attention" ? " stat-attention" : ""}`;
  return href ? (
    <Link href={href} className={`${className} stat-link`}>
      {body}
    </Link>
  ) : (
    <div className={className}>{body}</div>
  );
}
