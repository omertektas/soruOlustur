/** Yapılandırılmış veri (schema.org) — Google'ın sayfayı anlamasına yardım eder. */
export function JsonLd({ data }: { data: object }) {
  return (
    <script
      type="application/ld+json"
      // JSON içinde </script> kapanışını engellemek için < karakteri kaçışlanır.
      dangerouslySetInnerHTML={{ __html: JSON.stringify(data).replace(/</g, "\\u003c") }}
    />
  );
}
