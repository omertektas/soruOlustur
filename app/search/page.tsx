import type { Metadata } from "next";
import { QuestionRow } from "@/components/QuestionRow";
import { searchApprovedQuestions } from "@/lib/data/questions";
import { pageMetadata } from "@/lib/seo";
import { routes } from "@/lib/site";

export const metadata: Metadata = pageMetadata({
  title: "Soru ara",
  description: "Mülakat Defteri'ndeki tüm meslek ve konulardaki sorular arasında arama yapın.",
  path: routes.search(),
  noIndex: true,
});

type Props = { searchParams: Promise<{ q?: string | string[] }> };

export default async function SearchPage({ searchParams }: Props) {
  const raw = (await searchParams).q;
  const q = (Array.isArray(raw) ? raw[0] : raw ?? "").trim();
  const results = q ? await searchApprovedQuestions(q) : [];

  return (
    <>
      <header className="page-head">
        <h1>Soru ara</h1>
        <form action={routes.search()} method="get" className="hero-search" role="search">
          <input
            name="q"
            type="search"
            className="input input-lg"
            defaultValue={q}
            placeholder="Örn: closure, OSI, op-amp, volatile…"
            aria-label="Soru ara"
          />
          <button type="submit" className="btn btn-lg">
            Ara
          </button>
        </form>
      </header>
      {q && (
        <p className="muted">
          <strong>{q}</strong> için {results.length} sonuç
        </p>
      )}
      {results.length > 0 && (
        <ol className="qrows">
          {results.map((r) => (
            <QuestionRow key={r.id} question={r} showProfession />
          ))}
        </ol>
      )}
      {q && results.length === 0 && (
        <p className="empty">Sonuç bulunamadı. Daha kısa veya farklı bir kelimeyle deneyin.</p>
      )}
    </>
  );
}
