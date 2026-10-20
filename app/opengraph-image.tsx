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
          background: "#edf1ee",
          color: "#1b2422",
        }}
      >
        <div style={{ display: "flex", fontSize: 88, fontWeight: 800, letterSpacing: -2 }}>
          Dev
          <span style={{ color: "#0e6f63" }}>Mülakat</span>
        </div>
        <div style={{ marginTop: 32, fontSize: 40, color: "#0e6f63" }}>Yazılım mülakat soruları ve cevapları</div>
        <div style={{ marginTop: 24, fontSize: 28, color: "#5a6763" }}>
          Frontend · Backend · Full Stack · Game Dev · Network · Embedded
        </div>
      </div>
    ),
    size
  );
}
