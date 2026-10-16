import type { Metadata } from "next";
import { redirect } from "next/navigation";
import { getSessionUser } from "@/lib/auth";
import { pageMetadata } from "@/lib/seo";
import { routes } from "@/lib/site";
import { safeNextPath } from "@/lib/validation";
import { LoginForm } from "./LoginForm";

export const metadata: Metadata = pageMetadata({
  title: "Giriş yap",
  description: "Soru eklemek ve eklediğin soruları takip etmek için giriş yap.",
  path: routes.login(),
  noIndex: true,
});

type Props = { searchParams: Promise<{ next?: string; error?: string }> };

export default async function LoginPage({ searchParams }: Props) {
  const { next: nextParam, error } = await searchParams;
  const next = safeNextPath(nextParam, routes.submit);
  if (await getSessionUser()) redirect(next);

  return (
    <div className="narrow">
      <header className="page-head">
        <h1>Hesabına giriş yap</h1>
        <p className="lede">Soru eklemek için giriş yapman gerekiyor. Eklediğin sorular onaylandıktan sonra yayına alınır.</p>
      </header>
      <LoginForm
        next={next}
        initialError={error ? "Doğrulama bağlantısı geçersiz veya süresi dolmuş. Lütfen tekrar giriş yapmayı deneyin." : undefined}
      />
    </div>
  );
}
