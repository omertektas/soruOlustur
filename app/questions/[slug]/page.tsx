import type { Metadata } from "next";
import Link from "next/link";
import { notFound } from "next/navigation";
import { Breadcrumbs } from "@/components/Breadcrumbs";
import { DifficultyBadge } from "@/components/DifficultyBadge";
import { JsonLd } from "@/components/JsonLd";
import { QuestionRow } from "@/components/QuestionRow";
import { getApprovedQuestionBySlug, listRelatedQuestions } from "@/lib/data/questions";
import { Markdown, markdownToPlain } from "@/lib/markdown";
import { pageMetadata, questionJsonLd } from "@/lib/seo";
import { routes } from "@/lib/site";

export const revalidate = 3600;

type Props = { params: Promise<{ slug: string }> };

export async function generateStaticParams() {
  return [];
}

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const { slug } = await params;
  const q = await getApprovedQuestionBySlug(slug);
  if (!q) return {};
  return pageMetadata({
    title: q.title,
    description: markdownToPlain(q.answer, 158),
    path: routes.question(q.slug),
  });
}

const dateFormat = new Intl.DateTimeFormat("tr-TR", { day: "numeric", month: "long", year: "numeric" });

export default async function QuestionPage({ params }: Props) {
  const { slug } = await params;
  const question = await getApprovedQuestionBySlug(slug);
  if (!question) notFound();

  const related = await listRelatedQuestions(question);
  const path = routes.question(question.slug);

  return (
    <article className="question">
      <JsonLd data={questionJsonLd(question, path)} />
      <Breadcrumbs
        items={[
          { name: "Ana sayfa", path: routes.home },
          { name: question.profession.name, path: routes.profession(question.profession.slug) },
          { name: question.topic.name, path: routes.topic(question.profession.slug, question.topic.slug) },
          { name: question.title, path },
        ]}
      />

      <header className="question-head">
        <div className="meta-line">
          <DifficultyBadge value={question.difficulty} />
          <Link href={routes.topic(question.profession.slug, question.topic.slug)}>{question.topic.name}</Link>
          <span aria-hidden="true">·</span>
          <Link href={routes.profession(question.profession.slug)}>{question.profession.shortName}</Link>
        </div>
        <h1>{question.title}</h1>
      </header>

      <section className="answer-card" aria-labelledby="answer">
        <h2 id="answer" className="eyebrow">
          Cevap
        </h2>
        <Markdown source={question.answer} />
        {question.tip && (
          <aside className="tip">
            <strong>Mülakat ipucu:</strong> {question.tip}
          </aside>
        )}
        <p className="byline muted small">
          {question.authorName ? `${question.authorName} tarafından eklendi` : "Mülakat Defteri editörleri"} ·{" "}
          <time dateTime={question.updatedAt}>{dateFormat.format(new Date(question.updatedAt))}</time>
        </p>
      </section>

      {related.length > 0 && (
        <section className="section" aria-labelledby="related">
          <h2 id="related" className="section-title">
            İlgili {question.topic.name} soruları
          </h2>
          <ol className="qrows">
            {related.map((q) => (
              <QuestionRow key={q.id} question={q} showProfession />
            ))}
          </ol>
        </section>
      )}

      <section className="cta">
        <div>
          <h2>Bu konuda başka bir soru biliyor musun?</h2>
          <p className="muted">Mülakatta karşılaştığın soruları ekle, onaylandıktan sonra yayına alınsın.</p>
        </div>
        <Link href={routes.submit} className="btn btn-lg">
          Soru ekle
        </Link>
      </section>
    </article>
  );
}
