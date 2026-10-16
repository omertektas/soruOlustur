import Link from "next/link";
import { JsonLd } from "@/components/JsonLd";
import { QuestionRow } from "@/components/QuestionRow";
import { getProfessionsWithCounts } from "@/lib/data/catalog";
import { listLatestQuestions } from "@/lib/data/questions";
import { websiteJsonLd } from "@/lib/seo";
import { routes } from "@/lib/site";

export const revalidate = 3600;

export default async function HomePage() {
  const [professions, latest] = await Promise.all([getProfessionsWithCounts(), listLatestQuestions(8)]);
  const total = professions.reduce((sum, p) => sum + p.questionCount, 0);

  return (
    <>
      <JsonLd data={websiteJsonLd()} />

      <section className="hero">
        <p className="eyebrow">{total} soru · {professions.length} meslek</p>
        <h1>
          Yazılım ve mühendislik <mark>mülakat soruları</mark>
        </h1>
        <p className="lede">
          Frontend&apos;den gömülü sistemlere, network&apos;ten elektrik-elektronik mühendisliğine kadar mülakatlarda en
          sık sorulan sorular ve kısa, net cevapları. Mesleğini seç, kendini sına.
        </p>
        <form action={routes.search()} method="get" className="hero-search" role="search">
          <input name="q" type="search" className="input input-lg" placeholder="Örn: closure, OSI, op-amp, volatile…" aria-label="Soru ara" />
          <button type="submit" className="btn btn-lg">
            Ara
          </button>
        </form>
      </section>

      <section aria-labelledby="professions" className="section">
        <h2 id="professions" className="section-title">
          Mesleğe göre mülakat soruları
        </h2>
        <ul className="prof-grid">
          {professions.map((p) => (
            <li key={p.slug}>
              <Link href={routes.profession(p.slug)} className="prof-card">
                <span className="prof-name">{p.name}</span>
                <span className="prof-desc">{p.description}</span>
                <span className="prof-count">{p.questionCount} soru →</span>
              </Link>
            </li>
          ))}
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
