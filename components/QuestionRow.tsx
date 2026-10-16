import Link from "next/link";
import { routes } from "@/lib/site";
import type { QuestionSummary } from "@/lib/types";
import { DifficultyBadge } from "./DifficultyBadge";

export function QuestionRow({ question, showProfession = false }: { question: QuestionSummary; showProfession?: boolean }) {
  return (
    <li className="qrow">
      <Link href={routes.question(question.slug)} className="qrow-link">
        <span className="qrow-title">{question.title}</span>
        <span className="qrow-meta">
          <DifficultyBadge value={question.difficulty} />
          <span>{question.topic.name}</span>
          {showProfession && <span className="qrow-prof">{question.profession.shortName}</span>}
        </span>
      </Link>
    </li>
  );
}
