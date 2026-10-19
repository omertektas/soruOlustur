import { ImageResponse } from "next/og";
import { siteConfig } from "@/lib/site";

export const alt = siteConfig.name;
export const size = { width: 1200, height: 630 };
export const contentType = "image/png";

export default function OpengraphImage() {
  return new ImageResponse(
    (
      <div
        style={{
          width: "100%",
          height: "100%",
          display: "flex",
          flexDirection: "column",
          justifyContent: "center",
          padding: 80,
          background: "#111615",
          color: "#e6ecea",
        }}
      >
        <div style={{ display: "flex", fontSize: 88, fontWeight: 800, letterSpacing: -2 }}>
          Mülakat
          <span style={{ marginLeft: 24, background: "#8a7520", padding: "0 12px" }}>Defteri</span>
        </div>
        <div style={{ marginTop: 32, fontSize: 40, color: "#4fc3b0" }}>Yazılım ve mühendislik mülakat soruları</div>
        <div style={{ marginTop: 24, fontSize: 28, color: "#94a39e" }}>
          Frontend · Backend · Full Stack · Game Dev · Network · Embedded · Elektrik-Elektronik
        </div>
      </div>
    ),
    size
  );
}
