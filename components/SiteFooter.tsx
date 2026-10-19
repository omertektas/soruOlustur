import Link from "next/link";
import { getProfessions } from "@/lib/data/catalog";
import { routes, siteConfig } from "@/lib/site";

export async function SiteFooter() {
  const professions = await getProfessions().catch(() => []);
  return (
    <footer className="site-footer">
      <div className="container site-footer-inner">
        <div className="footer-brand">
          <strong>{siteConfig.name}</strong>
          <p className="muted small">
            Yazılımcı adaylar için topluluk destekli, Türkçe mülakat hazırlık platformu.
          </p>
        </div>
        <nav aria-label="Meslekler" className="footer-links">
          <span className="eyebrow">Meslekler</span>
          <ul>
            {professions.map((p) => (
              <li key={p.slug}>
                <Link href={routes.profession(p.slug)}>{p.name} mülakat soruları</Link>
              </li>
            ))}
          </ul>
        </nav>
        <nav aria-label="Topluluk" className="footer-links">
          <span className="eyebrow">Topluluk</span>
          <ul>
            <li>
              <Link href={routes.submit}>Soru ekle</Link>
            </li>
            <li>
              <Link href={routes.search()}>Soru ara</Link>
            </li>
          </ul>
        </nav>
      </div>
      <div className="container footer-bottom muted small">
        © {new Date().getFullYear()} {siteConfig.publisher}. Cevaplar özet niteliğindedir; resmi dokümantasyonla pekiştirin.
      </div>
    </footer>
  );
}
