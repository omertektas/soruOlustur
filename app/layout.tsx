import type { Metadata } from "next";
import { Inter } from "next/font/google";
import "./globals.css";
import Header from "./components/Header";
import Footer from "./components/Footer";

const inter = Inter({ subsets: ["latin"] });

export const metadata: Metadata = {
  title: "Yapay Zeka Destekli Sınav Hazırlayıcı | PDF’den Soru Oluştur",
  description:
    "PDF ders notlarınızı yükleyin, yapay zeka ile saniyeler içinde test veya klasik sınav soruları oluşturun. Öğretmenler ve öğrenciler için online sınav hazırlayıcı.",

  keywords: [
    "yapay zeka sınav hazırlayıcı",
    "pdf’den sınav oluşturma",
    "online sınav hazırlama",
    "yapay zeka soru oluşturma",
    "öğretmenler için sınav hazırlama",
    "öğrenciler için sınava hazırlık",
  ],

  metadataBase: new URL("https://www.oftechsolutions.com"),

  alternates: {
    canonical: "/",
  },

  robots: {
    index: true,
    follow: true,
  },

  openGraph: {
    title: "Yapay Zeka Destekli Sınav Hazırlayıcı",
    description:
      "PDF’den otomatik sınav ve test oluşturma. Yapay zeka destekli online sınav hazırlama aracı.",
    url: "https://www.oftechsolutions.com",
    siteName: "OFTECHSOLUTIONS",
    locale: "tr_TR",
    type: "website",
  },

  twitter: {
    card: "summary_large_image",
    title: "Yapay Zeka Destekli Sınav Hazırlayıcı",
    description:
      "PDF yükleyin, saniyeler içinde yapay zeka ile sınav soruları oluşturun.",
  },
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="tr">
      <body className={`${inter.className} min-h-screen flex flex-col`}>
        <Header />
        <main className="flex-grow">{children}</main>
        <Footer />
      </body>
    </html>
  );
}
