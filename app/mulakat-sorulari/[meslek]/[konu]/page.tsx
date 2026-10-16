import type { Metadata } from "next";
import Link from "next/link";
import { notFound } from "next/navigation";
import { Breadcrumbs } from "@/components/Breadcrumbs";
import { QuestionList } from "@/components/QuestionList";
import { getProfessionBySlug, getTopicBySlug } from "@/lib/data/catalog";
import { listApprovedQuestions } from "@/lib/data/questions";
import { pageMetadata } from "@/lib/seo";
import { routes } from "@/lib/site";

export const revalidate = 3600;

type Props = { params: Promise<{ meslek: string; konu: string }> };

export async function generateStaticParams() {
  return [];
}

async function load(meslek: string, konu: string) {
  const [profession, topic] = await Promise.all([getProfessionBySlug(meslek), getTopicBySlug(konu)]);
  if (!profession || !topic) return null;
  const questions = await listApprovedQuestions({ professionId: profession.id, topicId: topic.id });
  if (questions.length === 0) return null;
  return { profession, topic, questions };
}

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const { meslek, konu } = await params;
  const data = await load(meslek, konu);
  if (!data) return {};
  const { profession, topic, questions } = data;
  return pageMetadata({
    title: `${topic.name} Mülakat Soruları – ${profession.shortName}`,
    description: `${profession.name} mülakatlarında sorulan ${questions.length} ${topic.name} sorusu ve cevabı: ${questions
      .slice(0, 3)
      .map((q) => q.title)
      .join(" ")}`.slice(0, 160),
    path: routes.topic(profession.slug, topic.slug),
  });
}

export default async function TopicPage({ params }: Props) {
  const { meslek, konu } = await params;
  const data = await load(meslek, konu);
  if (!data) notFound();
  const { profession, topic, questions } = data;

  return (
    <>
      <Breadcrumbs
        items={[
          { name: "Ana sayfa", path: routes.home },
          { name: profession.name, path: routes.profession(profession.slug) },
          { name: topic.name, path: routes.topic(profession.slug, topic.slug) },
        ]}
      />
      <header className="page-head">
        <h1>
          {topic.name} Mülakat Soruları <span className="muted">· {profession.shortName}</span>
        </h1>
        <p className="lede">
          {profession.name} mülakatlarında karşınıza çıkabilecek {questions.length} {topic.name} sorusu.{" "}
          <Link href={routes.profession(profession.slug)}>Tüm {profession.shortName} sorularına dön</Link>.
        </p>
      </header>
      <QuestionList questions={questions} />
    </>
  );
}
