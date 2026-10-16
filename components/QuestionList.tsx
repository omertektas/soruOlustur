"use client";

import { useMemo, useState } from "react";
import { DIFFICULTIES, DIFFICULTY_LABELS, type Difficulty, type QuestionSummary } from "@/lib/types";
import { QuestionRow } from "./QuestionRow";

const normalize = (s: string) =>
  s.toLocaleLowerCase("tr").normalize("NFD").replace(/[̀-ͯ]/g, "").replace(/ı/g, "i");

/** Client-side filter over a list that is fully server-rendered (so crawlers see every item). */
export function QuestionList({
  questions,
  showProfession = false,
}: {
  questions: QuestionSummary[];
  showProfession?: boolean;
}) {
  const [difficulty, setDifficulty] = useState<Difficulty | "all">("all");
  const [term, setTerm] = useState("");

  const filtered = useMemo(() => {
    const t = normalize(term.trim());
    return questions.filter(
      (q) =>
        (difficulty === "all" || q.difficulty === difficulty) &&
        (!t || normalize(`${q.title} ${q.topic.name}`).includes(t))
    );
  }, [questions, difficulty, term]);

  return (
    <section className="qlist" aria-label="Sorular">
      <div className="qlist-tools">
        <input
          id="qlist-filter"
          type="search"
          className="input"
          placeholder="Bu listede ara…"
          value={term}
          onChange={(e) => setTerm(e.target.value)}
          aria-label="Listede ara"
        />
        <div className="chips" role="group" aria-label="Zorluk">
          {(["all", ...DIFFICULTIES] as const).map((d) => (
            <button
              key={d}
              type="button"
              className="chip"
              aria-pressed={difficulty === d}
              onClick={() => setDifficulty(d)}
            >
              {d === "all" ? "Tümü" : DIFFICULTY_LABELS[d]}
            </button>
          ))}
        </div>
        <span className="muted small">{filtered.length} soru</span>
      </div>
      {filtered.length === 0 ? (
        <p className="empty">Bu filtrelerle eşleşen soru yok.</p>
      ) : (
        <ol className="qrows">
          {filtered.map((q) => (
            <QuestionRow key={q.id} question={q} showProfession={showProfession} />
          ))}
        </ol>
      )}
    </section>
  );
}
