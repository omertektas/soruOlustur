import type { ReactNode } from "react";

/*
 * Small, safe markdown renderer for user content.
 * It never produces raw HTML, only React elements, so it is not exposed to XSS.
 * Supports: paragraphs, ### headings, - lists, 1. lists, | tables |, ```code```, `inline code`, **bold**, [links](https://...)
 */

type Block =
  | { type: "code"; lang: string; content: string }
  | { type: "heading"; text: string }
  | { type: "ul"; items: string[] }
  | { type: "ol"; items: string[] }
  | { type: "table"; head: string[]; rows: string[][] }
  | { type: "p"; text: string };

const UL_RE = /^\s*[-*]\s+(.*)$/;
const OL_RE = /^\s*\d+[.)]\s+(.*)$/;
const HEADING_RE = /^#{1,4}\s+(.*)$/;
const TABLE_RE = /^\s*\|.*\|\s*$/;
const TABLE_DIVIDER_RE = /^\s*\|(\s*:?-{2,}:?\s*\|)+\s*$/;

/** Splits "| a | b |" into cells; `\|` keeps a literal pipe inside a cell. */
function splitRow(line: string): string[] {
  return line
    .trim()
    .replace(/^\|/, "")
    .replace(/\|$/, "")
    .split(/(?<!\\)\|/)
    .map((cell) => cell.trim().replace(/\\\|/g, "|"));
}

export function parseMarkdown(source: string): Block[] {
  const lines = source.replace(/\r\n?/g, "\n").split("\n");
  const blocks: Block[] = [];
  let i = 0;

  while (i < lines.length) {
    const line = lines[i];

    if (line.trim() === "") {
      i++;
      continue;
    }

    const fence = line.match(/^\s*```\s*([\w+#-]*)\s*$/);
    if (fence) {
      const content: string[] = [];
      i++;
      while (i < lines.length && !/^\s*```\s*$/.test(lines[i])) content.push(lines[i++]);
      i++; // closing ```
      blocks.push({ type: "code", lang: fence[1] || "text", content: content.join("\n") });
      continue;
    }

    const heading = line.match(HEADING_RE);
    if (heading) {
      blocks.push({ type: "heading", text: heading[1] });
      i++;
      continue;
    }

    if (TABLE_RE.test(line) && i + 1 < lines.length && TABLE_DIVIDER_RE.test(lines[i + 1])) {
      const head = splitRow(line);
      const rows: string[][] = [];
      i += 2;
      while (i < lines.length && TABLE_RE.test(lines[i])) rows.push(splitRow(lines[i++]));
      blocks.push({ type: "table", head, rows });
      continue;
    }

    if (UL_RE.test(line) || OL_RE.test(line)) {
      const ordered = OL_RE.test(line);
      const re = ordered ? OL_RE : UL_RE;
      const items: string[] = [];
      while (i < lines.length && re.test(lines[i])) {
        items.push(lines[i].match(re)![1]);
        i++;
      }
      blocks.push({ type: ordered ? "ol" : "ul", items });
      continue;
    }

    const para: string[] = [];
    while (
      i < lines.length &&
      lines[i].trim() !== "" &&
      !/^\s*```/.test(lines[i]) &&
      !HEADING_RE.test(lines[i]) &&
      !UL_RE.test(lines[i]) &&
      !OL_RE.test(lines[i])
    ) {
      para.push(lines[i].trim());
      i++;
    }
    blocks.push({ type: "p", text: para.join(" ") });
  }

  return blocks;
}

const INLINE_RE = /(`[^`]+`)|(\*\*[^*]+\*\*)|\[([^\]]+)\]\((https?:\/\/[^\s)]+)\)/g;

function renderInline(text: string): ReactNode[] {
  const nodes: ReactNode[] = [];
  let last = 0;
  let key = 0;
  for (const match of text.matchAll(INLINE_RE)) {
    const index = match.index ?? 0;
    if (index > last) nodes.push(text.slice(last, index));
    if (match[1]) nodes.push(<code key={key++}>{match[1].slice(1, -1)}</code>);
    else if (match[2]) nodes.push(<strong key={key++}>{match[2].slice(2, -2)}</strong>);
    else if (match[3] && match[4])
      nodes.push(
        <a key={key++} href={match[4]} rel="nofollow ugc noopener" target="_blank">
          {match[3]}
        </a>
      );
    last = index + match[0].length;
  }
  if (last < text.length) nodes.push(text.slice(last));
  return nodes;
}

export function Markdown({ source, className }: { source: string; className?: string }) {
  const blocks = parseMarkdown(source);
  return (
    <div className={className ?? "prose"}>
      {blocks.map((block, i) => {
        switch (block.type) {
          case "code":
            return (
              <pre key={i} data-lang={block.lang}>
                <code>{block.content}</code>
              </pre>
            );
          case "table":
            return (
              <div key={i} className="table-scroll">
                <table>
                  <thead>
                    <tr>
                      {block.head.map((cell, j) => (
                        <th key={j}>{renderInline(cell)}</th>
                      ))}
                    </tr>
                  </thead>
                  <tbody>
                    {block.rows.map((row, r) => (
                      <tr key={r}>
                        {block.head.map((_, j) => (
                          <td key={j}>{renderInline(row[j] ?? "")}</td>
                        ))}
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            );
          case "heading":
            return <h3 key={i}>{renderInline(block.text)}</h3>;
          case "ul":
            return (
              <ul key={i}>
                {block.items.map((item, j) => (
                  <li key={j}>{renderInline(item)}</li>
                ))}
              </ul>
            );
          case "ol":
            return (
              <ol key={i}>
                {block.items.map((item, j) => (
                  <li key={j}>{renderInline(item)}</li>
                ))}
              </ol>
            );
          default:
            return <p key={i}>{renderInline(block.text)}</p>;
        }
      })}
    </div>
  );
}

/** Plain-text excerpt for meta descriptions and previews. */
export function markdownToPlain(source: string, maxLength = 160): string {
  const text = parseMarkdown(source)
    .map((b) => {
      if (b.type === "ul" || b.type === "ol") return b.items.join(", ");
      return b.type === "p" || b.type === "heading" ? b.text : "";
    })
    .join(" ")
    .replace(/`([^`]+)`/g, "$1")
    .replace(/\*\*([^*]+)\*\*/g, "$1")
    .replace(/\[([^\]]+)\]\([^)]+\)/g, "$1")
    .replace(/\s+/g, " ")
    .trim();
  if (text.length <= maxLength) return text;
  const cut = text.slice(0, maxLength - 1);
  return `${cut.slice(0, Math.max(cut.lastIndexOf(" "), maxLength - 20))}…`;
}

