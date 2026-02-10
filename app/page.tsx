"use client";
import { useState } from "react";

// --- YENİ BİLEŞEN: Tekil Soru Kartı ---
// Bu bileşen her sorunun kendi durumunu (tıklandı mı, cevap göründü mü) yönetir.
function QuestionCard({ q, index }: { q: any; index: number }) {
  const [selectedOption, setSelectedOption] = useState<string | null>(null);
  const [showAnswer, setShowAnswer] = useState(false);

  // Çoktan seçmeli için şıkka tıklama işlemi
  const handleOptionClick = (option: string) => {
    // Eğer daha önce seçim yapıldıysa tekrar tıklatmayalım
    if (selectedOption) return;
    setSelectedOption(option);
  };

  // Cevap kontrolü (Şıkkın doğru olup olmadığını anlamak için)
  const isCorrect = (option: string) => option.trim().startsWith(q.dogru_cevap);
  const isSelected = (option: string) => selectedOption === option;

  return (
    <div className="group relative p-6 bg-white rounded-xl shadow-sm border border-gray-100 hover:shadow-md transition-all duration-300">
      <div className="absolute top-4 right-4 text-xs font-bold text-gray-300">#{index + 1}</div>
      <h3 className="font-bold text-lg mb-4 text-gray-800 pr-8">{q.soru}</h3>

      {q.secenekler ? (
        /* --- ÇOKTAN SEÇMELİ MODU --- */
        <div className="grid grid-cols-1 gap-3">
          {q.secenekler.map((opt: string, i: number) => {
            // Renk Mantığı:
            // 1. Hiçbir şey seçilmediyse -> Gri (Standart)
            // 2. Bu şık seçildiyse:
            //    a. Doğruysa -> Yeşil
            //    b. Yanlışsa -> Kırmızı
            // 3. Bir seçim yapıldıysa VE bu şık doğru cevapsa (kullanıcı yanlış bilse bile doğrusunu göster) -> Yeşil
            
            let liClass = "bg-gray-50 border-gray-200 text-gray-600 hover:bg-gray-100 cursor-pointer"; // Varsayılan

            if (selectedOption) {
              if (isSelected(opt)) {
                liClass = isCorrect(opt)
                  ? "bg-green-100 border-green-400 text-green-800 font-bold ring-1 ring-green-400" // Doğru bildi
                  : "bg-red-100 border-red-400 text-red-800 ring-1 ring-red-400"; // Yanlış bildi
              } else if (isCorrect(opt)) {
                // Kullanıcı yanlış seçtiyse doğru olanı yine de yeşil göster
                liClass = "bg-green-50 border-green-300 text-green-700 font-medium"; 
              } else {
                 // Seçilmeyen diğer şıklar sönükleşsin
                 liClass = "opacity-50 bg-gray-50 border-gray-100";
              }
            }

            return (
              <div
                key={i}
                onClick={() => handleOptionClick(opt)}
                className={`p-3 rounded-lg border text-sm transition-all duration-200 ${liClass}`}
              >
                {opt}
              </div>
            );
          })}
        </div>
      ) : (
        /* --- KLASİK SORU MODU --- */
        <div className="mt-4">
          {!showAnswer ? (
            <button
              onClick={() => setShowAnswer(true)}
              className="flex items-center gap-2 text-sm font-bold text-blue-600 hover:text-blue-800 transition-colors bg-blue-50 px-4 py-2 rounded-lg"
            >
              <span>👁️</span> Cevabı Gör
            </button>
          ) : (
            <div className="p-4 bg-amber-50 rounded-lg border border-amber-200 text-amber-900 animate-in fade-in slide-in-from-top-2 duration-300">
              <div className="flex justify-between items-start mb-1">
                <p className="text-xs font-bold uppercase tracking-wider text-amber-600">Cevap Anahtarı</p>
                <button onClick={() => setShowAnswer(false)} className="text-xs text-amber-500 hover:underline">Gizle</button>
              </div>
              <p className="font-medium">{q.dogru_cevap}</p>
            </div>
          )}
        </div>
      )}
    </div>
  );
}

