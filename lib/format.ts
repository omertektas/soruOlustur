/** Shared Turkish number and date formatting. */

const numberFormat = new Intl.NumberFormat("tr-TR");
const compactFormat = new Intl.NumberFormat("tr-TR", { notation: "compact", maximumFractionDigits: 1 });

export const formatNumber = (n: number) => numberFormat.format(n);
/** Full number up to 99.999, then compact ("1,2 Mn") so large values stay short. */
export const formatCompact = (n: number) => (n < 100000 ? numberFormat.format(n) : compactFormat.format(n));

const dateFormat = new Intl.DateTimeFormat("tr-TR", { day: "numeric", month: "short", year: "numeric", timeZone: "Europe/Istanbul" });
const dateTimeFormat = new Intl.DateTimeFormat("tr-TR", { dateStyle: "medium", timeStyle: "short", timeZone: "Europe/Istanbul" });
const dayMonthFormat = new Intl.DateTimeFormat("tr-TR", { day: "numeric", month: "short", timeZone: "UTC" });
const longDayFormat = new Intl.DateTimeFormat("tr-TR", { weekday: "long", day: "numeric", month: "long", timeZone: "UTC" });

export const formatDate = (iso: string) => dateFormat.format(new Date(iso));
export const formatDateTime = (iso: string) => dateTimeFormat.format(new Date(iso));

/** For calendar days given as YYYY-MM-DD (no time zone shift). */
export const formatDay = (day: string) => dayMonthFormat.format(new Date(`${day}T00:00:00Z`));
export const formatLongDay = (day: string) => longDayFormat.format(new Date(`${day}T00:00:00Z`));

/** "3 gün önce", "2 saat önce" … */
export function formatRelative(iso: string, now = Date.now()): string {
  const seconds = Math.round((new Date(iso).getTime() - now) / 1000);
  const rtf = new Intl.RelativeTimeFormat("tr-TR", { numeric: "auto" });
  const units: [Intl.RelativeTimeFormatUnit, number][] = [
    ["year", 31536000],
    ["month", 2592000],
    ["week", 604800],
    ["day", 86400],
    ["hour", 3600],
    ["minute", 60],
  ];
  for (const [unit, size] of units) {
    if (Math.abs(seconds) >= size) return rtf.format(Math.round(seconds / size), unit);
  }
  return "az önce";
}
