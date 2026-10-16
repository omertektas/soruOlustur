import Link from "next/link";
import { breadcrumbJsonLd, type Crumb } from "@/lib/seo";
import { JsonLd } from "./JsonLd";

export function Breadcrumbs({ items }: { items: Crumb[] }) {
  return (
    <>
      <nav className="crumbs" aria-label="Sayfa konumu">
        <ol>
          {items.map((c, i) => (
            <li key={c.path}>
              {i < items.length - 1 ? <Link href={c.path}>{c.name}</Link> : <span aria-current="page">{c.name}</span>}
            </li>
          ))}
        </ol>
      </nav>
      <JsonLd data={breadcrumbJsonLd(items)} />
    </>
  );
}
