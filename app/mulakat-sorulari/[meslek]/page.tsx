import type { Metadata } from "next";
import Link from "next/link";
import { notFound } from "next/navigation";
import { Breadcrumbs } from "@/components/Breadcrumbs";
import { QuestionList } from "@/components/QuestionList";
import { getProfessionBySlug, getTopicsForProfession } from "@/lib/data/catalog";
import { listApprovedQuestions } from "@/lib/data/questions";
import { pageMetadata } from "@/lib/seo";
import { routes } from "@/lib/site";

export const revalidate = 3600;

type Props = { params: Promise<{ meslek: string }> };

export async function generateStaticParams() {
  return []; // İlk ziyarette üretilir, sonra önbellekten sunulur (ISR)
}

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const { meslek } = await params;
  const profession = await getProfessionBySlug(meslek);
  if (!profession) return {};
  return pageMetadata({
    title: `${profession.name} Mülakat Soruları ve Cevapları`,
    description: profession.description,
    path: routes.profession(profession.slug),
  });
}

export default async function ProfessionPage({ params }: Props) {
  const { meslek } = await params;
  const profession = await getProfessionBySlug(meslek);
  if (!profession) notFound();

  const [topics, questions] = await Promise.all([
    getTopicsForProfession(profession.id),
    listApprovedQuestions({ professionId: profession.id }),
  ]);

  return (
    <>
      <Breadcrumbs
        items={[
          { name: "Ana sayfa", path: routes.home },
          { name: profession.name, path: routes.profession(profession.slug) },
        ]}
      />
      <header className="page-head">
        <h1>{profession.name} Mülakat Soruları</h1>
        <p className="lede">{profession.description}</p>
      </header>

      {topics.length > 0 && (
        <nav className="topic-nav" aria-label="Konular">
          {topics.map((t) => (
            <Link key={t.slug} href={routes.topic(profession.slug, t.slug)} className="topic-chip">
              {t.name} <span>{t.questionCount}</span>
            </Link>
          ))}
        </nav>
      )}

      {questions.length > 0 ? (
        <QuestionList questions={questions} />
      ) : (
        <div className="empty">
          <p>Bu meslek için henüz yayında soru yok.</p>
          <Link href={routes.submit} className="btn">
            İlk soruyu sen ekle
          </Link>
        </div>
      )}
    </>
  );
}
