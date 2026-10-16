import type { Metadata } from "next";
import Link from "next/link";
import { DifficultyBadge } from "@/components/DifficultyBadge";
import { requireAdmin } from "@/lib/auth";
import { listQuestionsByStatus } from "@/lib/data/questions";
import { Markdown } from "@/lib/markdown";
import { pageMetadata } from "@/lib/seo";
import { routes } from "@/lib/site";
import { createServerSupabase } from "@/lib/supabase/server";
import { STATUS_LABELS, type QuestionStatus } from "@/lib/types";
import { approveQuestion, rejectQuestion } from "./actions";

export const metadata: Metadata = pageMetadata({
  title: "Yönetim",
  description: "Soru onay paneli",
  path: routes.admin,
  noIndex: true,
});

const TABS: QuestionStatus[] = ["pending", "approved", "rejected"];
const dateFormat = new Intl.DateTimeFormat("tr-TR", { dateStyle: "medium", timeStyle: "short" });

type Props = { searchParams: Promise<{ status?: string }> };

export default async function AdminPage({ searchParams }: Props) {
  await requireAdmin();
  const { status: statusParam } = await searchParams;
  const status: QuestionStatus = TABS.includes(statusParam as QuestionStatus) ? (statusParam as QuestionStatus) : "pending";
  const questions = await listQuestionsByStatus(await createServerSupabase(), status);

  return (
    <>
      <header className="page-head">
        <h1>Soru onay paneli</h1>
        <nav className="chips" aria-label="Durum">
          {TABS.map((t) => (
            <Link key={t} href={`${routes.admin}?status=${t}`} className="chip" aria-pressed={t === status}>
              {STATUS_LABELS[t]}
            </Link>
          ))}
        </nav>
      </header>

      {questions.length === 0 ? (
        <p className="empty">Bu listede soru yok.</p>
      ) : (
        <ul className="review-list">
          {questions.map((q) => (
            <li key={q.id} className="review-card">
              <div className="review-head">
                <div className="qrow-meta">
                  <DifficultyBadge value={q.difficulty} />
                  <span>{q.profession.name}</span>
                  <span>{q.topic.name}</span>
                  <span>· {q.authorName ?? "Editör"}</span>
                  <span>· {dateFormat.format(new Date(q.createdAt))}</span>
                </div>
                <h2>{q.title}</h2>
                {(q.suggestsNewProfession || q.suggestsNewTopic) && (
                  <p className="suggestion-note">
                    Bu soru yeni {q.suggestsNewProfession && <strong>meslek: {q.profession.name}</strong>}
                    {q.suggestsNewProfession && q.suggestsNewTopic && " ve "}
                    {q.suggestsNewTopic && <strong>konu: {q.topic.name}</strong>} öneriyor. Onaylarsan bunlar da
                    yayına alınır ve kendi sayfaları oluşur.
                  </p>
                )}
              </div>
              <Markdown source={q.answer} />
              {q.tip && (
                <aside className="tip">
                  <strong>İpucu:</strong> {q.tip}
                </aside>
              )}
              {q.status === "rejected" && q.rejectionReason && <p className="small muted">Ret nedeni: {q.rejectionReason}</p>}

              <div className="review-actions">
                {q.status !== "approved" && (
                  <form action={approveQuestion}>
                    <input type="hidden" name="id" value={q.id} />
                    <button type="submit" className="btn">
                      Onayla ve yayınla
                    </button>
                  </form>
                )}
                {q.status !== "rejected" && (
                  <form action={rejectQuestion} className="reject-form">
                    <input type="hidden" name="id" value={q.id} />
                    <input
                      name="reason"
                      className="input"
                      placeholder="Ret nedeni (kullanıcıya gösterilir)"
                      aria-label="Ret nedeni"
                      maxLength={300}
                    />
                    <button type="submit" className="btn btn-danger">
                      {q.status === "approved" ? "Yayından kaldır" : "Reddet"}
                    </button>
                  </form>
                )}
                {q.status === "approved" && (
                  <Link href={routes.question(q.slug)} className="btn btn-ghost">
                    Sayfayı aç
                  </Link>
                )}
              </div>
            </li>
          ))}
        </ul>
      )}
    </>
  );
}
