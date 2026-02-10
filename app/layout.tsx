import type { Metadata } from "next";
import { Inter } from "next/font/google";
import "./globals.css";
// Yeni oluşturduğumuz bileşenleri import ediyoruz
import Header from "./components/Header";
import Footer from "./components/Footer";

const inter = Inter({ subsets: ["latin"] });

export const metadata: Metadata = {
  title: "Sınav Hazırlayıcı - OFTECHSOLUTIONS",
  description: "Öğrenciler ve öğretmenler için yapay zeka destekli sınav hazırlama aracı. PDF ders notlarınızı yükleyin, saniyeler içinde test veya klasik sınav soruları oluşturun.",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="tr">
      <body className={`${inter.className} min-h-screen flex flex-col`}>
        {/* Header en tepede */}
        <Header />
        
        {/* Ana İçerik (Sayfalar buraya gelecek) */}
        <main className="flex-grow">
          {children}
        </main>

        {/* Footer en altta */}
        <Footer />
      </body>
    </html>
  );
}