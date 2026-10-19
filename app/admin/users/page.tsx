import type { Metadata } from "next";
import { AdminShell } from "@/components/admin/AdminShell";
import { requireAdmin } from "@/lib/auth";
import { listUsers } from "@/lib/data/admin";
import { formatDate, formatNumber, formatRelative } from "@/lib/format";
import { pageMetadata } from "@/lib/seo";
import { routes } from "@/lib/site";
import { createServerSupabase } from "@/lib/supabase/server";

export const metadata: Metadata = pageMetadata({
  title: "Kullanıcılar · Yönetim",
  description: "Kayıtlı kullanıcılar",
  path: routes.adminUsers,
  noIndex: true,
});

export default async function AdminUsersPage() {
  await requireAdmin();
  const users = await listUsers(await createServerSupabase());
  const confirmed = users.filter((u) => u.emailConfirmed).length;
  const contributors = users.filter((u) => u.approvedQuestions + u.pendingQuestions > 0).length;

  return (
    <AdminShell active="users" title="Kullanıcılar">
      <p className="muted admin-summary">
        {formatNumber(users.length)} kayıtlı kullanıcı · {formatNumber(confirmed)} e-postasını doğruladı ·{" "}
        {formatNumber(contributors)} kişi soru ekledi
      </p>

      <section className="card">
        {users.length === 0 ? (
          <p className="muted">Henüz kayıtlı kullanıcı yok.</p>
        ) : (
          <div className="table-scroll">
            <table className="data-table users-table">
              <thead>
                <tr>
                  <th>Kullanıcı</th>
                  <th>Durum</th>
                  <th>Kayıt</th>
                  <th>Son giriş</th>
                  <th className="num">Yayında</th>
                  <th className="num">Bekleyen</th>
                </tr>
              </thead>
              <tbody>
                {users.map((u) => (
                  <tr key={u.id}>
                    <td>
                      <span className="person-cell">
                        <span className="avatar" aria-hidden="true">
                          {u.displayName.slice(0, 1).toLocaleUpperCase("tr")}
                        </span>
                        <span className="person">
                          <strong>
                            {u.displayName}
                            {u.role === "admin" && <span className="tag tag-admin">Yönetici</span>}
                          </strong>
                          <span className="muted small">{u.email}</span>
                        </span>
                      </span>
                    </td>
                    <td>
                      <span className={`tag ${u.emailConfirmed ? "tag-ok" : "tag-wait"}`}>
                        {u.emailConfirmed ? "Doğrulandı" : "E-posta bekleniyor"}
                      </span>
                    </td>
                    <td className="nowrap">{formatDate(u.createdAt)}</td>
                    <td className="nowrap muted">{u.lastSignInAt ? formatRelative(u.lastSignInAt) : "Hiç giriş yapmadı"}</td>
                    <td className="num">{formatNumber(u.approvedQuestions)}</td>
                    <td className="num">{formatNumber(u.pendingQuestions)}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}
      </section>
    </AdminShell>
  );
}
