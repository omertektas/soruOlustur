import type { Metadata } from "next";
import ExamGenerator from "./components/ExamGenerator"; // Bileşen yolunu projene göre ayarla


export default function Home() {
  return (
    <div className="flex flex-col min-h-screen bg-gray-50 font-sans">
      
      {/* 1. ÜST KISIM (BAŞLIK & AÇIKLAMA) - Server Side Rendered */}
      <div className="flex-grow pt-6 md:pt-10 pb-20 px-4 md:px-10">
        <div className="max-w-7xl mx-auto">
          <h1 className="text-3xl md:text-4xl font-extrabold mb-4 text-center text-gray-900 tracking-tight">
            Yapay Zeka ile <span className="text-blue-600">Sınav Hazırla</span>
          </h1>
          <p className="text-center text-gray-500 mb-8 md:mb-12 max-w-2xl mx-auto text-base md:text-lg px-2">
            Ders notlarınızı yükleyin, saniyeler içinde kendinizi test edin.
          </p>

          {/* 2. İNTERAKTİF UYGULAMA ALANI - Client Side Rendered */}
          <ExamGenerator />
          
        </div>
      </div>

      {/* 3. NASIL ÇALIŞIR? (SEO İçerik Alanı) - Server Side Rendered */}
      <div className="relative bg-white pt-24 pb-24 border-t" id="nasil-calisir">
        <div className="max-w-6xl mx-auto px-4 md:px-10 relative z-10">
          <div className="text-center mb-16">
            <span className="text-blue-600 font-bold tracking-wider uppercase text-sm">Kolay Kullanım</span>
            <h2 className="text-3xl md:text-4xl font-extrabold text-gray-900 mt-2">Sadece 3 Adımda Hazır</h2>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-10">
            <div className="flex flex-col items-center text-center group">
              <div className="w-16 h-16 md:w-20 md:h-20 bg-blue-50 text-blue-600 rounded-2xl flex items-center justify-center text-2xl md:text-3xl mb-6 shadow-sm">📤</div>
              <h3 className="font-bold text-xl mb-2 text-gray-800">1. Dosyanı Yükle</h3>
              <p className="text-gray-500 px-4">PDF notlarını sisteme yükle.</p>
            </div>
            <div className="flex flex-col items-center text-center group">
              <div className="w-16 h-16 md:w-20 md:h-20 bg-purple-50 text-purple-600 rounded-2xl flex items-center justify-center text-2xl md:text-3xl mb-6 shadow-sm">⚙️</div>
              <h3 className="font-bold text-xl mb-2 text-gray-800">2. Özelleştir</h3>
              <p className="text-gray-500 px-4">Zorluk ve soru tipini seç.</p>
            </div>
            <div className="flex flex-col items-center text-center group">
              <div className="w-16 h-16 md:w-20 md:h-20 bg-green-50 text-green-600 rounded-2xl flex items-center justify-center text-2xl md:text-3xl mb-6 shadow-sm">💾</div>
              <h3 className="font-bold text-xl mb-2 text-gray-800">3. Çöz ve İndir</h3>
              <p className="text-gray-500 px-4">Soruları çöz veya kaydet.</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}