// @ts-nocheck
import { NextRequest, NextResponse } from "next/server";
import { GoogleGenerativeAI } from "@google/generative-ai";
import pdf from "pdf-parse";

export const dynamic = 'force-dynamic';

export async function POST(req: NextRequest) {
  try {
    const formData = await req.formData();
    const file = formData.get("file") as File;
    const difficulty = formData.get("difficulty") || "Orta";
    const questionCount = formData.get("questionCount") || "5";
    // YENİ: Sınav Tipi bilgisini alıyoruz
    const examType = formData.get("examType") || "coktan_secmeli"; 

    if (!file) {
      return NextResponse.json({ error: "Lütfen bir dosya seçin." }, { status: 400 });
    }

    const arrayBuffer = await file.arrayBuffer();
    const buffer = Buffer.from(arrayBuffer);
    const data = await pdf(buffer);
    
    const genAI = new GoogleGenerativeAI(process.env.NEXT_PUBLIC_GEMINI_API_KEY!);
    const model = genAI.getGenerativeModel({ model: "gemini-3-flash-preview" });

    // YENİ: İstenen sınav tipine göre Prompt'u değiştiriyoruz
    let promptConfig = "";
    
    if (examType === "klasik") {
      promptConfig = `
        Soru Tipi: KLASİK (Açık Uçlu / Yazılı Sorusu).
        Şıklar (A,B,C,D,E) OLMASIN.
        JSON Formatı:
        [
          {"soru": "Soru metni buraya", "dogru_cevap": "Örnek cevap veya anahtar kelimeler buraya"}
        ]
      `;
    } else {
      promptConfig = `
        Soru Tipi: ÇOKTAN SEÇMELİ (Test).
        5 adet şık olsun.
        JSON Formatı:
        [
          {"soru": "Soru metni", "secenekler": ["A) ...", "B) ...", "C) ...", "D) ...", "E) ..."], "dogru_cevap": "A"}
        ]
      `;
    }

    const prompt = `
      Sen uzman bir öğretmensin. Aşağıdaki metni kaynak alarak sınav soruları hazırla.
      Zorluk Seviyesi: ${difficulty}
      Soru Sayısı: ${questionCount}
      
      ${promptConfig}

      SADECE JSON ver. Markdown kullanma.

      KAYNAK METİN:
      ${data.text.substring(0, 20000)}
    `;

    const result = await model.generateContent(prompt);
    const responseText = result.response.text();
    const cleanedJson = responseText.replace(/```json|```/g, "").trim();
    
    return NextResponse.json(JSON.parse(cleanedJson));

  } catch (error: any) {
    console.error("HATA:", error);
    return NextResponse.json({ error: error.message }, { status: 500 });
  }
}