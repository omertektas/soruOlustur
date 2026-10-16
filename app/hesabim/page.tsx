import type { Metadata } from "next";
import Link from "next/link";
import { DifficultyBadge } from "@/components/DifficultyBadge";
import { requireUser } from "@/lib/auth";
import { listOwnQuestions } from "@/lib/data/questions";
import { pageMetadata } from "@/lib/seo";
import { routes } from "@/lib/site";
import { createServerSupabase } from "@/lib/supabase/server";
import { STATUS_LABELS } from "@/lib/types";

export const metadata: Metadata = pageMetadata({
  title: "Hesabım",
  description: "Eklediğin sorular ve onay durumları.",
  path: routes.account,
  noIndex: true,
});

export default async function AccountPage() {
  const user = await requireUser(routes.account);
  const questions = await listOwnQuestions(await createServerSupabase(), user.id);

  return (
    <div className="narrow">
      <header className="page-head row-between">
        <div>
          <h1>Merhaba, {user.displayName}</h1>
          <p className="muted">{user.email}</p>
        </div>
        <form action="/auth/cikis" method="post">
          <button type="submit" className="btn btn-ghost">
            Çıkış yap
          </button>
        </form>
      </header>

      <section className="section">
        <div className="row-between">
          <h2 className="section-title">Eklediğin sorular</h2>
          <Link href={routes.submit} className="btn">
            Yeni soru
          </Link>
        </div>
        {questions.length === 0 ? (
          <p className="empty">Henüz soru eklemedin.</p>
        ) : (
          <ul className="own-list">
            {questions.map((q) => (
              <li key={q.id} className="own-item">
                <div className="own-main">
                  {q.status === "approved" ? (
                    <Link href={routes.question(q.slug)} className="own-title">
                      {q.title}
                    </Link>
                  ) : (
                    <span className="own-title">{q.title}</span>
                  )}
                  <span className="qrow-meta">
                    <DifficultyBadge value={q.difficulty} />
                    <span>{q.profession.shortName}</span>
                    <span>{q.topic.name}</span>
                  </span>
                  {q.status === "rejected" && q.rejectionReason && (
                    <p className="small muted">Ret nedeni: {q.rejectionReason}</p>
                  )}
                </div>
                <span className={`status status-${q.status}`}>{STATUS_LABELS[q.status]}</span>
              </li>
            ))}
          </ul>
        )}
      </section>
    </div>
  );
}
