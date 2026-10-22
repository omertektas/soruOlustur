/**
 * Visual identity per profession: a two-letter badge and its colour.
 * Colours are deep enough for white text (WCAG AA). Unknown professions fall back to the accent.
 */
const STYLES: Record<string, { code: string; color: string }> = {
  "frontend-developer": { code: "FE", color: "#2563c9" },
  "backend-developer": { code: "BE", color: "#c2410c" },
  "full-stack-developer": { code: "FS", color: "#0f766e" },
  "yazilim-muhendisi": { code: "YM", color: "#6d4fd6" },
  "game-developer": { code: "GD", color: "#be3a78" },
  "network-engineer": { code: "NW", color: "#15803d" },
  "embedded-engineer": { code: "EM", color: "#b45309" },
  "yapay-zeka-muhendisi": { code: "AI", color: "#0e7490" },
};

export function professionStyle(slug: string, shortName: string) {
  const known = STYLES[slug];
  if (known) return known;
  const code = shortName
    .split(/\s+/)
    .map((w) => w[0])
    .join("")
    .slice(0, 2)
    .toLocaleUpperCase("tr");
  return { code: code || "?", color: "var(--accent)" };
}
