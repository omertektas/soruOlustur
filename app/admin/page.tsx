import type { Metadata } from "next";
import Link from "next/link";
import { AdminShell, StatTile } from "@/components/admin/AdminShell";
import { TrafficChart } from "@/components/admin/TrafficChart";
import { requireAdmin } from "@/lib/auth";
import { getAdminOverview, getTopPages, getTraffic, listUsers } from "@/lib/data/admin";
import { formatCompact, formatNumber, formatRelative } from "@/lib/format";
import { pageMetadata } from "@/lib/seo";
import { routes } from "@/lib/site";
import { createServerSupabase } from "@/lib/supabase/server";

export const metadata: Metadata = pageMetadata({
  title: "Genel bakış · Yönetim",
  description: "Site trafiği, sorular ve kullanıcılar",
  path: routes.admin,
  noIndex: true,
});

const TRAFFIC_DAYS = 30;

function readablePath(path: string): string {
  try {
    return decodeURI(path);
  } catch {
    return path;
  }
}

export default async function AdminOverviewPage() {
  await requireAdmin();
  const supabase = await createServerSupabase();
  const [overview, traffic, topPages, users] = await Promise.all([
    getAdminOverview(supabase),
    getTraffic(supabase, TRAFFIC_DAYS),
    getTopPages(supabase, TRAFFIC_DAYS, 8),
    listUsers(supabase),
  ]);
  const topViews = topPages[0]?.views ?? 0;

  return (
    <AdminShell active="overview" title="Genel bakış">
      <section className="stat-grid" aria-label="Özet">
        <StatTile label="Bugün ziyaretçi" value={formatNumber(overview.visitorsToday)} note={`${formatNumber(overview.viewsToday)} görüntülenme`} />
        <StatTile label="Son 30 gün görüntülenme" value={formatCompact(overview.views30Days)} />
        <StatTile label="Son 30 gün ziyaretçi" value={formatCompact(overview.visitors30Days)} note="günlük tekil ziyaretçi toplamı" />
        <StatTile
          label="Onay bekleyen soru"
          value={formatNumber(overview.questionsPending)}
          note={overview.questionsPending ? "İncelemek için tıkla" : "Kuyruk boş"}
          tone={overview.questionsPending ? "attention" : undefined}
          href={routes.adminQuestions()}
        />
        <StatTile label="Yayındaki soru" value={formatNumber(overview.questionsPublished)} />
        <StatTile
          label="Kayıtlı kullanıcı"
          value={formatNumber(overview.usersTotal)}
          note={`son 7 günde +${formatNumber(overview.usersLast7Days)}`}
          href={routes.adminUsers}
        />
      </section>

      <section className="card" aria-labelledby="traffic-title">
        <div className="card-head">
          <h2 id="traffic-title">Son {TRAFFIC_DAYS} gün trafik</h2>
          <span className="muted small">Türkiye saatine göre günlük</span>
        </div>
        <TrafficChart data={traffic} />
      </section>

      <div className="admin-columns">
        <section className="card" aria-labelledby="top-pages-title">
          <div className="card-head">
            <h2 id="top-pages-title">En çok ziyaret edilen sayfalar</h2>
            <span className="muted small">son {TRAFFIC_DAYS} gün</span>
          </div>
          {topPages.length === 0 ? (
            <p className="muted">Henüz veri yok.</p>
          ) : (
            <div className="table-scroll">
              <table className="data-table">
                <thead>
                  <tr>
                    <th>Sayfa</th>
                    <th className="num">Görüntülenme</th>
                  </tr>
                </thead>
                <tbody>
                  {topPages.map((p) => (
                    <tr key={p.path}>
                      <td>
                        <div className="path-cell">
                          <a href={p.path} target="_blank" rel="noopener">
                            {readablePath(p.path)}
                          </a>
                          <span className="bar-track" aria-hidden="true">
                            <span className="bar-fill" style={{ width: `${(p.views / topViews) * 100}%` }} />
                          </span>
                        </div>
                      </td>
                      <td className="num">{formatNumber(p.views)}</td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          )}
        </section>

        <section className="card" aria-labelledby="new-users-title">
          <div className="card-head">
            <h2 id="new-users-title">Son kayıt olanlar</h2>
            <Link href={routes.adminUsers} className="small">
              Tümünü gör →
            </Link>
          </div>
          {users.length === 0 ? (
            <p className="muted">Henüz kayıtlı kullanıcı yok.</p>
          ) : (
            <ul className="people">
              {users.slice(0, 6).map((u) => (
                <li key={u.id}>
                  <span className="avatar" aria-hidden="true">
                    {u.displayName.slice(0, 1).toLocaleUpperCase("tr")}
                  </span>
                  <span className="person">
                    <strong>{u.displayName}</strong>
                    <span className="muted small">{u.email}</span>
                  </span>
                  <span className="muted small">{formatRelative(u.createdAt)}</span>
                </li>
              ))}
            </ul>
          )}
        </section>
      </div>
    </AdminShell>
  );
}