// --- ANA SAYFA BİLEŞENİ ---
export default function Home() {
  const [file, setFile] = useState<File | null>(null);
  const [difficulty, setDifficulty] = useState("Orta");
  const [questionCount, setQuestionCount] = useState("5");
  const [examType, setExamType] = useState("coktan_secmeli");
  const [loading, setLoading] = useState(false);
  const [questions, setQuestions] = useState<any[]>([]);
  const [isDragging, setIsDragging] = useState(false);

  // Sürükle-Bırak Fonksiyonları
  const handleDragOver = (e: React.DragEvent) => { e.preventDefault(); setIsDragging(true); };
  const handleDragLeave = () => { setIsDragging(false); };
  const handleDrop = (e: React.DragEvent) => {
    e.preventDefault();
    setIsDragging(false);
    const droppedFile = e.dataTransfer.files[0];
    if (droppedFile && droppedFile.type === "application/pdf") {
      setFile(droppedFile);
    } else {
      alert("Lütfen sadece PDF dosyası yükleyin!");
    }
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!file) return alert("Lütfen bir PDF seçin!");

    setLoading(true);
    // Yeni bir dosya yüklendiğinde eski soruları temizle
    setQuestions([]); 
    
    const formData = new FormData();
    formData.append("file", file);
    formData.append("difficulty", difficulty);
    formData.append("questionCount", questionCount);
    formData.append("examType", examType);

    try {
      const res = await fetch("/api/generate", { method: "POST", body: formData });
      const data = await res.json();
      if (data.error) throw new Error(data.error);
      setQuestions(data);
    } catch (error) {
      alert("Hata oluştu: " + error);
    } finally {
      setLoading(false);
    }
  };

  const downloadAsTxt = () => {
    if (questions.length === 0) return;
    let textContent = "OLUŞTURULAN SINAV SORULARI\n===========================\n\n";
    questions.forEach((q, index) => {
      textContent += `${index + 1}. ${q.soru}\n`;
      if (q.secenekler && q.secenekler.length > 0) {
        q.secenekler.forEach((opt: string) => { textContent += `   ${opt}\n`; });
      }
      textContent += `\nCEVAP: ${q.dogru_cevap}\n\n---------------------------\n`;
    });
    const element = document.createElement("a");
    const fileBlob = new Blob([textContent], { type: "text/plain" });
    element.href = URL.createObjectURL(fileBlob);
    element.download = "sinav_sorulari.txt";
    document.body.appendChild(element);
    element.click();
  };

  return (
    <div className="flex flex-col min-h-screen bg-gray-50">
      
      {/* 1. BÖLÜM: Ana İşlem Alanı */}
      <div className="flex-grow pt-10 pb-20 px-4 md:px-10">
        <div className="max-w-6xl mx-auto">
          <h1 className="text-4xl font-extrabold mb-4 text-center text-gray-900 tracking-tight">
            Yapay Zeka ile <span className="text-blue-600">Sınav Hazırla</span>
          </h1>
          <p className="text-center text-gray-500 mb-12 max-w-2xl mx-auto text-lg">
            Ders notlarınızı yükleyin, saniyeler içinde kendinizi test edin.
          </p>

          <div className="grid grid-cols-1 lg:grid-cols-2 gap-8 items-start">
            {/* SOL TARAF: AYARLAR */}
            <div className="space-y-6 sticky top-24">
              <form onSubmit={handleSubmit} className="space-y-6 border border-gray-100 p-8 rounded-2xl shadow-xl bg-white relative overflow-hidden">
                <div className="absolute top-0 left-0 w-full h-2 bg-gradient-to-r from-blue-500 to-purple-500"></div>

                <h2 className="text-2xl font-bold text-gray-800">Sınav Ayarları</h2>
                
                {/* Dosya Yükleme */}
                <div
                  onDragOver={handleDragOver} onDragLeave={handleDragLeave} onDrop={handleDrop}
                  className={`border-2 border-dashed rounded-xl p-8 text-center transition-all duration-300 ${isDragging ? "border-blue-500 bg-blue-50 scale-[1.02]" : "border-gray-300 bg-gray-50 hover:border-blue-400"}`}
                >
                  <input type="file" accept=".pdf" id="fileInput" onChange={(e) => setFile(e.target.files?.[0] || null)} className="hidden" />
                  <label htmlFor="fileInput" className="cursor-pointer flex flex-col items-center">
                    <div className="w-16 h-16 bg-blue-100 text-blue-600 rounded-full flex items-center justify-center text-3xl mb-3 shadow-sm">
                      📄
                    </div>
                    <p className="text-gray-700 font-semibold text-lg">{file ? file.name : "PDF Dosyasını Buraya Bırakın"}</p>
                    <p className="text-sm text-gray-500 mt-1">veya dosya seçmek için tıklayın</p>
                  </label>
                </div>

                {/* Ayarlar Grid */}
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  <div className="col-span-1 md:col-span-2">
                    <label className="block mb-2 font-semibold text-gray-700 text-sm uppercase tracking-wide">Zorluk Seviyesi</label>
                    <div className="flex bg-gray-100 p-1 rounded-lg">
                      {["Kolay", "Orta", "Zor"].map((level) => (
                        <button
                          key={level} type="button" onClick={() => setDifficulty(level)}
                          className={`flex-1 py-2 text-sm font-medium rounded-md transition-all ${difficulty === level ? "bg-white text-blue-600 shadow-sm" : "text-gray-500 hover:text-gray-700"}`}
                        >
                          {level}
                        </button>
                      ))}
                    </div>
                  </div>

                  <div className="col-span-1 md:col-span-2">
                    <label className="block mb-2 font-semibold text-gray-700 text-sm uppercase tracking-wide">Sınav Tipi</label>
                    <div className="grid grid-cols-2 gap-3">
                      <div onClick={() => setExamType("coktan_secmeli")} className={`cursor-pointer border-2 rounded-lg p-3 flex items-center gap-3 transition-all ${examType === "coktan_secmeli" ? "border-blue-500 bg-blue-50" : "border-gray-200 hover:border-blue-300"}`}>
                        <div className={`w-4 h-4 rounded-full border flex items-center justify-center ${examType === "coktan_secmeli" ? "border-blue-600" : "border-gray-400"}`}>
                          {examType === "coktan_secmeli" && <div className="w-2 h-2 bg-blue-600 rounded-full"></div>}
                        </div>
                        <span className="text-sm font-medium text-gray-700">Test (Şıklı)</span>
                      </div>
                      <div onClick={() => setExamType("klasik")} className={`cursor-pointer border-2 rounded-lg p-3 flex items-center gap-3 transition-all ${examType === "klasik" ? "border-purple-500 bg-purple-50" : "border-gray-200 hover:border-purple-300"}`}>
                        <div className={`w-4 h-4 rounded-full border flex items-center justify-center ${examType === "klasik" ? "border-purple-600" : "border-gray-400"}`}>
                          {examType === "klasik" && <div className="w-2 h-2 bg-purple-600 rounded-full"></div>}
                        </div>
                        <span className="text-sm font-medium text-gray-700">Klasik (Yazılı)</span>
                      </div>
                    </div>
                  </div>

                  <div className="col-span-1 md:col-span-2">
                     <label className="block mb-2 font-semibold text-gray-700 text-sm uppercase tracking-wide">Soru Adedi</label>
                     <select value={questionCount} onChange={(e) => setQuestionCount(e.target.value)} className="w-full p-3 bg-white border border-gray-300 rounded-lg text-gray-700 focus:ring-2 focus:ring-blue-500 outline-none">
                        <option value="3">3 Soru</option>
                        <option value="5">5 Soru</option>
                        <option value="10">10 Soru</option>
                        <option value="20">20 Soru</option>
                     </select>
                  </div>
                </div>

                <button type="submit" disabled={loading} className="w-full bg-gradient-to-r from-blue-600 to-blue-700 text-white p-4 rounded-xl font-bold text-lg hover:shadow-lg hover:scale-[1.02] active:scale-[0.98] transition-all disabled:opacity-50 disabled:cursor-not-allowed">
                  {loading ? "Yapay Zeka Çalışıyor..." : "✨ Sınavı Oluştur"}
                </button>
              </form>

              
            </div>

            {/* SAĞ TARAF: SONUÇLAR */}
            <div className="space-y-6">
              <div className="flex justify-between items-end border-b border-gray-200 pb-4">
                <div>
                   <h2 className="text-2xl font-bold text-gray-800">Sonuçlar</h2>
                   <p className="text-sm text-gray-500">Yapay zeka tarafından üretilen içerik</p>
                </div>
                {questions.length > 0 && (
                  <button onClick={downloadAsTxt} className="bg-green-600 hover:bg-green-700 text-white text-sm font-bold py-2 px-4 rounded-lg transition-all shadow-md flex items-center gap-2">
                    <span>📥</span> .TXT İndir
                  </button>
                )}
              </div>

              {questions.length === 0 && !loading && (
                 <div className="flex flex-col items-center justify-center py-20 bg-white border-2 border-dashed border-gray-200 rounded-2xl text-gray-400">
                    <div className="text-6xl mb-4 opacity-20">📝</div>
                    <p>Henüz bir sınav oluşturulmadı.</p>
                    <p className="text-sm mt-2">Sol taraftan dosya yükleyerek başlayın.</p>
                 </div>
              )}

              {loading && (
                <div className="flex flex-col items-center justify-center py-20 bg-white rounded-2xl shadow-sm border border-gray-100">
                  <div className="animate-spin rounded-full h-16 w-16 border-4 border-blue-100 border-t-blue-600 mb-6"></div>
                  <h3 className="text-xl font-bold text-gray-800 animate-pulse">Analiz Ediliyor...</h3>
                  <p className="text-gray-500 mt-2">Bu işlem dosya boyutuna göre 5-10 saniye sürebilir.</p>
                </div>
              )}

              <div className="space-y-6">
                {/* BURASI DEĞİŞTİ: Artık her soru için QuestionCard bileşenini kullanıyoruz */}
                {questions.map((q, index) => (
                  <QuestionCard key={index} q={q} index={index} />
                ))}
              </div>
            </div>
          </div>
        </div>
      </div>

      {/* 2. BÖLÜM: NASIL ÇALIŞIR? */}
      <div className="relative bg-white pt-24 pb-24" id="nasil-calisir">
        <div className="absolute top-0 left-0 w-full overflow-hidden leading-[0]">
           <svg className="relative block w-[calc(100%+1.3px)] h-[50px] md:h-[100px]" data-name="Layer 1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 120" preserveAspectRatio="none">
              <path d="M321.39,56.44c58-10.79,114.16-30.13,172-41.86,82.39-16.72,168.19-17.73,250.45-.39C823.78,31,906.67,72,985.66,92.83c70.05,18.48,146.53,26.09,214.34,3V0H0V27.35A600.21,600.21,0,0,0,321.39,56.44Z" className="fill-gray-50"></path>
           </svg>
        </div>

        <div className="max-w-6xl mx-auto px-4 md:px-10 relative z-10">
          <div className="text-center mb-16">
            <span className="text-blue-600 font-bold tracking-wider uppercase text-sm">Kolay Kullanım</span>
            <h2 className="text-3xl md:text-4xl font-extrabold text-gray-900 mt-2">Sadece 3 Adımda Hazır</h2>
            <div className="w-24 h-1 bg-blue-600 mx-auto mt-6 rounded-full"></div>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-10">
            <div className="flex flex-col items-center text-center group">
              <div className="w-20 h-20 bg-blue-50 text-blue-600 rounded-2xl flex items-center justify-center text-3xl mb-6 shadow-sm group-hover:scale-110 group-hover:bg-blue-600 group-hover:text-white transition-all duration-300">📤</div>
              <h3 className="font-bold text-xl mb-3 text-gray-800">1. Dosyanı Yükle</h3>
              <p className="text-gray-500 leading-relaxed px-4">Sınav yapmak istediğin PDF formatındaki ders notlarını sisteme yükle.</p>
            </div>
            <div className="flex flex-col items-center text-center group">
              <div className="w-20 h-20 bg-purple-50 text-purple-600 rounded-2xl flex items-center justify-center text-3xl mb-6 shadow-sm group-hover:scale-110 group-hover:bg-purple-600 group-hover:text-white transition-all duration-300">⚙️</div>
              <h3 className="font-bold text-xl mb-3 text-gray-800">2. Özelleştir</h3>
              <p className="text-gray-500 leading-relaxed px-4">Sınavın zorluk seviyesini, soru sayısını ve tipini ayarla.</p>
            </div>
            <div className="flex flex-col items-center text-center group">
              <div className="w-20 h-20 bg-green-50 text-green-600 rounded-2xl flex items-center justify-center text-3xl mb-6 shadow-sm group-hover:scale-110 group-hover:bg-green-600 group-hover:text-white transition-all duration-300">💾</div>
              <h3 className="font-bold text-xl mb-3 text-gray-800">3. Çöz ve İndir</h3>
              <p className="text-gray-500 leading-relaxed px-4">Soruları interaktif olarak çöz veya .TXT olarak indir.</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}