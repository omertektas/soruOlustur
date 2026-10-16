# Kurulum rehberi

Sırayla yapın. Supabase ve Vercel ayarları **kodu GitHub'a göndermeden önce** tamamlanmalı; aksi halde Vercel derlemesi başarısız olur (eski site yayında kalmaya devam eder).

## 1. Supabase projesi

1. https://supabase.com adresinde **GitHub ile** ücretsiz hesap açın.
2. **New project** → ad: `mulakat-defteri`, bölge: **Central EU (Frankfurt)**. Veritabanı şifresini bir yere kaydedin.
3. Proje hazır olunca sol menüden **SQL Editor** → **New query**:
   - `supabase/schema.sql` dosyasının tamamını yapıştırın → **Run**
   - Yeni bir sorgu açıp `supabase/seed.sql` dosyasının tamamını yapıştırın → **Run**
4. **Authentication → URL Configuration**:
   - Site URL: `https://www.oftechsolutions.com`
   - Redirect URLs: `https://www.oftechsolutions.com/**` ve `http://localhost:3000/**`
5. **Project Settings → API** (veya **API Keys**) sayfasından iki değeri kopyalayın:
   - Project URL
   - `anon` `public` anahtarı (yeni projelerde "publishable key" adıyla da geçer)

## 2. Vercel ortam değişkenleri

Vercel → **soruOlustur** projesi → **Settings → Environment Variables**. Üç değişkeni ekleyin (Production, Preview, Development hepsi seçili):

| Ad | Değer |
| --- | --- |
| `NEXT_PUBLIC_SUPABASE_URL` | Supabase Project URL |
| `NEXT_PUBLIC_SUPABASE_ANON_KEY` | Supabase anon / publishable anahtar |
| `NEXT_PUBLIC_SITE_URL` | `https://www.oftechsolutions.com` |

Eski projeden kalan Gemini anahtarı artık kullanılmıyor, isterseniz silebilirsiniz.

## 3. Kodu gönderin

```powershell
git add -A
git commit -m "Mülakat Defteri: full stack sürüm"
git push
```

Vercel 1–2 dakika içinde yeni sürümü yayına alır. **Deployments** sekmesinden derlemeyi izleyebilirsiniz.

## 4. Kendinizi yönetici yapın

1. Sitede **Giriş yap → Kayıt ol** ile hesap açın, e-postadaki bağlantıya tıklayın.
2. Supabase **SQL Editor**'de çalıştırın:

```sql
update public.profiles set role = 'admin'
where id = (select id from auth.users where email = 'omertektas0824@gmail.com');
```

3. Sayfayı yenileyin; üst menüde **Yönetim** bağlantısı görünür.

## 5. Google'a tanıtın

1. https://search.google.com/search-console → **Mülk ekle** → `oftechsolutions.com` (Alan adı). Cloudflare DNS'e TXT kaydı eklemeniz istenir.
2. **Site haritaları** bölümüne `https://www.oftechsolutions.com/sitemap.xml` ekleyin.

## Notlar

- Supabase'in ücretsiz e-posta servisi saatte birkaç e-postayla sınırlıdır. Kullanıcı sayısı artınca **Authentication → SMTP Settings** bölümünden Resend, Brevo gibi bir e-posta servisi bağlayın.
- Ücretsiz Supabase projeleri 7 gün hiç kullanılmazsa duraklatılır; site trafik aldıkça bu olmaz.
