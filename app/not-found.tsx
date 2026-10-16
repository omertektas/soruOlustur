import Link from "next/link";
import { routes } from "@/lib/site";

export default function NotFound() {
  return (
    <div className="narrow page-head">
      <p className="eyebrow">404</p>
      <h1>Aradığın sayfa bulunamadı</h1>
      <p className="lede">Soru kaldırılmış veya adres değişmiş olabilir. Arama yaparak benzer sorulara ulaşabilirsin.</p>
      <div className="row">
        <Link href={routes.home} className="btn">
          Ana sayfa
        </Link>
        <Link href={routes.search()} className="btn btn-ghost">
          Soru ara
        </Link>
      </div>
    </div>
  );
}
