import type { Metadata } from "next";
import { requireUser } from "@/lib/auth";
import { getProfessions, getTopics } from "@/lib/data/catalog";
import { pageMetadata } from "@/lib/seo";
import { routes } from "@/lib/site";
import { QuestionForm } from "./QuestionForm";

export const metadata: Metadata = pageMetadata({
  title: "Soru ekle",
  description: "Mülakatta karşılaştığın bir soruyu ve cevabını ekle.",
  path: routes.submit,
  noIndex: true,
});

export default async function SubmitPage() {
  const user = await requireUser(routes.submit);
  const [professions, topics] = await Promise.all([getProfessions(), getTopics()]);

  return (
    <div className="narrow">
      <header className="page-head">
        <h1>Soru ekle</h1>
        <p className="lede">
          Merhaba {user.displayName}. Eklediğin soru editör onayından sonra yayına alınır. Net bir soru ve kendi
          cümlelerinle yazılmış bir cevap, sorunun hızlı onaylanmasını sağlar.
        </p>
      </header>
      <QuestionForm professions={professions} topics={topics} />
    </div>
  );
}
