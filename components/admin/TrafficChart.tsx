"use client";

import { useEffect, useMemo, useRef, useState, type KeyboardEvent, type PointerEvent } from "react";
import type { TrafficDay } from "@/lib/data/admin";
import { formatCompact, formatDay, formatLongDay, formatNumber } from "@/lib/format";

const HEIGHT = 260;
const MARGIN = { top: 16, right: 16, bottom: 30, left: 44 };

/** Smallest "nice" number (1, 2, 5 × 10^n) at or above value / steps, times steps. */
function niceMax(value: number, steps = 4): number {
  const raw = Math.max(value, 1) / steps;
  const magnitude = 10 ** Math.floor(Math.log10(raw));
  const step = [1, 2, 5, 10].map((m) => m * magnitude).find((s) => s >= raw) ?? raw;
  return Math.max(step * steps, steps);
}

/** Daily page views (area + line) and visitors (line) on one shared count axis. */
export function TrafficChart({ data }: { data: TrafficDay[] }) {
  const wrapRef = useRef<HTMLDivElement>(null);
  const [width, setWidth] = useState(720);
  const [active, setActive] = useState<number | null>(null);

  useEffect(() => {
    const el = wrapRef.current;
    if (!el) return;
    const observer = new ResizeObserver(([entry]) => setWidth(Math.max(280, Math.round(entry.contentRect.width))));
    observer.observe(el);
    return () => observer.disconnect();
  }, []);

  const geometry = useMemo(() => {
    const innerW = width - MARGIN.left - MARGIN.right;
    const innerH = HEIGHT - MARGIN.top - MARGIN.bottom;
    const yMax = niceMax(Math.max(0, ...data.map((d) => Math.max(d.views, d.visitors))));
    const x = (i: number) => MARGIN.left + (data.length <= 1 ? innerW / 2 : (i / (data.length - 1)) * innerW);
    const y = (v: number) => MARGIN.top + innerH - (v / yMax) * innerH;
    const line = (key: "views" | "visitors") => data.map((d, i) => `${i ? "L" : "M"}${x(i)} ${y(d[key])}`).join("");
    const baseline = y(0);
    const area = data.length ? `${line("views")}L${x(data.length - 1)} ${baseline}L${x(0)} ${baseline}Z` : "";
    const ticks = [0, 1, 2, 3, 4].map((k) => (yMax / 4) * k);
    const labelEvery = Math.max(1, Math.ceil(data.length / Math.max(2, Math.floor(innerW / 90))));
    const xLabels = data
      .map((d, i) => ({ i, day: d.day }))
      .filter(({ i }) => (data.length - 1 - i) % labelEvery === 0);
    return { innerW, x, y, viewsLine: line("views"), visitorsLine: line("visitors"), area, ticks, xLabels, baseline };
  }, [data, width]);

  const total = data.reduce((s, d) => s + d.views, 0);
  const last = data.length - 1;
  const shown = active ?? (data.length ? last : null);

  const pick = (e: PointerEvent<SVGRectElement>) => {
    const rect = e.currentTarget.getBoundingClientRect();
    const ratio = (e.clientX - rect.left) / rect.width;
    setActive(Math.min(last, Math.max(0, Math.round(ratio * last))));
  };

  const onKey = (e: KeyboardEvent<HTMLDivElement>) => {
    if (e.key !== "ArrowLeft" && e.key !== "ArrowRight") return;
    e.preventDefault();
    setActive((cur) => Math.min(last, Math.max(0, (cur ?? last) + (e.key === "ArrowRight" ? 1 : -1))));
  };

  const { x, y } = geometry;
  const tooltipLeft = shown !== null ? Math.min(Math.max(x(shown), 90), width - 90) : 0;

  return (
    <figure className="chart">
      <div className="chart-legend" aria-hidden="true">
        <span className="legend-item">
          <span className="legend-swatch legend-views" />
          Sayfa görüntülenme
        </span>
        <span className="legend-item">
          <span className="legend-swatch legend-visitors" />
          Ziyaretçi
        </span>
      </div>

      <div
        className="chart-plot"
        ref={wrapRef}
        tabIndex={0}
        role="img"
        aria-label={`Son ${data.length} günde toplam ${formatNumber(total)} sayfa görüntülenme. Günleri gezmek için sol ve sağ ok tuşlarını kullanın.`}
        onKeyDown={onKey}
        onBlur={() => setActive(null)}
      >
        <svg width={width} height={HEIGHT} viewBox={`0 0 ${width} ${HEIGHT}`}>
          <g className="chart-grid">
            {geometry.ticks.map((t) => (
              <g key={t}>
                <line x1={MARGIN.left} x2={width - MARGIN.right} y1={y(t)} y2={y(t)} />
                <text x={MARGIN.left - 8} y={y(t) + 4} textAnchor="end">
                  {formatCompact(t)}
                </text>
              </g>
            ))}
            {geometry.xLabels.map(({ i, day }) => (
              <text key={day} x={x(i)} y={HEIGHT - 8} textAnchor={i === last ? "end" : i === 0 ? "start" : "middle"}>
                {formatDay(day)}
              </text>
            ))}
          </g>

          <path d={geometry.area} className="series-views-area" />
          <path d={geometry.viewsLine} className="series-views-line" />
          <path d={geometry.visitorsLine} className="series-visitors-line" />

          {shown !== null && (
            <g className="chart-focus">
              {active !== null && <line x1={x(shown)} x2={x(shown)} y1={MARGIN.top} y2={geometry.baseline} />}
              <circle cx={x(shown)} cy={y(data[shown].views)} r="4.5" className="dot-views" />
              <circle cx={x(shown)} cy={y(data[shown].visitors)} r="4.5" className="dot-visitors" />
            </g>
          )}

          <rect
            x={MARGIN.left}
            y={MARGIN.top}
            width={geometry.innerW}
            height={HEIGHT - MARGIN.top - MARGIN.bottom}
            fill="transparent"
            onPointerMove={pick}
            onPointerDown={pick}
            onPointerLeave={() => setActive(null)}
          />
        </svg>

        {total === 0 && <p className="chart-empty">Henüz ziyaret yok. Sayaç, ziyaretçiler siteye geldikçe dolacak.</p>}

        {active !== null && (
          <div className="chart-tooltip" style={{ left: tooltipLeft }}>
            <strong>{formatLongDay(data[active].day)}</strong>
            <span>
              <i className="legend-swatch legend-views" /> {formatNumber(data[active].views)} görüntülenme
            </span>
            <span>
              <i className="legend-swatch legend-visitors" /> {formatNumber(data[active].visitors)} ziyaretçi
            </span>
          </div>
        )}
      </div>

      <details className="chart-table">
        <summary>Tablo olarak göster</summary>
        <div className="table-scroll">
          <table className="data-table">
            <thead>
              <tr>
                <th>Gün</th>
                <th className="num">Görüntülenme</th>
                <th className="num">Ziyaretçi</th>
              </tr>
            </thead>
            <tbody>
              {[...data].reverse().map((d) => (
                <tr key={d.day}>
                  <td>{formatLongDay(d.day)}</td>
                  <td className="num">{formatNumber(d.views)}</td>
                  <td className="num">{formatNumber(d.visitors)}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </details>
    </figure>
  );
}
