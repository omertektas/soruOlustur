import { DIFFICULTY_LABELS, type Difficulty } from "@/lib/types";

export function DifficultyBadge({ value }: { value: Difficulty }) {
  return <span className={`pill pill-${value}`}>{DIFFICULTY_LABELS[value]}</span>;
}
