import type { CSSProperties } from "react";
import Link from "next/link";
import { JsonLd } from "@/components/JsonLd";
import { QuestionRow } from "@/components/QuestionRow";
import { getProfessionsWithCounts, getTopics } from "@/lib/data/catalog";
import { listLatestQuestions } from "@/lib/data/questions";
import { formatNumber } from "@/lib/format";
import { professionStyle } from "@/lib/profession-style";
import { websiteJsonLd } from "@/lib/seo";
import { routes } from "@/lib/site";

export const revalidate = 3600;

export default async function HomePage() {
  const [professions, latest, topics] = await Promise.all([getProfessionsWithCounts(), listLatestQuestions(8), getTopics()]);
  const total = professions.reduce((sum, p) => sum + p.questionCount, 0);

  return (
    <>
      <JsonLd data={websiteJsonLd()} />

      <section className="hero">
        <p className="hero-badge">Ücretsiz · Türkçe · Topluluk destekli</p>
        <h1>
          Mühendislik mülakatlarına <mark>hazırlıklı</mark> gir
        </h1>
        <p className="lede">
          Frontend, backend, full stack, yapay zeka, oyun geliştirme, network, gömülü sistemler ve elektrik-elektronik mühendisliği mülakatlarında sorulan sorular;
          kod örnekleri ve mülakat ipuçlarıyla birlikte, kısa ve net cevaplar.
        </p>
        <form action={routes.search()} method="get" className="hero-search" role="search">
          <input name="q" type="search" className="input input-lg" placeholder="Örn: closure, useEffect, JWT, index, volatile…" aria-label="Soru ara" />
          <button type="submit" className="btn btn-lg">
            Ara
          </button>
        </form>
        <ul className="hero-stats" aria-label="Site istatistikleri">
          <li>
            <strong>{formatNumber(total)}</strong>
            <span>soru ve cevap</span>
          </li>
          <li>
            <strong>{professions.length}</strong>
            <span>yazılım alanı</span>
          </li>
          <li>
            <strong>{topics.length}</strong>
            <span>konu başlığı</span>
          </li>
        </ul>
      </section>

      <section aria-labelledby="professions" className="section">
        <h2 id="professions" className="section-title">
          Alanına göre mülakat soruları
        </h2>
        <ul className="prof-grid">
          {professions.map((p) => {
            const badge = professionStyle(p.slug, p.shortName);
            return (
            <li key={p.slug}>
              <Link href={routes.profession(p.slug)} className="prof-card">
                <span className="prof-badge" style={{ "--badge": badge.color } as CSSProperties} aria-hidden="true">
                  {badge.code}
                </span>
                <span className="prof-name">{p.name}</span>
                <span className="prof-desc">{p.description}</span>
                <span className="prof-count">{p.questionCount} soru →</span>
              </Link>
            </li>
            );
          })}
        </ul>
      </section>

      <section aria-labelledby="latest" className="section">
        <h2 id="latest" className="section-title">
          Son eklenen sorular
        </h2>
        <ol className="qrows">
          {latest.map((q) => (
            <QuestionRow key={q.id} question={q} showProfession />
          ))}
        </ol>
      </section>

      <section className="cta">
        <div>
          <h2>Mülakatta karşılaştığın bir soru mu var?</h2>
          <p className="muted">
            Ekle, editörlerimiz kontrol ettikten sonra yayına alınsın. Diğer adaylar senin deneyiminden faydalansın.
          </p>
        </div>
        <Link href={routes.submit} className="btn btn-lg">
          Soru ekle
        </Link>
      </section>
    </>
  );
}
