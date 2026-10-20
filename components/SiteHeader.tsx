import Link from "next/link";
import { routes } from "@/lib/site";
import { UserMenu } from "./UserMenu";

export function SiteHeader() {
  return (
    <header className="site-header">
      <div className="container site-header-inner">
        <Link href={routes.home} className="logo">
          Dev<mark>Mülakat</mark>
        </Link>
        <form action={routes.search()} method="get" className="header-search" role="search">
          <input name="q" type="search" className="input" placeholder="Soru ara…" aria-label="Soru ara" />
        </form>
        <UserMenu />
      </div>
    </header>
  );
}
