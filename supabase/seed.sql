-- Mülakat Defteri — initial content (321 questions)
-- Run AFTER schema.sql. Idempotent (safe to run again).

insert into public.professions (slug, name, short_name, description, sort_order) values
  ($md$frontend-developer$md$, $md$Frontend Developer$md$, $md$Frontend$md$, $md$JavaScript, TypeScript, React, Next.js, HTML & CSS, tarayıcı, performans, erişilebilirlik ve test üzerine frontend mülakat soruları.$md$, 10),
  ($md$backend-developer$md$, $md$Backend Developer$md$, $md$Backend$md$, $md$Node.js, Python, SQL ve veritabanları, API tasarımı, Docker ve ölçeklenebilir sistemler üzerine backend mülakat soruları.$md$, 20),
  ($md$full-stack-developer$md$, $md$Full Stack Developer$md$, $md$Full Stack$md$, $md$Web güvenliği, web mimarisi, sistem tasarımı ve Git: uçtan uca uygulama geliştirme üzerine full stack mülakat soruları.$md$, 30),
  ($md$yazilim-muhendisi$md$, $md$Yazılım Mühendisi$md$, $md$Yazılım Müh.$md$, $md$Algoritmalar, veri yapıları, OOP ve tasarım desenleri, işletim sistemleri ve davranışsal sorular: her yazılım pozisyonunun temeli.$md$, 40),
  ($md$game-developer$md$, $md$Oyun Geliştirici (Game Developer)$md$, $md$Game Dev$md$, $md$Unity ve C#, oyun döngüsü, yapay zekâ, oyun matematiği ve grafik/render üzerine oyun geliştirici mülakat soruları.$md$, 50),
  ($md$network-engineer$md$, $md$Network Mühendisi$md$, $md$Network$md$, $md$OSI ve TCP/IP, alt ağlar, yönlendirme ve anahtarlama, VLAN, OSPF, BGP ve ağ güvenliği üzerine network mühendisi mülakat soruları.$md$, 60),
  ($md$embedded-engineer$md$, $md$Gömülü Sistem Mühendisi (Embedded)$md$, $md$Embedded$md$, $md$C programlama, mikrodenetleyiciler, kesmeler, UART/SPI/I2C ve RTOS üzerine gömülü sistemler mülakat soruları.$md$, 70),
  ($md$elektrik-elektronik-muhendisi$md$, $md$Elektrik-Elektronik Mühendisi$md$, $md$Elektrik-Elektronik$md$, $md$Devre analizi, elektronik, güç sistemleri, kontrol ve sinyal işleme üzerine elektrik-elektronik mühendisliği mülakat soruları.$md$, 80)
on conflict (slug) do update set name = excluded.name, short_name = excluded.short_name, description = excluded.description, sort_order = excluded.sort_order;

insert into public.topics (slug, name) values
  ($md$javascript$md$, $md$JavaScript$md$),
  ($md$react$md$, $md$React$md$),
  ($md$html-css$md$, $md$HTML & CSS$md$),
  ($md$web-mimarisi$md$, $md$Web Mimarisi$md$),
  ($md$python$md$, $md$Python$md$),
  ($md$veritabani-sql$md$, $md$Veritabanı & SQL$md$),
  ($md$api-tasarimi$md$, $md$API Tasarımı$md$),
  ($md$sistem-tasarimi$md$, $md$Sistem Tasarımı$md$),
  ($md$web-guvenligi$md$, $md$Web Güvenliği$md$),
  ($md$git$md$, $md$Git$md$),
  ($md$algoritmalar$md$, $md$Algoritmalar & Veri Yapıları$md$),
  ($md$davranissal$md$, $md$Davranışsal$md$),
  ($md$unity-csharp$md$, $md$Unity & C#$md$),
  ($md$oyun-programlama$md$, $md$Oyun Programlama$md$),
  ($md$oyun-matematigi$md$, $md$Oyun Matematiği$md$),
  ($md$ag-temelleri$md$, $md$Ağ Temelleri$md$),
  ($md$yonlendirme-anahtarlama$md$, $md$Yönlendirme & Anahtarlama$md$),
  ($md$c-programlama$md$, $md$C Programlama$md$),
  ($md$mikrodenetleyiciler$md$, $md$Mikrodenetleyiciler$md$),
  ($md$haberlesme-protokolleri$md$, $md$Haberleşme Protokolleri$md$),
  ($md$rtos$md$, $md$RTOS$md$),
  ($md$typescript$md$, $md$TypeScript$md$),
  ($md$nextjs$md$, $md$Next.js$md$),
  ($md$tarayici-ve-web-api$md$, $md$Tarayıcı & Web API'leri$md$),
  ($md$web-performansi$md$, $md$Web Performansı$md$),
  ($md$erisilebilirlik$md$, $md$Erişilebilirlik$md$),
  ($md$test$md$, $md$Test$md$),
  ($md$nodejs$md$, $md$Node.js$md$),
  ($md$docker-devops$md$, $md$Docker & DevOps$md$),
  ($md$oop-tasarim-desenleri$md$, $md$OOP & Tasarım Desenleri$md$),
  ($md$isletim-sistemleri$md$, $md$İşletim Sistemleri$md$),
  ($md$grafik-render$md$, $md$Grafik & Render$md$),
  ($md$ag-guvenligi$md$, $md$Ağ Güvenliği$md$),
  ($md$devre-analizi$md$, $md$Devre Analizi$md$),
  ($md$elektronik$md$, $md$Elektronik$md$),
  ($md$guc-sistemleri$md$, $md$Güç Sistemleri$md$),
  ($md$kontrol-sistemleri$md$, $md$Kontrol Sistemleri$md$),
  ($md$sinyal-isleme$md$, $md$Sinyal İşleme$md$)
on conflict (slug) do update set name = excluded.name;

insert into public.questions (slug, title, answer, tip, difficulty, profession_id, topic_id, status, reviewed_at)
select v.slug, v.title, v.answer, v.tip, v.difficulty::public.difficulty, p.id, t.id, 'approved', now()
from (values
  ($md$var-let-ve-const-arasindaki-fark-nedir$md$, $md$var, let ve const arasındaki fark nedir?$md$, $md$`var` fonksiyon kapsamlıdır ve hoisting sırasında `undefined` ile başlatılır. `let` ve `const` blok kapsamlıdır; tanımlandıkları satırdan önce erişilirse `ReferenceError` verir (Temporal Dead Zone).

`const` değişkene yeniden atama yapılmasını engeller, ama nesnenin içini değiştirmeyi engellemez.

```js
const user = { ad: "Ali" };
user.ad = "Ayşe";   // geçerli
user = {};          // TypeError
```$md$, $md$Varsayılan olarak const, yeniden atama gerekiyorsa let kullandığınızı söyleyin.$md$, $md$easy$md$, $md$frontend-developer$md$, $md$javascript$md$),
  ($md$ile-arasindaki-fark-nedir$md$, $md$== ile === arasındaki fark nedir?$md$, $md$`==` karşılaştırmadan önce tür dönüşümü (type coercion) yapar, `===` hem değeri hem türü kontrol eder.

```js
0 == "0"     // true
0 === "0"    // false
null == undefined   // true
null === undefined  // false
```$md$, null, $md$easy$md$, $md$frontend-developer$md$, $md$javascript$md$),
  ($md$closure-nedir-bir-ornekle-aciklayin$md$, $md$Closure nedir? Bir örnekle açıklayın.$md$, $md$Closure, bir fonksiyonun tanımlandığı ortamdaki değişkenlere, o ortamın çalışması bittikten sonra da erişebilmesidir. Veri gizleme, fabrika fonksiyonları ve memoization için kullanılır.

```js
function sayac() {
  let n = 0;
  return () => ++n;
}
const say = sayac();
say(); // 1
say(); // 2  — n dışarıdan erişilemez ama korunur
```$md$, $md$Döngü içinde var ile setTimeout klasik tuzağını bilmek artı puan kazandırır.$md$, $md$medium$md$, $md$frontend-developer$md$, $md$javascript$md$),
  ($md$asagidaki-kodun-ciktisi-nedir-event-loop$md$, $md$Aşağıdaki kodun çıktısı nedir? (Event loop)$md$, $md$Çıktı: `1, 4, 3, 2`. Senkron kod önce çalışır. Ardından microtask kuyruğu (Promise) boşaltılır, en son macrotask kuyruğu (setTimeout) işlenir.

```js
console.log(1);
setTimeout(() => console.log(2), 0);
Promise.resolve().then(() => console.log(3));
console.log(4);
```$md$, null, $md$medium$md$, $md$frontend-developer$md$, $md$javascript$md$),
  ($md$this-anahtar-kelimesi-nasil-belirlenir-arrow-function-larda-ne-degisir$md$, $md$this anahtar kelimesi nasıl belirlenir? Arrow function'larda ne değişir?$md$, $md$Normal fonksiyonlarda `this`, fonksiyonun **nasıl çağrıldığına** göre belirlenir: metod olarak çağrılırsa nesne, `new` ile yeni nesne, `call/apply/bind` ile verilen değer, düz çağrıda strict modda `undefined`.

Arrow function'ların kendi `this`'i yoktur; tanımlandıkları kapsamın `this`'ini kullanırlar. Bu yüzden nesne metodu olarak kullanılmaları genelde hatadır.$md$, null, $md$medium$md$, $md$frontend-developer$md$, $md$javascript$md$),
  ($md$bir-debounce-fonksiyonu-yazin$md$, $md$Bir debounce fonksiyonu yazın.$md$, $md$Debounce, fonksiyonun ard arda çağrılarını birleştirir ve son çağrıdan belirli bir süre sonra yalnızca bir kez çalıştırır. Arama kutusu ve pencere boyutlandırma için kullanılır.

```js
function debounce(fn, ms) {
  let timer;
  return function (...args) {
    clearTimeout(timer);
    timer = setTimeout(() => fn.apply(this, args), ms);
  };
}

const ara = debounce(q => fetchResults(q), 300);
```$md$, $md$Ardından throttle ile farkını sorabilirler: throttle belirli aralıklarla en fazla bir kez çalıştırır.$md$, $md$hard$md$, $md$frontend-developer$md$, $md$javascript$md$),
  ($md$prototip-tabanli-kalitim-nasil-calisir$md$, $md$Prototip tabanlı kalıtım nasıl çalışır?$md$, $md$Her nesnenin gizli bir `[[Prototype]]` bağlantısı vardır. Bir özellik nesnede bulunamazsa JavaScript prototip zincirinde yukarı doğru arar, `null`'a ulaşınca durur. `class` sözdizimi bu mekanizmanın üzerine kurulmuş bir kolaylıktır.

```js
const hayvan = { ses() { return "..." } };
const kedi = Object.create(hayvan);
kedi.ses();                                   // "..."
Object.getPrototypeOf(kedi) === hayvan;       // true
```$md$, null, $md$hard$md$, $md$frontend-developer$md$, $md$javascript$md$),
  ($md$virtual-dom-nedir-ve-reconciliation-nasil-calisir$md$, $md$Virtual DOM nedir ve reconciliation nasıl çalışır?$md$, $md$Virtual DOM, gerçek DOM'un bellekteki hafif bir JavaScript temsilidir. State değişince React yeni bir ağaç üretir, önceki ağaçla karşılaştırır (diffing) ve gerçek DOM'a yalnızca gereken değişiklikleri uygular.

Farklı türde elemanlar tamamen yeniden oluşturulur; liste elemanları `key` ile eşleştirilir.$md$, null, $md$easy$md$, $md$frontend-developer$md$, $md$react$md$),
  ($md$listelerde-key-prop-neden-onemlidir-index-kullanmak-neden-sorunludur$md$, $md$Listelerde key prop neden önemlidir? Index kullanmak neden sorunludur?$md$, $md$`key`, React'in hangi elemanın eklendiğini, silindiğini veya yer değiştirdiğini anlamasını sağlar. Index kullanıldığında liste sıralanınca veya başa eleman eklenince key'ler kayar; bu da yanlış elemanın state'ini korumaya ve gereksiz render'a yol açar.$md$, $md$Veritabanı id'si gibi kararlı ve benzersiz bir değer kullanın.$md$, $md$easy$md$, $md$frontend-developer$md$, $md$react$md$),
  ($md$controlled-ve-uncontrolled-component-farki-nedir$md$, $md$Controlled ve uncontrolled component farkı nedir?$md$, $md$**Controlled** component'te input'un değeri React state'inde tutulur ve `onChange` ile güncellenir; tek doğru kaynak React'tir. **Uncontrolled** component'te değer DOM'da kalır ve gerektiğinde `ref` ile okunur.

```jsx
// Controlled
const [ad, setAd] = useState("");
<input value={ad} onChange={e => setAd(e.target.value)} />

// Uncontrolled
const ref = useRef();
<input defaultValue="" ref={ref} />
```$md$, null, $md$easy$md$, $md$frontend-developer$md$, $md$react$md$),
  ($md$useeffect-bagimlilik-dizisi-nasil-calisir$md$, $md$useEffect bağımlılık dizisi nasıl çalışır?$md$, $md$- Dizi yoksa: her render'dan sonra çalışır.
- `[]`: yalnızca ilk mount'ta çalışır.
- `[a, b]`: `a` veya `b` değiştiğinde çalışır.

Döndürülen fonksiyon cleanup'tır; bir sonraki effect'ten önce ve unmount'ta çalışır. Abonelik, timer ve event listener'lar burada temizlenmelidir.

```jsx
useEffect(() => {
  const id = setInterval(tick, 1000);
  return () => clearInterval(id);
}, []);
```$md$, null, $md$medium$md$, $md$frontend-developer$md$, $md$react$md$),
  ($md$usememo-ile-usecallback-arasindaki-fark-nedir$md$, $md$useMemo ile useCallback arasındaki fark nedir?$md$, $md$`useMemo` bir hesaplamanın **sonucunu**, `useCallback` ise bir **fonksiyonun kendisini** bağımlılıklar değişmedikçe saklar. `useCallback(fn, deps)`, `useMemo(() => fn, deps)` ile aynıdır.

İkisi de genellikle `React.memo` ile sarılmış alt bileşenlere sabit referans geçmek veya pahalı hesaplamaları önlemek için kullanılır.$md$, $md$Her yere eklemenin de bir maliyeti olduğunu, ölçmeden optimizasyon yapmadığınızı belirtin.$md$, $md$medium$md$, $md$frontend-developer$md$, $md$react$md$),
  ($md$gereksiz-render-lari-nasil-tespit-eder-ve-onlersiniz$md$, $md$Gereksiz render'ları nasıl tespit eder ve önlersiniz?$md$, $md$- React DevTools Profiler ile hangi bileşenin neden render olduğunu ölçün.
- State'i ihtiyaç duyulan en alt bileşene taşıyın (state colocation).
- Saf alt bileşenleri `React.memo` ile sarın, prop olarak geçen nesne ve fonksiyonları `useMemo`/`useCallback` ile sabitleyin.
- Büyük context'leri bölün; sık değişen değerleri ayrı context'e alın.
- Uzun listelerde sanallaştırma (virtualization) kullanın.$md$, null, $md$hard$md$, $md$frontend-developer$md$, $md$react$md$),
  ($md$semantik-html-nedir-neden-onemlidir$md$, $md$Semantik HTML nedir, neden önemlidir?$md$, $md$İçeriğin anlamını belirten etiketleri (`header`, `nav`, `main`, `article`, `button`) `div` yerine kullanmaktır. Ekran okuyucular, klavye erişimi ve SEO için önemlidir; kodu da okunabilir yapar.$md$, $md$Tıklanabilir bir div yerine button kullanmanın klavye ve erişilebilirlik avantajını örnek verin.$md$, $md$easy$md$, $md$frontend-developer$md$, $md$html-css$md$),
  ($md$css-box-model-nedir-box-sizing-border-box-ne-ise-yarar$md$, $md$CSS box model nedir? box-sizing: border-box ne işe yarar?$md$, $md$Her eleman içten dışa **content, padding, border, margin** katmanlarından oluşur. Varsayılan `content-box`'ta `width` yalnızca içeriği kapsar; padding ve border eklenince eleman büyür. `border-box`'ta `width` padding ve border'ı da içerir, bu da boyut hesabını kolaylaştırır.$md$, null, $md$easy$md$, $md$frontend-developer$md$, $md$html-css$md$),
  ($md$position-degerleri-nelerdir$md$, $md$position değerleri nelerdir?$md$, $md$- `static`: varsayılan, normal akış.
- `relative`: normal yerine göre kaydırılır, yerini korur.
- `absolute`: akıştan çıkar, en yakın konumlandırılmış atasına göre yerleşir.
- `fixed`: görünüm alanına (viewport) göre sabitlenir.
- `sticky`: belirlenen eşiğe gelene kadar relative, sonra fixed gibi davranır.$md$, null, $md$easy$md$, $md$frontend-developer$md$, $md$html-css$md$),
  ($md$flexbox-ile-grid-arasindaki-fark-nedir-hangisini-ne-zaman-secersiniz$md$, $md$Flexbox ile Grid arasındaki fark nedir? Hangisini ne zaman seçersiniz?$md$, $md$**Flexbox** tek boyutludur (satır ya da sütun); içerik boyutuna göre esneyen bileşen içi hizalamalar için idealdir: navbar, buton grubu. **Grid** iki boyutludur; satır ve sütunları birlikte tanımlayan sayfa düzenleri ve kart ızgaraları için uygundur.$md$, null, $md$medium$md$, $md$frontend-developer$md$, $md$html-css$md$),
  ($md$css-specificity-nasil-hesaplanir$md$, $md$CSS specificity nasıl hesaplanır?$md$, $md$Öncelik sırası: inline stil > id > class, attribute ve pseudo-class > element ve pseudo-element. Genellikle (id, class, element) şeklinde üç sayı ile ifade edilir; eşitlikte sonra yazılan kural kazanır. `!important` bu sıralamayı geçersiz kılar ve kaçınılması gerekir.

```css
#menu .link      /* (1, 1, 0) */
nav ul li a      /* (0, 0, 4) */
.nav .link:hover /* (0, 3, 0) */
```$md$, null, $md$medium$md$, $md$frontend-developer$md$, $md$html-css$md$),
  ($md$list-ve-tuple-arasindaki-fark-nedir$md$, $md$list ve tuple arasındaki fark nedir?$md$, $md$`list` değiştirilebilir (mutable), `tuple` değiştirilemezdir (immutable). Tuple'lar hashlenebilir olduğu için (içerikleri de immutable ise) sözlük anahtarı olarak kullanılabilir ve biraz daha az bellek kullanır.$md$, null, $md$easy$md$, $md$backend-developer$md$, $md$python$md$),
  ($md$varsayilan-arguman-olarak-liste-vermek-neden-tehlikelidir$md$, $md$Varsayılan argüman olarak liste vermek neden tehlikelidir?$md$, $md$Varsayılan değerler fonksiyon **tanımlandığında** bir kez oluşturulur. Mutable bir varsayılan, çağrılar arasında paylaşılır.

```python
def ekle(x, liste=[]):
    liste.append(x)
    return liste

ekle(1)  # [1]
ekle(2)  # [1, 2]  ← beklenmedik

# Doğrusu
def ekle(x, liste=None):
    if liste is None:
        liste = []
    liste.append(x)
    return liste
```$md$, null, $md$medium$md$, $md$backend-developer$md$, $md$python$md$),
  ($md$decorator-nedir-basit-bir-zamanlama-decorator-i-yazin$md$, $md$Decorator nedir? Basit bir zamanlama decorator'ı yazın.$md$, $md$Decorator, bir fonksiyonu alıp davranışını değiştiren yeni bir fonksiyon döndüren fonksiyondur. Loglama, yetki kontrolü, cache gibi işlerde kullanılır.

```python
import time
from functools import wraps

def sure_olc(fn):
    @wraps(fn)
    def sarici(*args, **kwargs):
        bas = time.perf_counter()
        sonuc = fn(*args, **kwargs)
        print(f"{fn.__name__}: {time.perf_counter() - bas:.3f}s")
        return sonuc
    return sarici

@sure_olc
def hesapla(): ...
```$md$, $md$functools.wraps kullanmanın fonksiyon adını ve docstring'i koruduğunu söyleyin.$md$, $md$medium$md$, $md$backend-developer$md$, $md$python$md$),
  ($md$generator-nedir-yield-ne-yapar$md$, $md$Generator nedir, yield ne yapar?$md$, $md$Generator, değerleri tek seferde bellekte tutmak yerine istendikçe üreten bir iteratördür. `yield` değeri döndürür ve fonksiyonun durumunu dondurur; bir sonraki `next()` çağrısında kaldığı yerden devam eder. Büyük dosyaları satır satır okumak gibi işler için uygundur.

```python
def kareler(n):
    for i in range(n):
        yield i * i

toplam = sum(kareler(10_000_000))  # liste oluşturmaz
```$md$, null, $md$medium$md$, $md$backend-developer$md$, $md$python$md$),
  ($md$gil-nedir-ve-coklu-is-parcacigini-nasil-etkiler$md$, $md$GIL nedir ve çoklu iş parçacığını nasıl etkiler?$md$, $md$Global Interpreter Lock, CPython'da aynı anda yalnızca bir thread'in Python bytecode çalıştırmasına izin veren kilittir. Bu yüzden CPU yoğun işlerde thread'ler gerçek paralellik sağlamaz.

- I/O yoğun işler (ağ, disk): `threading` veya `asyncio` yeterlidir, çünkü I/O beklerken GIL bırakılır.
- CPU yoğun işler: `multiprocessing` veya GIL'i bırakan C uzantıları (NumPy) kullanılır.$md$, $md$Python 3.13 ile deneysel olarak gelen GIL'siz (free-threaded) derlemeden haberdar olduğunuzu gösterebilirsiniz.$md$, $md$hard$md$, $md$backend-developer$md$, $md$python$md$),
  ($md$binary-search-un-zaman-karmasikligi-nedir-ve-neden$md$, $md$Binary search'ün zaman karmaşıklığı nedir ve neden?$md$, $md$**O(log n)**. Her adımda arama aralığı yarıya iner; n elemanlı bir dizide en fazla log₂n adım gerekir. Önkoşul dizinin sıralı olmasıdır.$md$, null, $md$easy$md$, $md$yazilim-muhendisi$md$, $md$algoritmalar$md$),
  ($md$two-sum-toplami-hedefe-esit-olan-iki-elemanin-indekslerini-bulun$md$, $md$Two Sum: toplamı hedefe eşit olan iki elemanın indekslerini bulun.$md$, $md$Kaba kuvvet çözüm O(n²)'dir. Hash map ile her eleman için tamamlayıcısını (hedef − x) daha önce görüp görmediğimizi kontrol ederek **O(n)** zaman, O(n) alanda çözülür.

```js
function twoSum(nums, hedef) {
  const gorulen = new Map();
  for (let i = 0; i < nums.length; i++) {
    const eksik = hedef - nums[i];
    if (gorulen.has(eksik)) return [gorulen.get(eksik), i];
    gorulen.set(nums[i], i);
  }
  return [];
}
```$md$, $md$Önce kaba kuvvet çözümü söyleyip sonra optimize etmek, düşünce sürecinizi gösterir.$md$, $md$easy$md$, $md$yazilim-muhendisi$md$, $md$algoritmalar$md$),
  ($md$bir-parantez-dizisinin-gecerli-olup-olmadigini-kontrol-edin$md$, $md$Bir parantez dizisinin geçerli olup olmadığını kontrol edin: "({[]})"$md$, $md$Stack kullanılır. Açılan parantezi stack'e koyun; kapanan parantez gelince stack'in tepesi eşleşmiyorsa geçersizdir. Sonda stack boş olmalıdır. O(n) zaman.

```js
function gecerli(s) {
  const es = { ")": "(", "]": "[", "}": "{" };
  const st = [];
  for (const c of s) {
    if ("([{".includes(c)) st.push(c);
    else if (st.pop() !== es[c]) return false;
  }
  return st.length === 0;
}
```$md$, null, $md$easy$md$, $md$yazilim-muhendisi$md$, $md$algoritmalar$md$),
  ($md$tek-yonlu-bagli-listeyi-ters-cevirin$md$, $md$Tek yönlü bağlı listeyi ters çevirin.$md$, $md$Üç işaretçi ile yerinde (in-place) çözülür: `onceki`, `simdiki`, `sonraki`. O(n) zaman, O(1) alan.

```js
function tersCevir(head) {
  let onceki = null, simdiki = head;
  while (simdiki) {
    const sonraki = simdiki.next;
    simdiki.next = onceki;
    onceki = simdiki;
    simdiki = sonraki;
  }
  return onceki;
}
```$md$, null, $md$medium$md$, $md$yazilim-muhendisi$md$, $md$algoritmalar$md$),
  ($md$bfs-ve-dfs-arasindaki-fark-nedir-hangisini-ne-zaman-kullanirsiniz$md$, $md$BFS ve DFS arasındaki fark nedir? Hangisini ne zaman kullanırsınız?$md$, $md$**BFS** (genişlik öncelikli) kuyruk kullanır, seviye seviye ilerler; ağırlıksız grafta **en kısa yolu** bulur. **DFS** (derinlik öncelikli) stack veya özyineleme kullanır, bir dalın sonuna kadar gider; döngü tespiti, topolojik sıralama ve tüm yolları gezme için uygundur. İkisi de O(V + E)'dir.$md$, null, $md$medium$md$, $md$yazilim-muhendisi$md$, $md$algoritmalar$md$),
  ($md$get-ve-put-islemleri-o-1-olan-bir-lru-cache-tasarlayin$md$, $md$get ve put işlemleri O(1) olan bir LRU Cache tasarlayın.$md$, $md$Klasik çözüm hash map + çift yönlü bağlı listedir. JavaScript'te `Map` ekleme sırasını koruduğu için tek başına yeterlidir: erişilen anahtarı silip yeniden ekleyerek en sona taşırız, kapasite aşılınca ilk anahtarı sileriz.

```js
class LRUCache {
  constructor(kapasite) {
    this.k = kapasite;
    this.m = new Map();
  }
  get(key) {
    if (!this.m.has(key)) return -1;
    const v = this.m.get(key);
    this.m.delete(key);
    this.m.set(key, v);
    return v;
  }
  put(key, v) {
    this.m.delete(key);
    this.m.set(key, v);
    if (this.m.size > this.k) this.m.delete(this.m.keys().next().value);
  }
}
```$md$, $md$Mülakatçı dil bağımsız çözümü isterse hash map + çift yönlü bağlı liste yapısını çizerek anlatın.$md$, $md$hard$md$, $md$yazilim-muhendisi$md$, $md$algoritmalar$md$),
  ($md$inner-join-ile-left-join-arasindaki-fark-nedir$md$, $md$INNER JOIN ile LEFT JOIN arasındaki fark nedir?$md$, $md$**INNER JOIN** yalnızca iki tabloda da eşleşen satırları döndürür. **LEFT JOIN** sol tablonun tüm satırlarını döndürür; sağda eşleşme yoksa o kolonlar `NULL` olur.

```sql
-- Hiç sipariş vermemiş müşteriler
SELECT m.ad
FROM musteriler m
LEFT JOIN siparisler s ON s.musteri_id = m.id
WHERE s.id IS NULL;
```$md$, null, $md$easy$md$, $md$backend-developer$md$, $md$veritabani-sql$md$),
  ($md$bir-tablodaki-ikinci-en-yuksek-maasi-bulun$md$, $md$Bir tablodaki ikinci en yüksek maaşı bulun.$md$, $md$Birkaç yolu vardır. En taşınabilir olanı alt sorgu, en esneği pencere fonksiyonudur (N'inci değer için de çalışır).

```sql
-- Alt sorgu
SELECT MAX(maas) FROM calisanlar
WHERE maas < (SELECT MAX(maas) FROM calisanlar);

-- Pencere fonksiyonu
SELECT DISTINCT maas FROM (
  SELECT maas, DENSE_RANK() OVER (ORDER BY maas DESC) AS sira
  FROM calisanlar
) t WHERE sira = 2;
```$md$, null, $md$medium$md$, $md$backend-developer$md$, $md$veritabani-sql$md$),
  ($md$index-nedir-dezavantajlari-nelerdir$md$, $md$Index nedir? Dezavantajları nelerdir?$md$, $md$Index, belirli kolonlar üzerinde (genelde B-tree) tutulan ve aramayı tam tablo taramasından O(log n)'e indiren yardımcı yapıdır.

- Ek disk alanı kaplar.
- Her INSERT/UPDATE/DELETE'te güncellenmesi gerektiği için yazmayı yavaşlatır.
- Seçiciliği düşük kolonlarda (ör. cinsiyet) çok az fayda sağlar.$md$, $md$EXPLAIN ile sorgu planını incelediğinizi ve bileşik index'te kolon sırasının önemini belirtin.$md$, $md$medium$md$, $md$backend-developer$md$, $md$veritabani-sql$md$),
  ($md$acid-nedir$md$, $md$ACID nedir?$md$, $md$- **Atomicity**: işlem ya tamamen gerçekleşir ya hiç gerçekleşmez.
- **Consistency**: işlem veritabanını bir geçerli durumdan diğerine taşır, kısıtlar korunur.
- **Isolation**: eşzamanlı işlemler birbirini bozmaz (izolasyon seviyeleri ile ayarlanır).
- **Durability**: onaylanan (commit) işlem çökme sonrasında da kalıcıdır.$md$, null, $md$medium$md$, $md$backend-developer$md$, $md$veritabani-sql$md$),
  ($md$normalizasyon-nedir-ne-zaman-denormalizasyon-yaparsiniz$md$, $md$Normalizasyon nedir? Ne zaman denormalizasyon yaparsınız?$md$, $md$Normalizasyon, veri tekrarını ve güncelleme anomalilerini azaltmak için tabloları bölme sürecidir (1NF: atomik değerler, 2NF: kısmi bağımlılık yok, 3NF: geçişli bağımlılık yok).

Okuma yoğun sistemlerde, raporlamada veya çok sayıda JOIN performansı düşürdüğünde bilinçli olarak denormalizasyon yapılır; bunun karşılığında tutarlılığı uygulama tarafında korumak gerekir.$md$, null, $md$hard$md$, $md$backend-developer$md$, $md$veritabani-sql$md$),
  ($md$dikey-ve-yatay-olcekleme-arasindaki-fark-nedir$md$, $md$Dikey ve yatay ölçekleme arasındaki fark nedir?$md$, $md$**Dikey ölçekleme** mevcut sunucuya daha fazla CPU/RAM eklemektir; basittir ama donanım sınırı vardır ve tek hata noktası oluşturur. **Yatay ölçekleme** daha fazla sunucu eklemektir; load balancer ve durumsuz (stateless) servisler gerektirir ama neredeyse sınırsız büyür.$md$, null, $md$easy$md$, $md$full-stack-developer$md$, $md$sistem-tasarimi$md$),
  ($md$hangi-cache-stratejilerini-biliyorsunuz$md$, $md$Hangi cache stratejilerini biliyorsunuz?$md$, $md$- **Cache-aside**: uygulama önce cache'e bakar, yoksa DB'den okuyup cache'e yazar. En yaygın olanıdır.
- **Write-through**: yazma cache ve DB'ye aynı anda yapılır; tutarlıdır ama yazma yavaşlar.
- **Write-back**: önce cache'e yazılır, DB'ye sonra toplu aktarılır; hızlıdır ama veri kaybı riski vardır.

Ayrıca TTL, tahliye politikası (LRU) ve cache invalidation sorunlarından bahsedin.$md$, null, $md$medium$md$, $md$full-stack-developer$md$, $md$sistem-tasarimi$md$),
  ($md$rest-ile-graphql-arasindaki-farklar-nelerdir$md$, $md$REST ile GraphQL arasındaki farklar nelerdir?$md$, $md$**REST** kaynak başına endpoint kullanır, HTTP cache'ten doğal olarak yararlanır, basittir. Fazla veya eksik veri çekme (over/under-fetching) sorunu olabilir.

**GraphQL** tek endpoint üzerinden istemcinin tam olarak ihtiyaç duyduğu alanları sorgulamasını sağlar. Mobil ve çok çeşitli istemciler için esnektir; ancak cache, yetkilendirme ve sorgu maliyeti kontrolü daha karmaşıktır.$md$, null, $md$medium$md$, $md$full-stack-developer$md$, $md$sistem-tasarimi$md$),
  ($md$bit-ly-benzeri-bir-url-kisaltma-servisi-tasarlayin$md$, $md$Bit.ly benzeri bir URL kısaltma servisi tasarlayın.$md$, $md$- **Gereksinimler**: kısa link oluşturma, yönlendirme; okuma/yazma oranı yaklaşık 100:1.
- **Kısa kod**: artan bir id'yi Base62'ye çevirmek (7 karakter ≈ 3,5 trilyon kombinasyon) veya hash alıp çakışma kontrolü yapmak.
- **Depolama**: `kod → uzun_url` anahtar-değer yapısı; NoSQL veya kod üzerinde index'li SQL.
- **Okuma yolu**: Redis cache + CDN; 301 (kalıcı) veya analitik için 302 yönlendirme.
- **Ölçekleme**: durumsuz API sunucuları, load balancer, id üretimi için dağıtık sayaç (ör. aralık tahsisi).$md$, $md$Doğrudan çözüme atlamayın; önce gereksinimleri ve trafik tahminlerini netleştirin.$md$, $md$hard$md$, $md$full-stack-developer$md$, $md$sistem-tasarimi$md$),
  ($md$git-merge-ile-git-rebase-arasindaki-fark-nedir$md$, $md$git merge ile git rebase arasındaki fark nedir?$md$, $md$**merge** iki dalın geçmişini korur ve bir merge commit'i oluşturur. **rebase** commit'lerinizi hedef dalın ucuna yeniden yazar, doğrusal ve temiz bir geçmiş üretir ama commit hash'leri değişir.

Altın kural: başkalarıyla paylaşılan (push edilmiş) dalları rebase etmeyin.$md$, null, $md$medium$md$, $md$full-stack-developer$md$, $md$git$md$),
  ($md$git-reset-ile-git-revert-arasindaki-fark-nedir$md$, $md$git reset ile git revert arasındaki fark nedir?$md$, $md$**reset** dalın ucunu geriye taşır, geçmişi yeniden yazar; yerel ve paylaşılmamış değişiklikler için uygundur (`--soft`, `--mixed`, `--hard`). **revert** belirtilen commit'in tersini yapan yeni bir commit oluşturur; geçmiş bozulmadığı için paylaşılan dallarda güvenlidir.$md$, null, $md$medium$md$, $md$full-stack-developer$md$, $md$git$md$),
  ($md$bize-kendinizden-bahseder-misiniz$md$, $md$Bize kendinizden bahseder misiniz?$md$, $md$Özgeçmişi baştan okumayın. 1–2 dakikalık bir yapı kurun: **şu an** ne yapıyorsunuz, **geçmişte** sizi buraya getiren önemli bir deneyim, ve bu pozisyonla **gelecekte** neden ilgilendiğiniz.$md$, $md$Sonunu pozisyonla bağlayın: neden bu ekip ve bu ürün?$md$, $md$easy$md$, $md$yazilim-muhendisi$md$, $md$davranissal$md$),
  ($md$cozdugunuz-en-zor-teknik-problemi-anlatin$md$, $md$Çözdüğünüz en zor teknik problemi anlatın.$md$, $md$**STAR** yöntemini kullanın: **S**ituation (durum), **T**ask (sizin göreviniz), **A**ction (somut olarak ne yaptınız), **R**esult (ölçülebilir sonuç). "Biz" yerine kendi katkınızı anlatın ve sonuçta ne öğrendiğinizi ekleyin.$md$, $md$Ölçülebilir bir sonuç verin: "sayfa yüklenme süresi 4 saniyeden 1,2 saniyeye indi" gibi.$md$, $md$medium$md$, $md$yazilim-muhendisi$md$, $md$davranissal$md$),
  ($md$bir-ekip-arkadasinizla-teknik-bir-konuda-anlasamadiginizda-ne-yaptiniz$md$, $md$Bir ekip arkadaşınızla teknik bir konuda anlaşamadığınızda ne yaptınız?$md$, $md$Mülakatçı çatışma yönetimini ve iş birliğini ölçer. Karşı tarafın gerekçesini nasıl dinlediğinizi, kararı veri veya küçük bir deneyle nasıl netleştirdiğinizi ve sonuç sizin fikriniz olmasa bile nasıl destek verdiğinizi anlatın.$md$, null, $md$medium$md$, $md$yazilim-muhendisi$md$, $md$davranissal$md$),
  ($md$http-401-ile-403-durum-kodlari-arasindaki-fark-nedir$md$, $md$HTTP 401 ile 403 durum kodları arasındaki fark nedir?$md$, $md$**401 Unauthorized**, isteği yapanın kimliğinin doğrulanmadığını söyler: token yok, süresi dolmuş veya geçersiz. İstemci giriş yapıp tekrar denemelidir.

**403 Forbidden**, kimlik doğrulanmış ama bu kaynağa erişim yetkisi olmadığını söyler. Tekrar giriş yapmak sonucu değiştirmez.

- 400: istek hatalı (validasyon)
- 404: kaynak yok
- 409: çakışma (ör. aynı e-posta ile ikinci kayıt)
- 422: istek anlaşıldı ama içerik işlenemiyor
- 429: çok fazla istek (rate limit)$md$, $md$Bazı API'ler yetkisiz kaynağın varlığını gizlemek için 403 yerine bilinçli olarak 404 döndürür; bunu bildiğinizi göstermek artı puandır.$md$, $md$easy$md$, $md$backend-developer$md$, $md$api-tasarimi$md$),
  ($md$jwt-nedir-session-tabanli-kimlik-dogrulamadan-farki-nedir$md$, $md$JWT nedir? Session tabanlı kimlik doğrulamadan farkı nedir?$md$, $md$JWT (JSON Web Token), `header.payload.signature` biçiminde, imzalı ve kendi içinde bilgi taşıyan bir token'dır. Sunucu imzayı doğrulayarak token'a güvenir; veritabanına bakması gerekmez.

**Session** yaklaşımında sunucu oturum bilgisini (bellekte, Redis'te) tutar, istemciye yalnızca bir session id çerezi verir.

- JWT: durumsuz (stateless), yatay ölçeklemesi kolay, ama süresi dolmadan iptal etmek zordur.
- Session: anında iptal edilebilir, ama paylaşılan bir oturum deposu gerekir.

Yaygın çözüm kısa ömürlü access token + uzun ömürlü, iptal edilebilir refresh token kullanmaktır.$md$, $md$Payload şifreli değil, sadece base64 ile kodlanmıştır; içine hassas veri koymayın.$md$, $md$medium$md$, $md$backend-developer$md$, $md$api-tasarimi$md$),
  ($md$idempotency-nedir-hangi-http-metotlari-idempotent-tir$md$, $md$Idempotency nedir? Hangi HTTP metotları idempotent'tir?$md$, $md$Bir işlem aynı istekle bir veya birden çok kez çalıştırıldığında sistemin son durumu aynı kalıyorsa o işlem idempotent'tir.

- **GET, HEAD, PUT, DELETE**: idempotent
- **POST**: idempotent değil (her çağrı yeni kayıt oluşturabilir)
- **PATCH**: tasarıma bağlı

Ödeme gibi kritik POST işlemlerinde istemci bir `Idempotency-Key` başlığı gönderir; sunucu aynı anahtarla gelen tekrar isteklerinde ilk sonucu döndürür. Böylece ağ hatası sonrası yapılan yeniden denemeler çift ödeme oluşturmaz.$md$, null, $md$medium$md$, $md$backend-developer$md$, $md$api-tasarimi$md$),
  ($md$n-1-sorgu-problemi-nedir-ve-nasil-cozulur$md$, $md$N+1 sorgu problemi nedir ve nasıl çözülür?$md$, $md$Bir liste için 1 sorgu atıp, ardından listedeki her eleman için ayrı bir sorgu daha atmaktır. 100 yazar için 101 sorgu oluşur.

```js
// N+1
const yazarlar = await db.query("SELECT * FROM yazarlar");
for (const y of yazarlar) {
  y.kitaplar = await db.query("SELECT * FROM kitaplar WHERE yazar_id = $1", [y.id]);
}
```

Çözümler:

- JOIN ile tek sorguda çekmek
- `WHERE yazar_id IN (...)` ile toplu çekip uygulamada eşleştirmek
- ORM'lerde eager loading (`include`, `select_related`, `with`)
- GraphQL'de DataLoader ile istekleri birleştirmek$md$, $md$Sorgu loglarını açıp sayfa başına kaç sorgu atıldığını ölçtüğünüzü söylemek pratik deneyim gösterir.$md$, $md$medium$md$, $md$backend-developer$md$, $md$veritabani-sql$md$),
  ($md$mesaj-kuyrugu-rabbitmq-kafka-ne-zaman-kullanilir$md$, $md$Mesaj kuyruğu (RabbitMQ, Kafka) ne zaman kullanılır?$md$, $md$Mesaj kuyruğu, servisleri birbirinden ayırır ve işleri asenkron hale getirir.

- **Yavaş işleri arka plana almak**: e-posta gönderimi, görsel işleme, rapor üretimi
- **Ani yükleri sönümlemek**: üretici hızlı, tüketici kendi hızında çalışır
- **Servisleri gevşek bağlamak**: sipariş servisi, faturalama ve stok servislerini doğrudan çağırmaz, olay yayınlar

**RabbitMQ** klasik bir mesaj aracısıdır; yönlendirme kuralları güçlüdür, tüketilen mesaj kuyruktan silinir. **Kafka** dağıtık bir log'dur; mesajlar saklanır, birden çok tüketici grubu aynı akışı farklı hızlarda okuyabilir ve geçmişe dönük yeniden işleyebilir.

Dikkat edilmesi gerekenler: en az bir kez teslim (at-least-once) nedeniyle tüketiciler idempotent olmalı, işlenemeyen mesajlar için dead-letter kuyruğu kurulmalı.$md$, null, $md$hard$md$, $md$backend-developer$md$, $md$sistem-tasarimi$md$),
  ($md$cors-nedir-neden-cors-hatasi-aliriz$md$, $md$CORS nedir? Neden CORS hatası alırız?$md$, $md$Tarayıcılar güvenlik için **same-origin policy** uygular: bir sayfa, farklı bir origin'e (protokol + alan adı + port) yapılan isteklerin cevabını okuyamaz.

CORS (Cross-Origin Resource Sharing), sunucunun hangi origin'lere izin verdiğini başlıklarla bildirmesidir:

```http
Access-Control-Allow-Origin: https://app.ornek.com
Access-Control-Allow-Methods: GET, POST
Access-Control-Allow-Headers: Content-Type, Authorization
```

`Content-Type: application/json` veya özel başlık içeren isteklerden önce tarayıcı bir **preflight** (`OPTIONS`) isteği gönderir. Hata tarayıcıda görülür ama çözüm **sunucu tarafındadır**.$md$, $md$CORS'un sunucuyu korumadığını, kullanıcının tarayıcısını koruduğunu söyleyin; curl ile istek atınca CORS yoktur.$md$, $md$medium$md$, $md$full-stack-developer$md$, $md$web-guvenligi$md$),
  ($md$xss-ve-csrf-saldirilari-nedir-nasil-korunulur$md$, $md$XSS ve CSRF saldırıları nedir, nasıl korunulur?$md$, $md$**XSS (Cross-Site Scripting)**: saldırganın kodu, kurbanın tarayıcısında sitenin kendi kodu gibi çalışır. Örneğin yorum alanına yazılan `<script>` etiketi.

- Çıktıyı her zaman bağlama göre kaçışlayın (React bunu varsayılan olarak yapar)
- `innerHTML` / `dangerouslySetInnerHTML` kullanımından kaçının, zorunluysa sanitize edin
- Content-Security-Policy başlığı kullanın, oturum çerezlerini `HttpOnly` yapın

**CSRF (Cross-Site Request Forgery)**: kurban giriş yapmışken başka bir site, tarayıcının çerezleri otomatik göndermesini kullanarak kurban adına istek yaptırır.

- Çerezlerde `SameSite=Lax` veya `Strict`
- Durum değiştiren isteklerde CSRF token
- GET isteklerinin hiçbir zaman veri değiştirmemesi$md$, null, $md$hard$md$, $md$full-stack-developer$md$, $md$web-guvenligi$md$),
  ($md$ssr-ssg-ve-csr-arasindaki-farklar-nelerdir$md$, $md$SSR, SSG ve CSR arasındaki farklar nelerdir?$md$, $md$- **CSR (Client-Side Rendering)**: sunucu boş bir HTML ve JavaScript gönderir, sayfa tarayıcıda oluşturulur. Etkileşimli uygulamalar için uygundur; ilk yükleme ve SEO zayıftır.
- **SSR (Server-Side Rendering)**: her istekte HTML sunucuda üretilir. İçerik güncel ve SEO dostudur; sunucu maliyeti ve yanıt süresi artar.
- **SSG (Static Site Generation)**: HTML derleme zamanında bir kez üretilir ve CDN'den sunulur. En hızlısıdır; içerik değişince yeniden derleme gerekir.

**ISR (Incremental Static Regeneration)** ikisini birleştirir: sayfa statik sunulur, belirli aralıklarla veya istek üzerine arka planda yenilenir.$md$, $md$Hangi sayfanın hangi yöntemle sunulacağını içeriğin ne sıklıkla değiştiğine ve kişiye özel olup olmadığına göre seçtiğinizi anlatın.$md$, $md$medium$md$, $md$full-stack-developer$md$, $md$web-mimarisi$md$),
  ($md$oyun-dongusu-game-loop-nedir-sabit-ve-degisken-zaman-adimi-arasindaki-fark-nedir$md$, $md$Oyun döngüsü (game loop) nedir? Sabit ve değişken zaman adımı arasındaki fark nedir?$md$, $md$Oyun döngüsü, oyun çalıştığı sürece tekrar eden ana döngüdür: **girdileri oku → oyun durumunu güncelle → ekrana çiz**.

- **Değişken zaman adımı**: her karede geçen süre (delta time) kadar güncelleme yapılır. Basittir ama fizik, kare hızına göre farklı sonuç verebilir.
- **Sabit zaman adımı**: simülasyon her zaman aynı aralıkla (ör. 1/60 sn) ilerler; biriken süre bir akümülatörde tutulur. Fizik deterministik ve kararlı olur.

```cpp
double birikmis = 0.0;
const double ADIM = 1.0 / 60.0;
while (calisiyor) {
  birikmis += gecenSure();
  girdileriIsle();
  while (birikmis >= ADIM) {
    guncelle(ADIM);
    birikmis -= ADIM;
  }
  ciz(birikmis / ADIM); // iki durum arasında interpolasyon
}
```$md$, null, $md$medium$md$, $md$game-developer$md$, $md$oyun-programlama$md$),
  ($md$unity-de-update-fixedupdate-ve-lateupdate-arasindaki-fark-nedir$md$, $md$Unity'de Update, FixedUpdate ve LateUpdate arasındaki fark nedir?$md$, $md$- **Update**: her karede bir kez çağrılır. Girdi okuma ve fizik dışı oyun mantığı için kullanılır.
- **FixedUpdate**: sabit aralıklarla (varsayılan 0,02 sn) çağrılır, kare hızından bağımsızdır. Rigidbody'ye kuvvet uygulamak gibi fizik işleri burada yapılır.
- **LateUpdate**: tüm Update'ler bittikten sonra çağrılır. Oyuncuyu takip eden kamera gibi, diğer nesnelerin hareketinden sonra çalışması gereken kodlar için idealdir.$md$, $md$Girdiyi Update'te okuyup sonucu FixedUpdate'te uygulamanın, tuş basışlarının kaçırılmasını önlediğini belirtin.$md$, $md$easy$md$, $md$game-developer$md$, $md$unity-csharp$md$),
  ($md$delta-time-nedir-neden-kullanilir$md$, $md$Delta time nedir, neden kullanılır?$md$, $md$Delta time, bir önceki kareden bu yana geçen süredir. Hareket ve animasyonlar bu süreyle çarpılarak kare hızından bağımsız hale getirilir.

```csharp
// Kare hızına bağlı: 30 FPS'te yavaş, 144 FPS'te hızlı
transform.position += Vector3.forward * 0.1f;

// Saniyede 5 birim, her cihazda aynı hız
transform.position += Vector3.forward * 5f * Time.deltaTime;
```$md$, null, $md$easy$md$, $md$game-developer$md$, $md$oyun-programlama$md$),
  ($md$object-pooling-nedir-neden-kullanilir$md$, $md$Object pooling nedir, neden kullanılır?$md$, $md$Sık oluşturulup yok edilen nesneleri (mermi, parçacık, düşman) her seferinde yeniden oluşturmak yerine önceden oluşturup bir havuzda tutmak ve tekrar kullanmaktır.

- `Instantiate` / `Destroy` maliyetinden ve bellek ayırmadan kaçınılır
- Çöp toplayıcının (GC) oyunun ortasında takılmalara yol açması önlenir
- Bellek kullanımı öngörülebilir olur

Nesne "yok edilmek" yerine devre dışı bırakılıp havuza döner; tekrar gerektiğinde durumu sıfırlanıp etkinleştirilir. Unity'de `UnityEngine.Pool.ObjectPool<T>` hazır olarak gelir.$md$, null, $md$medium$md$, $md$game-developer$md$, $md$oyun-programlama$md$),
  ($md$entity-component-system-ecs-nedir-klasik-nesne-yonelimli-yapidan-farki-nedir$md$, $md$Entity Component System (ECS) nedir? Klasik nesne yönelimli yapıdan farkı nedir?$md$, $md$ECS, oyun nesnelerini üç parçaya ayıran bir mimaridir:

- **Entity**: yalnızca bir kimlik (id)
- **Component**: davranışı olmayan saf veri (Pozisyon, Hız, Can)
- **System**: belirli bileşenlere sahip tüm entity'ler üzerinde çalışan mantık (HareketSistemi, Pozisyon + Hız olanları günceller)

Klasik kalıtım hiyerarşisinde (`Dusman : Karakter : OyunNesnesi`) davranış ve veri iç içedir; derin hiyerarşiler esnekliği azaltır. ECS'te ise yeni bir davranış için bileşen eklemek yeterlidir (composition over inheritance).

Performans avantajı: aynı türdeki bileşenler bellekte ardışık dizilerde tutulur, bu da CPU önbelleğini verimli kullanır ve binlerce nesneyi hızla işlemeyi sağlar.$md$, null, $md$hard$md$, $md$game-developer$md$, $md$oyun-programlama$md$),
  ($md$carpisma-tespitinde-broad-phase-ve-narrow-phase-nedir$md$, $md$Çarpışma tespitinde broad phase ve narrow phase nedir?$md$, $md$Her nesneyi her nesneyle karşılaştırmak O(n²) olduğu için çarpışma tespiti iki aşamada yapılır.

- **Broad phase**: ucuz yöntemlerle çarpışması *mümkün* olan çiftleri bulur. Sınırlayıcı kutular (AABB) ve uzamsal bölümleme yapıları kullanılır: uniform grid, quadtree/octree, BVH, sweep and prune.
- **Narrow phase**: yalnızca aday çiftler için kesin geometri testi yapar (SAT, GJK) ve temas noktası, normal, iç içe geçme derinliği gibi bilgileri hesaplar.

Hızlı nesnelerin ince duvarlardan geçmesini (tunneling) önlemek için sürekli çarpışma tespiti (CCD) kullanılabilir.$md$, null, $md$hard$md$, $md$game-developer$md$, $md$oyun-programlama$md$),
  ($md$vektorlerde-dot-product-ve-cross-product-oyunlarda-ne-icin-kullanilir$md$, $md$Vektörlerde dot product ve cross product oyunlarda ne için kullanılır?$md$, $md$**Dot product** (skaler çarpım) iki vektör arasındaki açıyla ilgilidir: `a · b = |a||b| cos θ`.

- Düşman oyuncunun önünde mi arkasında mı? (sonuç > 0 ise önünde)
- Görüş açısı (field of view) kontrolü
- Işıklandırmada yüzey normali ile ışık yönü arasındaki açı

**Cross product** (vektörel çarpım) iki vektöre dik yeni bir vektör üretir.

- Bir yüzeyin normalini hesaplamak
- Hedef solda mı sağda mı? (2D'de sonucun işareti)
- Dönüş ekseni bulmak$md$, null, $md$medium$md$, $md$game-developer$md$, $md$oyun-matematigi$md$),
  ($md$osi-modelinin-katmanlari-nelerdir$md$, $md$OSI modelinin katmanları nelerdir?$md$, $md$Alttan üste yedi katman:

- **1. Fiziksel**: bitlerin iletimi (kablo, fiber, radyo)
- **2. Veri bağı**: MAC adresleri, çerçeveler, switch (Ethernet)
- **3. Ağ**: IP adresleme ve yönlendirme, router
- **4. Taşıma**: uçtan uca iletim, portlar (TCP, UDP)
- **5. Oturum**: oturumların kurulması ve yönetimi
- **6. Sunum**: veri biçimi, şifreleme, sıkıştırma (TLS)
- **7. Uygulama**: kullanıcıya yakın protokoller (HTTP, DNS, SMTP)

Pratikte daha çok 4 katmanlı TCP/IP modeli kullanılır: Ağ Erişimi, İnternet, Taşıma, Uygulama.$md$, $md$Bir sorunu giderirken katman katman ilerlediğinizi (önce fiziksel bağlantı, sonra IP, sonra port) anlatmak iyi bir izlenim bırakır.$md$, $md$easy$md$, $md$network-engineer$md$, $md$ag-temelleri$md$),
  ($md$tcp-ile-udp-arasindaki-fark-nedir$md$, $md$TCP ile UDP arasındaki fark nedir?$md$, $md$- **TCP** bağlantı yönelimlidir: el sıkışma ile bağlantı kurar, paketlerin sırayla ve eksiksiz ulaşmasını garanti eder, kayıp paketleri yeniden gönderir, akış ve tıkanıklık kontrolü yapar. Web, e-posta, dosya transferi için kullanılır.
- **UDP** bağlantısızdır: teslim ve sıra garantisi yoktur, başlığı küçüktür, gecikmesi düşüktür. DNS sorguları, canlı yayın, VoIP ve online oyunlar için tercih edilir.

HTTP/3, UDP üzerinde çalışan QUIC protokolünü kullanır; güvenilirliği uygulama katmanında sağlar.$md$, null, $md$easy$md$, $md$network-engineer$md$, $md$ag-temelleri$md$),
  ($md$tcp-uclu-el-sikisma-three-way-handshake-nasil-calisir$md$, $md$TCP üçlü el sıkışma (three-way handshake) nasıl çalışır?$md$, $md$1. İstemci, rastgele bir başlangıç sıra numarasıyla (x) **SYN** gönderir.
2. Sunucu **SYN-ACK** ile cevap verir: kendi sıra numarası (y) ve onay numarası x+1.
3. İstemci **ACK** gönderir (onay numarası y+1). Bağlantı kurulur.

Bağlantı kapatılırken genelde dört adımlı FIN / ACK değişimi yapılır.$md$, $md$SYN flood saldırısını ve buna karşı SYN cookie kullanımını bilmek artı puan getirir.$md$, $md$easy$md$, $md$network-engineer$md$, $md$ag-temelleri$md$),
  ($md$192-168-10-0-26-aginda-alt-ag-maskesi-nedir-ve-kac-kullanilabilir-host-vardir$md$, $md$192.168.10.0/26 ağında alt ağ maskesi nedir ve kaç kullanılabilir host vardır?$md$, $md$/26, ilk 26 bitin ağ kısmı olduğunu gösterir.

- Alt ağ maskesi: **255.255.255.192**
- Host biti: 32 − 26 = 6, toplam adres: 2⁶ = 64
- Kullanılabilir host: 64 − 2 = **62** (ağ adresi ve broadcast çıkarılır)

/24'lük blok dört alt ağa bölünür:

- 192.168.10.0 – .63
- 192.168.10.64 – .127
- 192.168.10.128 – .191
- 192.168.10.192 – .255

Örneğin ilk alt ağda ağ adresi .0, kullanılabilir aralık .1 – .62, broadcast .63'tür.$md$, null, $md$medium$md$, $md$network-engineer$md$, $md$ag-temelleri$md$),
  ($md$tarayiciya-bir-adres-yazdiginizda-dns-cozumlemesi-nasil-gerceklesir$md$, $md$Tarayıcıya bir adres yazdığınızda DNS çözümlemesi nasıl gerçekleşir?$md$, $md$1. Tarayıcı ve işletim sistemi önbelleği kontrol edilir (hosts dosyası dahil).
2. Bulunamazsa istek, yapılandırılmış **özyinelemeli çözümleyiciye** (ISS veya 1.1.1.1 gibi) gider.
3. Çözümleyici önbelleğinde yoksa **kök sunuculara** sorar, kök sunucu `.com` TLD sunucularını gösterir.
4. TLD sunucusu, alan adının **yetkili (authoritative) ad sunucusunu** gösterir.
5. Yetkili sunucu A/AAAA kaydını (IP adresi) döndürür.
6. Sonuç, kaydın TTL süresi boyunca her katmanda önbelleğe alınır.

Sonrasında tarayıcı bu IP'ye TCP (veya QUIC) bağlantısı ve TLS el sıkışması yapar, ardından HTTP isteği gönderir.$md$, null, $md$medium$md$, $md$network-engineer$md$, $md$ag-temelleri$md$),
  ($md$switch-ile-router-arasindaki-fark-nedir$md$, $md$Switch ile router arasındaki fark nedir?$md$, $md$- **Switch** 2. katmanda çalışır. Aynı yerel ağdaki cihazları birbirine bağlar ve çerçeveleri MAC adres tablosuna göre ilgili porta iletir.
- **Router** 3. katmanda çalışır. Farklı ağları birbirine bağlar ve paketleri IP adresine ve yönlendirme tablosuna göre iletir; yerel ağın internete çıkışını sağlar.

Layer 3 switch'ler, VLAN'lar arası yönlendirmeyi donanımsal olarak yaparak iki rolü birleştirir.$md$, null, $md$easy$md$, $md$network-engineer$md$, $md$yonlendirme-anahtarlama$md$),
  ($md$vlan-nedir-neden-kullanilir-trunk-port-nedir$md$, $md$VLAN nedir, neden kullanılır? Trunk port nedir?$md$, $md$VLAN, tek bir fiziksel switch altyapısını mantıksal olarak ayrı yayın (broadcast) alanlarına bölmektir.

- Güvenlik: muhasebe ve misafir ağı birbirini göremez
- Performans: broadcast trafiği küçük alanlarla sınırlı kalır
- Esneklik: cihazlar fiziksel konumdan bağımsız gruplanır

**Access port** tek bir VLAN'a aittir ve son kullanıcı cihazına bağlanır. **Trunk port** birden çok VLAN'ın trafiğini taşır; çerçevelere 802.1Q etiketi (VLAN ID) eklenir. Switch'ler arası ve switch–router arası bağlantılarda kullanılır.

VLAN'lar arası iletişim için router veya Layer 3 switch gerekir (inter-VLAN routing).$md$, null, $md$medium$md$, $md$network-engineer$md$, $md$yonlendirme-anahtarlama$md$),
  ($md$ospf-ile-bgp-arasindaki-fark-nedir$md$, $md$OSPF ile BGP arasındaki fark nedir?$md$, $md$- **OSPF** bir iç yönlendirme protokolüdür (IGP). Tek bir kurum ağı (otonom sistem) içinde çalışır. Link-state algoritması kullanır: her router ağ topolojisinin tamamını bilir ve Dijkstra ile en kısa yolu hesaplar. Yakınsama hızlıdır, metrik bağlantı maliyetidir (cost). Büyük ağlar alanlara (area) bölünür.
- **BGP** bir dış yönlendirme protokolüdür (EGP). Otonom sistemler arasında, yani internetin omurgasında çalışır. Path-vector protokolüdür ve yol seçimini AS-PATH, LOCAL_PREF, MED gibi **politika** özelliklerine göre yapar. TCP 179 üzerinden çalışır, yüz binlerce rotayı taşıyabilir.

Kısaca OSPF "en hızlı yol", BGP ise "iş kurallarına göre tercih edilen yol" sorusunu cevaplar.$md$, null, $md$hard$md$, $md$network-engineer$md$, $md$yonlendirme-anahtarlama$md$),
  ($md$c-dilinde-volatile-anahtar-kelimesi-ne-ise-yarar$md$, $md$C dilinde volatile anahtar kelimesi ne işe yarar?$md$, $md$`volatile`, derleyiciye bu değişkenin program akışı dışında değişebileceğini söyler. Derleyici değeri bir yazmaçta önbelleğe almaz, her erişimde bellekten yeniden okur.

Kullanım alanları:

- Donanım yazmaçları (memory-mapped I/O)
- Kesme servis rutininde (ISR) değiştirilen global değişkenler
- Çok iş parçacıklı ortamda başka bir görevin değiştirdiği bayraklar

```c
volatile uint8_t veri_hazir = 0;

void UART_IRQHandler(void) {
  veri_hazir = 1;
}

int main(void) {
  while (!veri_hazir) { }  // volatile olmasaydı sonsuz döngüye optimize edilebilirdi
}
```$md$, $md$volatile'ın atomiklik veya senkronizasyon sağlamadığını mutlaka belirtin.$md$, $md$medium$md$, $md$embedded-engineer$md$, $md$c-programlama$md$),
  ($md$bir-yazmactaki-belirli-bir-biti-set-clear-ve-toggle-eden-c-kodunu-yazin$md$, $md$Bir yazmaçtaki belirli bir biti set, clear ve toggle eden C kodunu yazın.$md$, $md$Bit işlemleri için maske kullanılır: `(1U << n)` yalnızca n'inci biti 1 olan bir sayı üretir.

```c
#define BIT_SET(reg, n)    ((reg) |=  (1U << (n)))
#define BIT_CLEAR(reg, n)  ((reg) &= ~(1U << (n)))
#define BIT_TOGGLE(reg, n) ((reg) ^=  (1U << (n)))
#define BIT_READ(reg, n)   (((reg) >> (n)) & 1U)

BIT_SET(GPIOA->ODR, 5);    // PA5 = 1 (LED yak)
BIT_TOGGLE(GPIOA->ODR, 5); // LED durumunu değiştir
```

- OR (`|`) ile set
- AND ve NOT (`& ~`) ile clear
- XOR (`^`) ile toggle$md$, $md$Kesmelerle paylaşılan yazmaçlarda read-modify-write işleminin atomik olmadığını; mümkünse BSRR gibi set/reset yazmaçlarının kullanıldığını söyleyin.$md$, $md$easy$md$, $md$embedded-engineer$md$, $md$c-programlama$md$),
  ($md$kesme-interrupt-nedir-isr-yazarken-nelere-dikkat-edilir$md$, $md$Kesme (interrupt) nedir? ISR yazarken nelere dikkat edilir?$md$, $md$Kesme, bir donanım veya yazılım olayının işlemcinin normal akışını durdurup ilgili **kesme servis rutinini (ISR)** çalıştırmasıdır. Sürekli sorgulama (polling) yerine olay olduğunda tepki vermeyi sağlar.

ISR yazarken:

- Mümkün olduğunca **kısa** tutun; ağır işi bir bayrak veya kuyrukla ana döngüye bırakın
- `printf`, `malloc` ve bloklayan çağrılardan kaçının
- Paylaşılan değişkenleri `volatile` yapın, çok baytlı verilerde kritik bölge kullanın
- Kesme bayrağını temizlemeyi unutmayın, yoksa ISR sürekli tekrar çalışır
- Kesme önceliklerini ve iç içe kesmeleri (nesting) planlayın$md$, null, $md$medium$md$, $md$embedded-engineer$md$, $md$mikrodenetleyiciler$md$),
  ($md$uart-spi-ve-i2c-arasindaki-farklar-nelerdir$md$, $md$UART, SPI ve I2C arasındaki farklar nelerdir?$md$, $md$- **UART**: asenkron, saat hattı yoktur; iki taraf aynı baud hızında anlaşır. TX ve RX olmak üzere 2 hat, noktadan noktaya iletişim. Hata ayıklama konsolu, GPS, Bluetooth modülleri.
- **SPI**: senkron, master saat üretir. 4 hat (SCLK, MOSI, MISO, CS), tam çift yönlü (full-duplex), onlarca MHz hıza çıkabilir. Her slave için ayrı CS hattı gerekir. Ekranlar, SD kart, flash bellek.
- **I2C**: senkron, yalnızca 2 hat (SDA, SCL), açık-drain ve pull-up dirençleri gerekir. Adresleme ile aynı hatta çok sayıda cihaz bağlanır, yarı çift yönlüdür (half-duplex), tipik olarak 100 kHz / 400 kHz. Sensörler, EEPROM.$md$, $md$Hız, pin sayısı ve cihaz sayısı arasında bir tercih yapıldığını; seçimin bu ihtiyaçlara göre yapıldığını vurgulayın.$md$, $md$medium$md$, $md$embedded-engineer$md$, $md$haberlesme-protokolleri$md$),
  ($md$watchdog-timer-nedir-ne-ise-yarar$md$, $md$Watchdog timer nedir, ne işe yarar?$md$, $md$Watchdog, yazılımın kilitlenmesine karşı kullanılan bağımsız bir donanım sayacıdır. Yazılım düzenli aralıklarla sayacı sıfırlamalıdır ("köpeği beslemek"). Program bir döngüde takılır veya çökerse sayaç sıfırlanmaz, süre dolar ve mikrodenetleyici otomatik olarak **resetlenir**.

İyi uygulama: watchdog'u rastgele bir yerde değil, tüm kritik görevlerin sağlıklı çalıştığı doğrulandıktan sonra beslemek.$md$, null, $md$easy$md$, $md$embedded-engineer$md$, $md$mikrodenetleyiciler$md$),
  ($md$rtos-nedir-bare-metal-programlamadan-farki-nedir$md$, $md$RTOS nedir? Bare-metal programlamadan farkı nedir?$md$, $md$**Bare-metal** yaklaşımında tek bir ana döngü ve kesmeler vardır; zamanlama ve önceliklendirme tamamen geliştiricinin elindedir. Basit sistemler için yeterli ve hafiftir.

**RTOS (Real-Time Operating System)**, işi bağımsız **görevlere (task)** böler ve öncelik tabanlı, kesintili (preemptive) bir zamanlayıcı ile çalıştırır. Gerçek zamanlı olması hızlı olması değil, **zamanında ve öngörülebilir** (deterministik) tepki vermesi demektir.

RTOS ile gelenler:

- Görev öncelikleri ve zamanlayıcı
- Senkronizasyon: semafor, mutex, kuyruk, olay bayrakları
- Zamanlayıcılar ve gecikmeler

Dikkat edilmesi gereken sorunlar: **öncelik tersinmesi** (priority inversion, çözüm: priority inheritance), deadlock, her görev için yığın (stack) boyutunun doğru belirlenmesi. Örnekler: FreeRTOS, Zephyr, ThreadX.$md$, null, $md$hard$md$, $md$embedded-engineer$md$, $md$rtos$md$),
  ($md$stack-ile-heap-arasindaki-fark-nedir-gomulu-sistemlerde-dinamik-bellek-kullanimi$md$, $md$Stack ile heap arasındaki fark nedir? Gömülü sistemlerde dinamik bellek kullanımından neden kaçınılır?$md$, $md$- **Stack**: yerel değişkenler ve fonksiyon çağrı bilgileri için kullanılır. Otomatik yönetilir, çok hızlıdır, boyutu sınırlıdır.
- **Heap**: `malloc`/`free` ile çalışma zamanında ayrılan bellektir. Esnektir ama yönetimi geliştiricidedir.

Gömülü sistemlerde `malloc`'tan kaçınılmasının nedenleri:

- **Parçalanma (fragmentation)**: uzun süre çalışan cihazda toplam bellek yeterli olsa bile büyük blok ayrılamayabilir
- **Deterministik olmama**: ayırma süresi öngörülemez, gerçek zamanlı gereksinimlerle çelişir
- **Sızıntılar** aylarca çalışan bir cihazı sonunda çökertir

Bunun yerine statik ayırma veya sabit boyutlu bellek havuzları kullanılır. MISRA C gibi standartlar dinamik belleği kısıtlar.$md$, null, $md$medium$md$, $md$embedded-engineer$md$, $md$c-programlama$md$),
  ($md$endianness-nedir-little-endian-ile-big-endian-farki-nedir$md$, $md$Endianness nedir? Little-endian ile big-endian farkı nedir?$md$, $md$Çok baytlı bir verinin bellekte hangi bayt sırasıyla saklandığıdır. `0x12345678` değeri için:

- **Little-endian**: en düşük anlamlı bayt en düşük adreste → `78 56 34 12` (x86, ARM Cortex-M çoğunlukla)
- **Big-endian**: en yüksek anlamlı bayt en düşük adreste → `12 34 56 78` (ağ bayt sırası)

Farklı sistemler arasında veri gönderirken (ağ protokolleri, dosya formatları) dönüşüm gerekir: `htonl`, `ntohl` gibi fonksiyonlar bu işi yapar.

```c
uint32_t x = 1;
int little = *(uint8_t *)&x == 1;  // 1 ise little-endian
```$md$, null, $md$easy$md$, $md$embedded-engineer$md$, $md$c-programlama$md$),
  ($md$ohm-ve-kirchhoff-kanunlarini-aciklayin$md$, $md$Ohm ve Kirchhoff kanunlarını açıklayın.$md$, $md$**Ohm Kanunu**: bir dirençten geçen akım, uçlarındaki gerilimle doğru, dirençle ters orantılıdır: `V = I × R`. Güç ise `P = V × I = I²R = V²/R` ile bulunur.

**Kirchhoff Akım Kanunu (KAK)**: bir düğüme giren akımların toplamı çıkan akımların toplamına eşittir. Yük korunumundan gelir.

**Kirchhoff Gerilim Kanunu (KGK)**: kapalı bir çevre boyunca gerilimlerin cebirsel toplamı sıfırdır. Enerji korunumundan gelir.

Bu kanunlar düğüm gerilimleri ve çevre akımları yöntemlerinin temelidir.$md$, null, $md$easy$md$, $md$elektrik-elektronik-muhendisi$md$, $md$devre-analizi$md$),
  ($md$thevenin-ve-norton-esdeger-devreleri-nedir$md$, $md$Thevenin ve Norton eşdeğer devreleri nedir?$md$, $md$Doğrusal bir devre, iki ucundan bakıldığında daha basit bir eşdeğerle temsil edilebilir.

- **Thevenin**: bir gerilim kaynağı (V_th) ve ona seri bir direnç (R_th)
- **Norton**: bir akım kaynağı (I_N) ve ona paralel bir direnç (R_N)

Bulma adımları:

- **V_th**: yük çıkarılmışken uçlar arasındaki açık devre gerilimi
- **I_N**: uçlar kısa devre edildiğinde akan akım
- **R_th = R_N**: bağımsız kaynaklar sıfırlanarak (gerilim kaynağı kısa, akım kaynağı açık devre) uçlardan görülen direnç; ya da `R_th = V_th / I_N`

İki eşdeğer birbirine dönüştürülebilir: `V_th = I_N × R_th`. Maksimum güç aktarımı, yük direnci R_th'ye eşit olduğunda gerçekleşir.$md$, null, $md$medium$md$, $md$elektrik-elektronik-muhendisi$md$, $md$devre-analizi$md$),
  ($md$ideal-op-amp-in-ozellikleri-nelerdir-eviren-yukseltecte-kazanc-nasil-bulunur$md$, $md$İdeal op-amp'ın özellikleri nelerdir? Eviren yükselteçte kazanç nasıl bulunur?$md$, $md$İdeal op-amp kabulleri:

- Sonsuz açık çevrim kazancı
- Sonsuz giriş empedansı (girişlerden akım akmaz)
- Sıfır çıkış empedansı
- Sonsuz bant genişliği

Negatif geri beslemeli devrelerde iki pratik kural kullanılır: girişlerden akım akmaz ve iki giriş arasındaki gerilim sıfırdır (sanal kısa devre).

**Eviren yükselteç** için kazanç:

```text
Av = Vout / Vin = −Rf / Rin
```

Örneğin Rf = 10 kΩ ve Rin = 1 kΩ ise kazanç −10'dur. Eviren olmayan yükselteçte ise kazanç `1 + Rf / Rg`'dir.$md$, null, $md$medium$md$, $md$elektrik-elektronik-muhendisi$md$, $md$elektronik$md$),
  ($md$bjt-ile-mosfet-arasindaki-farklar-nelerdir$md$, $md$BJT ile MOSFET arasındaki farklar nelerdir?$md$, $md$- **BJT** akım kontrollü bir elemandır: kollektör akımı baz akımıyla kontrol edilir (`Ic ≈ β × Ib`). Sürmek için sürekli baz akımı gerekir.
- **MOSFET** gerilim kontrollüdür: kapı (gate) yalıtılmıştır, kalıcı durumda neredeyse akım çekmez. Kanal, gate–source gerilimiyle açılıp kapanır.

Pratik farklar:

- Anahtarlama ve güç uygulamalarında MOSFET öne çıkar: düşük iletim direnci (R_DS(on)), yüksek anahtarlama hızı, kolay paralel bağlanma
- BJT, analog yükselteçlerde doğrusallığı ve düşük gürültüsüyle hâlâ kullanılır
- MOSFET'in gate kapasitansı yüksek frekansta sürücü devresi gerektirir
- Yüksek gerilim ve akımda ikisini birleştiren IGBT tercih edilir$md$, null, $md$medium$md$, $md$elektrik-elektronik-muhendisi$md$, $md$elektronik$md$),
  ($md$rc-alcak-geciren-filtrenin-kesim-frekansi-nasil-hesaplanir$md$, $md$RC alçak geçiren filtrenin kesim frekansı nasıl hesaplanır?$md$, $md$Seri direnç ve kondansatör uçlarından alınan çıkıştan oluşan birinci derece alçak geçiren filtrenin kesim frekansı:

```text
fc = 1 / (2π × R × C)
```

Örnek: R = 1 kΩ, C = 100 nF için

```text
fc = 1 / (2π × 1000 × 100×10⁻⁹) ≈ 1,59 kHz
```

Kesim frekansında çıkış genliği girişin 1/√2 katına (−3 dB) düşer, faz kayması −45°'dir. Kesim frekansının üstünde kazanç dekad başına −20 dB azalır.$md$, null, $md$easy$md$, $md$elektrik-elektronik-muhendisi$md$, $md$elektronik$md$),
  ($md$guc-faktoru-nedir-neden-duzeltilir$md$, $md$Güç faktörü nedir, neden düzeltilir?$md$, $md$Güç faktörü, aktif gücün (P, iş yapan güç, W) görünür güce (S, VA) oranıdır: `PF = P / S = cos φ`. φ, gerilim ile akım arasındaki faz farkıdır.

Endüktif yükler (motorlar, transformatörler) akımın gerilimden geri kalmasına ve reaktif güç (Q, VAr) çekilmesine yol açar. Düşük güç faktörünün sonuçları:

- Aynı aktif güç için daha yüksek akım çekilir
- Kablolarda ve trafolarda kayıplar artar, daha kalın iletken gerekir
- Elektrik dağıtım şirketi reaktif enerji cezası uygular

Düzeltme genellikle yüke paralel **kompanzasyon kondansatörleri** ile yapılır; doğrusal olmayan yüklerde aktif PFC devreleri kullanılır.$md$, null, $md$medium$md$, $md$elektrik-elektronik-muhendisi$md$, $md$guc-sistemleri$md$),
  ($md$uc-fazli-sistemlerde-yildiz-ve-ucgen-baglanti-arasindaki-fark-nedir$md$, $md$Üç fazlı sistemlerde yıldız ve üçgen bağlantı arasındaki fark nedir?$md$, $md$- **Yıldız (Y)**: üç sargının birer ucu ortak nötr noktasında birleşir. Hat gerilimi faz geriliminin √3 katıdır (`V_hat = √3 × V_faz`), hat akımı faz akımına eşittir. Nötr hattı sayesinde hem 230 V hem 400 V kullanılabilir.
- **Üçgen (Δ)**: sargılar uç uca bağlanarak kapalı bir çevre oluşturur. Hat gerilimi faz gerilimine eşittir, hat akımı faz akımının √3 katıdır (`I_hat = √3 × I_faz`). Nötr yoktur.

Her iki bağlantıda da toplam güç `P = √3 × V_hat × I_hat × cos φ` ile hesaplanır. Asenkron motorlarda yıldız-üçgen yol verme, kalkış akımını yaklaşık üçte birine düşürmek için kullanılır.$md$, null, $md$medium$md$, $md$elektrik-elektronik-muhendisi$md$, $md$guc-sistemleri$md$),
  ($md$pid-kontrolcusunde-p-i-ve-d-terimlerinin-etkisi-nedir$md$, $md$PID kontrolcüsünde P, I ve D terimlerinin etkisi nedir?$md$, $md$PID kontrolcü, hata sinyaline (e = referans − ölçüm) üç bileşenle tepki verir:

```text
u(t) = Kp·e(t) + Ki·∫e(t)dt + Kd·de(t)/dt
```

- **P (oransal)**: anlık hataya orantılı tepki. Kazanç arttıkça sistem hızlanır ama aşma (overshoot) artar; tek başına kalıcı durum hatası bırakabilir.
- **I (integral)**: geçmiş hataların toplamına tepki verir, **kalıcı durum hatasını sıfırlar**. Fazlası salınıma ve integral doymasına (windup) yol açar.
- **D (türev)**: hatanın değişim hızına tepki verir, aşmayı azaltır ve sönümlemeyi artırır. Gürültüye duyarlıdır, genelde filtreyle birlikte kullanılır.

Ayarlama için Ziegler–Nichols gibi yöntemler veya deneme yanılma kullanılır.$md$, $md$Gerçek uygulamada anti-windup ve türev filtresi kullandığınızı söylemek pratik deneyim gösterir.$md$, $md$hard$md$, $md$elektrik-elektronik-muhendisi$md$, $md$kontrol-sistemleri$md$),
  ($md$nyquist-ornekleme-teoremi-nedir$md$, $md$Nyquist örnekleme teoremi nedir?$md$, $md$Bant sınırlı bir analog sinyalin örneklerinden kayıpsız olarak yeniden oluşturulabilmesi için örnekleme frekansı, sinyaldeki en yüksek frekans bileşeninin **en az iki katı** olmalıdır:

```text
fs > 2 × fmax
```

Bu koşul sağlanmazsa yüksek frekanslar düşük frekans gibi görünür; buna **aliasing (örtüşme)** denir ve sonradan düzeltilemez. Bu yüzden ADC'den önce bir **anti-aliasing (alçak geçiren) filtre** kullanılır.

Örneğin insan kulağı yaklaşık 20 kHz'e kadar duyar; CD kalitesinde ses bu yüzden 44,1 kHz ile örneklenir.$md$, null, $md$medium$md$, $md$elektrik-elektronik-muhendisi$md$, $md$sinyal-isleme$md$),
  ($md$python-da-is-ile-operatorleri-arasindaki-fark-nedir$md$, $md$Python'da is ile == operatörleri arasındaki fark nedir?$md$, $md$- `==` **değer eşitliğini** kontrol eder; arka planda `__eq__` metodunu çağırır.
- `is` **kimlik eşitliğini** kontrol eder: iki isim bellekte **aynı nesneyi** mi gösteriyor? (`id(a) == id(b)`)

```python
a = [1, 2, 3]
b = [1, 2, 3]
c = a

a == b   # True  -> içerikleri aynı
a is b   # False -> farklı nesneler
a is c   # True  -> aynı nesne
```

### Ne zaman `is` kullanılır?

Yalnızca **singleton** nesnelerle karşılaştırırken: `None`, `True`, `False`, `Ellipsis` ya da kendi sentinel nesneleriniz.

```python
if deger is None:
    ...
```

`== None` yazmak çalışır ama bir sınıf `__eq__`'yu farklı tanımlamışsa yanıltıcı sonuç verebilir; PEP 8 `is None` önerir.

### Tuzak: küçük tamsayı ve string önbelleği

CPython -5 ile 256 arasındaki tamsayıları ve bazı kısa string'leri önbelleğe alır (interning). Bu yüzden `a = 256; b = 256; a is b` True dönebilir, ama 1000 için False olabilir. Bu bir implementasyon detayıdır; sayı ve string karşılaştırmasında **her zaman `==`** kullanın.$md$, null, $md$easy$md$, $md$backend-developer$md$, $md$python$md$),
  ($md$args-ve-kwargs-ne-ise-yarar-fonksiyon-parametre-siralamasi-nasil-olmalidir$md$, $md$*args ve **kwargs ne işe yarar? Fonksiyon parametre sıralaması nasıl olmalıdır?$md$, $md$- `*args`: fazladan verilen **konumsal** argümanları bir **tuple** içinde toplar.
- `**kwargs`: fazladan verilen **isimli** argümanları bir **dict** içinde toplar.

İsimler gelenekseldir; önemli olan `*` ve `**` işaretleridir.

```python
def logla(seviye, *args, **kwargs):
    print(seviye, args, kwargs)

logla("INFO", 1, 2, kullanici="ali", id=7)
# INFO (1, 2) {'kullanici': 'ali', 'id': 7}
```

### Açma (unpacking)

Çağrı tarafında aynı işaretler tersini yapar:

```python
sayilar = [1, 2, 3]
ayarlar = {"sep": "-", "end": "!\n"}
print(*sayilar, **ayarlar)   # 1-2-3!
```

### Parametre sıralaması

```python
def f(a, b, /, c, d=10, *args, e, f=5, **kwargs): ...
```

1. Yalnızca konumsal parametreler (`/` öncesi, Python 3.8+)
2. Normal parametreler ve varsayılanlıları
3. `*args`
4. Yalnızca isimli (keyword-only) parametreler: `*args` ya da tek başına `*` sonrası
5. `**kwargs`

### Pratik kullanım

Decorator'larda sarılan fonksiyonun imzasını bilmeden argümanları iletmek için kullanılır:

```python
def wrapper(*args, **kwargs):
    return func(*args, **kwargs)
```$md$, null, $md$easy$md$, $md$backend-developer$md$, $md$python$md$),
  ($md$shallow-copy-ile-deep-copy-arasindaki-fark-nedir$md$, $md$Shallow copy ile deep copy arasındaki fark nedir?$md$, $md$Python'da atama (`b = a`) kopya oluşturmaz; iki isim aynı nesneyi gösterir. Kopyalamanın iki seviyesi vardır:

- **Shallow copy:** yeni bir dış kapsayıcı oluşturur, ama içindeki elemanlar **aynı referanslardır**.
- **Deep copy:** iç içe tüm nesneleri özyinelemeli olarak kopyalar; tamamen bağımsız bir yapı üretir.

```python
import copy

orijinal = [[1, 2], [3, 4]]
sig = copy.copy(orijinal)       # veya orijinal[:] / list(orijinal)
derin = copy.deepcopy(orijinal)

orijinal[0].append(99)

print(sig)    # [[1, 2, 99], [3, 4]]  -> iç liste paylaşılıyor
print(derin)  # [[1, 2], [3, 4]]      -> etkilenmedi
```

| | Shallow | Deep |
| --- | --- | --- |
| Dış kapsayıcı | Yeni | Yeni |
| İç nesneler | Paylaşılır | Kopyalanır |
| Hız / bellek | Hızlı, az bellek | Yavaş, daha çok bellek |
| Yöntem | `copy.copy`, `list[:]`, `dict.copy()` | `copy.deepcopy` |

### Notlar

- İçerik yalnızca immutable nesnelerden (int, str, tuple of int) oluşuyorsa shallow copy yeterlidir.
- `deepcopy` döngüsel referansları `memo` sözlüğüyle yönetir, sonsuz döngüye girmez.
- Sınıflarda davranışı `__copy__` ve `__deepcopy__` ile özelleştirebilirsiniz.$md$, $md$Sık sorulan devam sorusu: `[[0] * 3] * 3` neden beklenmedik davranır? Cevap: dış liste aynı iç listeye 3 referans tutar; doğrusu `[[0] * 3 for _ in range(3)]`.$md$, $md$medium$md$, $md$backend-developer$md$, $md$python$md$),
  ($md$context-manager-nedir-with-ifadesi-nasil-calisir-ve-kendi-context-manager-inizi$md$, $md$Context manager nedir? with ifadesi nasıl çalışır ve kendi context manager'ınızı nasıl yazarsınız?$md$, $md$Context manager, bir kaynağın **edinilmesini ve garanti şekilde serbest bırakılmasını** sağlayan nesnedir. `with` bloğu hata ile çıksa bile temizlik kodu çalışır. Dosya, veritabanı bağlantısı, kilit (lock) ve transaction yönetiminde kullanılır.

### Protokol

- `__enter__`: blok başında çağrılır, dönüşü `as` değişkenine atanır.
- `__exit__(exc_type, exc, tb)`: blok bitince çağrılır. `True` dönerse istisna **yutulur**.

```python
import time

class Zamanlayici:
    def __enter__(self):
        self.bas = time.perf_counter()
        return self

    def __exit__(self, exc_type, exc, tb):
        self.sure = time.perf_counter() - self.bas
        print(f"{self.sure:.3f} sn")
        return False  # istisnayı yukarı ilet

with Zamanlayici():
    sum(range(10_000_000))
```

### contextlib ile daha kısa

```python
from contextlib import contextmanager

@contextmanager
def transaction(conn):
    try:
        yield conn
        conn.commit()
    except Exception:
        conn.rollback()
        raise
```

`yield` öncesi `__enter__`, sonrası `__exit__` gibi davranır. `try/finally` kullanmazsanız hata durumunda temizlik çalışmaz.

### Faydalı araçlar

- `contextlib.suppress(FileNotFoundError)`: belirli istisnaları yok sayar.
- `contextlib.ExitStack`: dinamik sayıda context manager'ı yönetir.
- Async kod için `async with` ve `__aenter__` / `__aexit__` (veya `@asynccontextmanager`).$md$, null, $md$medium$md$, $md$backend-developer$md$, $md$python$md$),
  ($md$dataclass-nedir-normal-sinif-namedtuple-ve-pydantic-ile-farki-nedir$md$, $md$dataclass nedir? Normal sınıf, NamedTuple ve Pydantic ile farkı nedir?$md$, $md$`@dataclass` (Python 3.7+), tip ipuçlarından yola çıkarak `__init__`, `__repr__` ve `__eq__` metodlarını otomatik üretir. Veri taşıyan sınıflardaki tekrar eden kodu ortadan kaldırır.

```python
from dataclasses import dataclass, field

@dataclass(frozen=True, slots=True)
class Siparis:
    id: int
    musteri: str
    urunler: list[str] = field(default_factory=list)
    toplam: float = 0.0

s = Siparis(1, "Ayşe")
print(s)  # Siparis(id=1, musteri='Ayşe', urunler=[], toplam=0.0)
```

- `frozen=True`: alanlar değiştirilemez, nesne hash'lenebilir olur.
- `slots=True` (3.10+): `__slots__` üretir, bellek tasarrufu sağlar.
- Mutable varsayılan için `field(default_factory=list)` zorunludur; `= []` yazmak hata verir.
- `__post_init__` ile ek doğrulama yapılabilir.

### Karşılaştırma

| | dataclass | NamedTuple | Pydantic BaseModel |
| --- | --- | --- | --- |
| Değiştirilebilir | Evet (frozen değilse) | Hayır | Evet |
| Çalışma zamanı tip doğrulaması | Yok | Yok | Var |
| Tip dönüşümü ("5" -> 5) | Yok | Yok | Var |
| Tipik kullanım | İç domain nesneleri | Hafif, tuple uyumlu kayıtlar | API girdisi, config, JSON |

Önemli nokta: Python tip ipuçları çalışma zamanında **zorlanmaz**. `Siparis(id="abc", ...)` dataclass'ta hata vermez. Dış dünyadan gelen veriyi (HTTP isteği, env değişkeni) doğrulamak gerekiyorsa Pydantic gibi bir kütüphane tercih edilir; FastAPI bu yüzden Pydantic kullanır.$md$, $md$Tip ipuçlarının çalışma zamanında kontrol edilmediğini ve bunun için mypy/pyright gibi statik analiz araçları kullanıldığını söylemek beklenen bir detaydır.$md$, $md$medium$md$, $md$backend-developer$md$, $md$python$md$),
  ($md$async-await-ve-asyncio-nasil-calisir-ne-zaman-thread-veya-process-yerine-tercih$md$, $md$async/await ve asyncio nasıl çalışır? Ne zaman thread veya process yerine tercih edilir?$md$, $md$`asyncio`, **tek thread** üzerinde çalışan bir **event loop** ile eşzamanlılık (concurrency) sağlar. `async def` ile tanımlanan fonksiyon çağrıldığında hemen çalışmaz, bir **coroutine** nesnesi döner. `await`, coroutine'i I/O beklerken askıya alır ve kontrolü event loop'a bırakır; loop bu sürede başka görevleri çalıştırır.

```python
import asyncio
import httpx

async def getir(client, url):
    r = await client.get(url)
    return r.status_code

async def main():
    urls = [f"https://api.example.com/items/{i}" for i in range(100)]
    async with httpx.AsyncClient() as client:
        sonuclar = await asyncio.gather(*(getir(client, u) for u in urls))
    print(sonuclar)

asyncio.run(main())
```

100 istek sırayla değil, **eşzamanlı** bekletilir; toplam süre yaklaşık en yavaş isteğin süresi kadar olur.

### Temel kavramlar

- `asyncio.create_task(coro)`: coroutine'i arka planda zamanlar.
- `asyncio.gather` / `TaskGroup` (3.11+): birden çok görevi birlikte bekler.
- `asyncio.Semaphore`: aynı anda çalışan görev sayısını sınırlar.
- `asyncio.wait_for(coro, timeout=5)`: zaman aşımı ekler.

### En sık hata: event loop'u bloklamak

`async` fonksiyon içinde `time.sleep()`, `requests.get()` veya ağır CPU hesabı yapılırsa **tüm** loop durur. Çözüm: `await asyncio.sleep()`, async kütüphaneler (httpx, asyncpg) ya da bloklayan kodu `await asyncio.to_thread(fonk)` ile thread'e taşımak.

### Hangisini seçmeli?

| İş yükü | Tercih |
| --- | --- |
| Çok sayıda ağ/DB beklemesi (I/O-bound) | asyncio |
| I/O-bound ama kütüphane senkron | threading |
| CPU-bound (hesaplama, görüntü işleme) | multiprocessing |

asyncio paralellik değil eşzamanlılık sağlar; GIL nedeniyle CPU-bound işi hızlandırmaz.$md$, $md$Concurrency ile parallelism arasındaki farkı net söyleyin: asyncio görevleri iç içe geçirir (interleave), aynı anda iki çekirdekte çalıştırmaz.$md$, $md$hard$md$, $md$backend-developer$md$, $md$python$md$),
  ($md$where-ile-having-arasindaki-fark-nedir-group-by-ile-nasil-kullanilir$md$, $md$WHERE ile HAVING arasındaki fark nedir? GROUP BY ile nasıl kullanılır?$md$, $md$- `WHERE`: satırları **gruplamadan önce** filtreler. Aggregate fonksiyon (`COUNT`, `SUM`) kullanamaz.
- `HAVING`: **gruplamadan sonra**, oluşan grupları filtreler. Aggregate sonuçlarına koşul koyar.

```sql
-- 2025 yılında 5'ten fazla sipariş veren ve toplam harcaması 1000'i aşan müşteriler
SELECT musteri_id,
       COUNT(*)   AS siparis_sayisi,
       SUM(tutar) AS toplam
FROM siparisler
WHERE tarih >= '2025-01-01' AND tarih < '2026-01-01'   -- satır filtresi
GROUP BY musteri_id
HAVING COUNT(*) > 5 AND SUM(tutar) > 1000             -- grup filtresi
ORDER BY toplam DESC;
```

### Mantıksal çalışma sırası

1. `FROM` / `JOIN`
2. `WHERE`
3. `GROUP BY`
4. `HAVING`
5. `SELECT`
6. `ORDER BY`
7. `LIMIT`

Bu sıra şunu açıklar: `SELECT`'te verilen takma ad (`toplam`) çoğu veritabanında `WHERE` içinde kullanılamaz, ama `ORDER BY` içinde kullanılabilir.

### GROUP BY kuralı

`SELECT` listesindeki her sütun ya `GROUP BY`'da yer almalı ya da bir aggregate fonksiyon içinde olmalıdır. (PostgreSQL, gruplanan sütun primary key ise aynı tablodaki diğer sütunlara izin verir.)

Performans ipucu: bir koşul gruplamadan önce uygulanabiliyorsa `WHERE`'e yazın; daha az satır gruplanır.$md$, null, $md$easy$md$, $md$backend-developer$md$, $md$veritabani-sql$md$),
  ($md$sql-ve-nosql-veritabanlari-arasindaki-farklar-nelerdir-hangisini-ne-zaman-secers$md$, $md$SQL ve NoSQL veritabanları arasındaki farklar nelerdir? Hangisini ne zaman seçersiniz?$md$, $md$| | SQL (ilişkisel) | NoSQL |
| --- | --- | --- |
| Örnekler | PostgreSQL, MySQL | MongoDB, Redis, Cassandra, DynamoDB |
| Veri modeli | Tablolar, satırlar, ilişkiler | Doküman, key-value, wide-column, graph |
| Şema | Katı, önceden tanımlı | Esnek ya da şemasız |
| Sorgu | Güçlü JOIN, standart SQL | Genelde JOIN zayıf, erişim desenine göre modelleme |
| Tutarlılık | ACID transaction | Çoğu zaman eventual consistency (ayarlanabilir) |
| Ölçekleme | Genelde dikey; yatay için sharding zahmetli | Yatay ölçeklemeye göre tasarlanmış |

### NoSQL türleri

- **Doküman (MongoDB):** iç içe JSON benzeri kayıtlar, değişken yapılı içerik.
- **Key-value (Redis, DynamoDB):** cache, session, sayaçlar.
- **Wide-column (Cassandra):** çok yüksek yazma hacmi, zaman serisi, log.
- **Graph (Neo4j):** ilişkinin kendisinin veri olduğu durumlar (sosyal ağ, öneri).

### Seçim kriterleri

SQL tercih edin:
- Veri yapısı belli ve ilişkisel (sipariş, müşteri, fatura)
- Para, stok gibi güçlü tutarlılık gerektiren işlemler
- Önceden bilinmeyen, esnek raporlama sorguları

NoSQL tercih edin:
- Çok yüksek ölçekte basit erişim desenleri (ID ile oku/yaz)
- Şeması sık değişen veya kayıttan kayda farklılaşan veri
- Düşük gecikmeli cache/session katmanı

Pratikte çoğu sistem ikisini birlikte kullanır (polyglot persistence): ana veri PostgreSQL'de, cache Redis'te, arama Elasticsearch'te. Ayrıca PostgreSQL'in `JSONB` desteği birçok "esnek şema" ihtiyacını tek başına karşılar.$md$, $md$"NoSQL daha hızlıdır" gibi genellemelerden kaçının. Seçimi erişim desenine, tutarlılık ihtiyacına ve ölçeğe bağlayarak anlatmak olgunluk gösterir.$md$, $md$easy$md$, $md$backend-developer$md$, $md$veritabani-sql$md$),
  ($md$window-function-nedir-row-number-rank-ve-dense-rank-arasindaki-fark-nedir$md$, $md$Window function nedir? ROW_NUMBER, RANK ve DENSE_RANK arasındaki fark nedir?$md$, $md$Window function, `GROUP BY` gibi satırları tek satıra **indirgemeden**, her satır için ilişkili bir satır kümesi (pencere) üzerinde hesap yapar. `OVER (...)` ifadesiyle tanımlanır.

```sql
SELECT ad, departman, maas,
       AVG(maas)    OVER (PARTITION BY departman)                  AS dept_ort,
       ROW_NUMBER() OVER (PARTITION BY departman ORDER BY maas DESC) AS rn,
       RANK()       OVER (PARTITION BY departman ORDER BY maas DESC) AS rnk,
       DENSE_RANK() OVER (PARTITION BY departman ORDER BY maas DESC) AS drnk
FROM calisanlar;
```

- `PARTITION BY`: pencereyi gruplara böler (opsiyonel).
- `ORDER BY`: pencere içindeki sırayı belirler.

### Sıralama fonksiyonları (maaşlar: 100, 100, 90)

| maas | ROW_NUMBER | RANK | DENSE_RANK |
| --- | --- | --- | --- |
| 100 | 1 | 1 | 1 |
| 100 | 2 | 1 | 1 |
| 90 | 3 | 3 | 2 |

- `ROW_NUMBER`: eşitlikte bile benzersiz numara verir.
- `RANK`: eşitlere aynı sırayı verir, sonra **boşluk bırakır**.
- `DENSE_RANK`: eşitlere aynı sırayı verir, boşluk bırakmaz.

### Sık kullanılan diğerleri

- `LAG(col)` / `LEAD(col)`: önceki/sonraki satırın değeri (ör. günlük değişim).
- `SUM(col) OVER (ORDER BY tarih)`: kümülatif toplam (running total).

### Klasik örnek: her departmanın en yüksek maaşlı 2 çalışanı

```sql
SELECT * FROM (
  SELECT *, DENSE_RANK() OVER (PARTITION BY departman ORDER BY maas DESC) AS r
  FROM calisanlar
) t
WHERE r <= 2;
```

Window function'lar `WHERE` içinde doğrudan kullanılamaz (WHERE'den sonra hesaplanırlar); bu yüzden alt sorgu veya CTE gerekir.$md$, null, $md$medium$md$, $md$backend-developer$md$, $md$veritabani-sql$md$),
  ($md$composite-bilesik-index-nedir-leftmost-prefix-kurali-ne-demektir$md$, $md$Composite (bileşik) index nedir? Leftmost prefix kuralı ne demektir?$md$, $md$Composite index, birden fazla sütun üzerine kurulan tek bir index'tir. B-Tree yapısında kayıtlar önce birinci sütuna, eşitlikte ikinci sütuna göre sıralanır (telefon rehberinde soyad, sonra ad gibi).

```sql
CREATE INDEX idx_siparis ON siparisler (musteri_id, durum, tarih);
```

### Leftmost prefix kuralı

Index yalnızca **soldan başlayan** sütun kombinasyonları için verimli kullanılabilir:

| Sorgu koşulu | Index kullanılır mı? |
| --- | --- |
| `musteri_id = 5` | Evet |
| `musteri_id = 5 AND durum = 'aktif'` | Evet |
| `musteri_id = 5 AND durum = 'aktif' AND tarih > '2025-01-01'` | Evet, üç sütun da |
| `durum = 'aktif'` | Hayır (ilk sütun yok) |
| `musteri_id = 5 AND tarih > '2025-01-01'` | Kısmen: yalnızca `musteri_id` ile daraltır |

Koşulların SQL'de yazılış sırası önemli değildir; optimizer bunları düzenler. Önemli olan index tanımındaki sütun sırasıdır.

### Sütun sırası nasıl seçilir?

1. **Eşitlik** (`=`) koşulundaki sütunlar önce, **aralık** (`>`, `BETWEEN`, `LIKE 'abc%'`) koşulundakiler sona. Aralık koşulundan sonraki sütunlar arama için kullanılamaz.
2. En sık birlikte sorgulanan sütunlar.
3. `ORDER BY` da index sırasına uyarsa ayrıca sıralama yapılmaz.

### Covering index

Sorgunun ihtiyaç duyduğu tüm sütunlar index'te varsa veritabanı tabloya hiç gitmez (PostgreSQL'de "Index Only Scan"). PostgreSQL'de `INCLUDE` ile arama dışı sütunlar eklenebilir:

```sql
CREATE INDEX idx_kapsayan ON siparisler (musteri_id) INCLUDE (tutar);
```$md$, $md$"(a, b) index'i varken ayrıca (a) index'i gerekir mi?" sorusuna cevap: genelde hayır, (a, b) zaten a için kullanılabilir; gereksiz index yazmaları yavaşlatır.$md$, $md$medium$md$, $md$backend-developer$md$, $md$veritabani-sql$md$),
  ($md$yavas-bir-sorguyu-explain-ile-nasil-analiz-edersiniz$md$, $md$Yavaş bir sorguyu EXPLAIN ile nasıl analiz edersiniz?$md$, $md$`EXPLAIN`, veritabanının sorguyu **nasıl çalıştırmayı planladığını** gösterir. `EXPLAIN ANALYZE` (PostgreSQL) sorguyu **gerçekten çalıştırır** ve gerçek süreleri ile satır sayılarını da verir.

```sql
EXPLAIN (ANALYZE, BUFFERS)
SELECT * FROM siparisler WHERE musteri_id = 42 ORDER BY tarih DESC LIMIT 20;
```

Dikkat: `EXPLAIN ANALYZE` bir `UPDATE`/`DELETE` üzerinde çalıştırılırsa değişikliği gerçekten yapar; transaction içinde çalıştırıp `ROLLBACK` edin.

### Nelere bakılır?

- **Seq Scan** büyük bir tabloda: muhtemelen eksik ya da kullanılmayan index.
- **Index Scan / Index Only Scan / Bitmap Index Scan:** index kullanılıyor.
- **Tahmini vs gerçek satır sayısı** (`rows=10` vs `actual rows=50000`): büyük fark eski istatistik demektir, `ANALYZE tablo;` çalıştırın.
- **Sort** ve `external merge Disk`: sıralama belleğe sığmıyor; index ile sıralamayı önleyin ya da `work_mem` artırın.
- **Join tipi:** Nested Loop (küçük setler), Hash Join (büyük eşitlik join'leri), Merge Join (sıralı girdiler).
- En yüksek `actual time` alan düğüm darboğazdır.

### Index'in kullanılmamasının yaygın nedenleri

1. Sütuna fonksiyon uygulanması: `WHERE LOWER(email) = ...` (çözüm: expression index)
2. Tip uyuşmazlığı: sayı sütununu string ile karşılaştırmak
3. `LIKE '%abc'` gibi başta joker karakter
4. Düşük seçicilik: tablonun büyük kısmı dönüyorsa optimizer bilerek Seq Scan seçer
5. Composite index'te leftmost prefix kuralına uymamak

### Genel süreç

Yavaş sorguları `pg_stat_statements` veya slow query log ile bulun, `EXPLAIN ANALYZE` ile darboğazı tespit edin, index veya sorgu yeniden yazımı uygulayın ve tekrar ölçün.$md$, null, $md$medium$md$, $md$backend-developer$md$, $md$veritabani-sql$md$),
  ($md$optimistic-locking-ile-pessimistic-locking-arasindaki-fark-nedir$md$, $md$Optimistic locking ile pessimistic locking arasındaki fark nedir?$md$, $md$İki kullanıcının aynı kaydı aynı anda güncellemesi sonucu birinin değişikliğinin kaybolmasına **lost update** denir. İki yaklaşımla önlenir.

### Pessimistic locking

"Çakışma olacak" varsayımıyla kaydı okurken **kilitler**; transaction bitene kadar diğerleri bekler.

```sql
BEGIN;
SELECT bakiye FROM hesaplar WHERE id = 1 FOR UPDATE;  -- satır kilitlenir
UPDATE hesaplar SET bakiye = bakiye - 100 WHERE id = 1;
COMMIT;
```

### Optimistic locking

"Çakışma nadirdir" varsayımıyla kilit almaz. Bir `version` sütunu tutulur; güncelleme sırasında versiyonun değişmediği kontrol edilir.

```sql
-- Okurken: version = 7
UPDATE urunler
SET stok = 9, version = version + 1
WHERE id = 10 AND version = 7;
-- Etkilenen satır 0 ise başkası önce güncellemiş: yeniden oku ve tekrar dene
```

ORM'ler bunu hazır sunar (JPA `@Version`, Django'da elle, SQLAlchemy `version_id_col`).

| | Pessimistic | Optimistic |
| --- | --- | --- |
| Mekanizma | Veritabanı kilidi | Versiyon / timestamp kontrolü |
| Çakışma sık olduğunda | İyi | Çok sayıda retry, kötü |
| Çakışma nadir olduğunda | Gereksiz bekleme | İyi, yüksek eşzamanlılık |
| Riskler | Deadlock, uzun bekleme | Retry mantığı yazılmalı |
| Uzun süren işlem (kullanıcı formu) | Uygun değil | Uygun |

Pratik kural: stok düşme, bakiye gibi kısa ve sık çakışan işlemlerde pessimistic; kullanıcının bir formu dakikalarca açık tuttuğu düzenleme ekranlarında optimistic tercih edilir. Basit sayaçlarda ise `UPDATE ... SET stok = stok - 1 WHERE stok > 0` gibi atomik güncelleme çoğu zaman ikisine de gerek bırakmaz.$md$, null, $md$medium$md$, $md$backend-developer$md$, $md$veritabani-sql$md$),
  ($md$transaction-isolation-level-lari-nelerdir-hangi-anomalileri-onlerler$md$, $md$Transaction isolation level'ları nelerdir? Hangi anomalileri önlerler?$md$, $md$Isolation level, eşzamanlı transaction'ların birbirinin yaptığı değişiklikleri ne kadar görebileceğini belirler. Seviye arttıkça tutarlılık artar, eşzamanlılık performansı düşer.

### Anomaliler

- **Dirty read:** henüz commit edilmemiş veriyi okumak.
- **Non-repeatable read:** aynı satırı iki kez okuyunca farklı değer görmek (arada başkası güncelledi).
- **Phantom read:** aynı koşulla iki sorguda farklı satır kümesi görmek (arada başkası satır ekledi).
- **Serialization anomaly / write skew:** her transaction tek başına geçerli, ama birlikte tutarsız sonuç (ör. iki doktor aynı anda nöbetten çıkar, kimse kalmaz).

### Seviyeler (SQL standardı)

| Seviye | Dirty read | Non-repeatable | Phantom |
| --- | --- | --- | --- |
| Read Uncommitted | Olabilir | Olabilir | Olabilir |
| Read Committed | Önlenir | Olabilir | Olabilir |
| Repeatable Read | Önlenir | Önlenir | Olabilir |
| Serializable | Önlenir | Önlenir | Önlenir |

### Gerçek veritabanlarındaki farklar

- **PostgreSQL** varsayılanı Read Committed'dir. MVCC kullanır, Read Uncommitted'i Read Committed gibi davranır. Repeatable Read'i snapshot isolation olduğu için phantom'ları da önler; Serializable seviyesi (SSI) çakışma tespit edince transaction'ı hata ile iptal eder.
- **MySQL InnoDB** varsayılanı Repeatable Read'dir; gap lock'larla phantom'ların çoğunu engeller.

```sql
BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
SELECT COUNT(*) FROM nobetler WHERE gun = '2026-10-20';
UPDATE nobetler SET aktif = false WHERE doktor_id = 3;
COMMIT;  -- çakışma varsa: could not serialize access... -> uygulama tekrar dener
```

### Pratik çıkarım

Serializable veya Repeatable Read kullanıyorsanız uygulama tarafında **retry mantığı** zorunludur. Çoğu sistem Read Committed ile çalışır ve kritik noktalarda `SELECT ... FOR UPDATE` veya unique constraint gibi hedefli çözümler kullanır.$md$, $md$Standart tablonun yanında kullandığınız veritabanının varsayılan seviyesini (PostgreSQL: Read Committed, MySQL: Repeatable Read) bilmek mülakatta fark yaratır.$md$, $md$hard$md$, $md$backend-developer$md$, $md$veritabani-sql$md$),
  ($md$deadlock-nedir-veritabaninda-nasil-olusur-ve-nasil-onlenir$md$, $md$Deadlock nedir? Veritabanında nasıl oluşur ve nasıl önlenir?$md$, $md$Deadlock, iki (veya daha fazla) transaction'ın birbirinin tuttuğu kilidi beklemesi ve hiçbirinin ilerleyememesidir.

### Örnek

```sql
-- Transaction A                      -- Transaction B
BEGIN;                                 BEGIN;
UPDATE hesaplar SET ... WHERE id = 1;  UPDATE hesaplar SET ... WHERE id = 2;
-- id=1 kilitli                         -- id=2 kilitli
UPDATE hesaplar SET ... WHERE id = 2;  UPDATE hesaplar SET ... WHERE id = 1;
-- B'yi bekler                          -- A'yı bekler -> DEADLOCK
```

Para transferinde A, 1'den 2'ye; B ise 2'den 1'e aynı anda gönderim yaparsa tam olarak bu olur.

### Veritabanı ne yapar?

PostgreSQL ve MySQL bekleme grafiğinde döngü tespit eder ve transaction'lardan birini **kurban seçip iptal eder** (PostgreSQL: `deadlock detected`, MySQL: error 1213). Diğeri devam eder. Uygulama iptal edilen transaction'ı **yeniden denemelidir**.

### Önleme yöntemleri

1. **Kilitleri her zaman aynı sırada alın.** Transfer örneğinde önce küçük ID'li hesabı kilitleyin:

```sql
SELECT * FROM hesaplar WHERE id IN (1, 2) ORDER BY id FOR UPDATE;
```

2. **Transaction'ları kısa tutun;** transaction içinde HTTP çağrısı veya kullanıcı beklemesi yapmayın.
3. **Doğru index kullanın;** index olmadan `UPDATE ... WHERE` gereğinden fazla satırı (veya gap'i) kilitleyebilir.
4. Gerekenden yüksek isolation level kullanmayın.
5. `lock_timeout` ile sonsuza kadar beklemeyi engelleyin; `NOWAIT` veya `SKIP LOCKED` ile alternatif akış kurun (iş kuyruğu tablolarında `SKIP LOCKED` çok kullanılır).

### Tespit

PostgreSQL'de `log_lock_waits = on` ve log'lardaki deadlock detayları; MySQL'de `SHOW ENGINE INNODB STATUS` son deadlock'u gösterir.$md$, null, $md$hard$md$, $md$backend-developer$md$, $md$veritabani-sql$md$),
  ($md$rest-api-tasariminda-kaynak-resource-isimlendirme-ve-url-yapisi-nasil-olmalidir$md$, $md$REST API tasarımında kaynak (resource) isimlendirme ve URL yapısı nasıl olmalıdır?$md$, $md$REST'te URL **kaynağı** (isim) belirtir, yapılacak **işlemi** ise HTTP metodu belirtir.

### Temel kurallar

- İsim kullanın, fiil kullanmayın: `/users`, `/getUsers` değil.
- Koleksiyonlar için çoğul: `/orders`, `/orders/42`.
- İlişkiler için hiyerarşi: `/users/42/orders`. İki seviyeden derine inmekten kaçının.
- Küçük harf ve tire: `/order-items` (kebab-case).
- Filtre, sıralama ve sayfalama query string'de: `/orders?status=paid&sort=-created_at&limit=20`.
- Sonda `/` ve dosya uzantısı (`.json`) yok; format `Accept` başlığıyla belirlenir.

### Metot ve URL eşleşmesi

| İşlem | Metot ve URL | Başarılı yanıt |
| --- | --- | --- |
| Listele | `GET /orders` | 200 |
| Getir | `GET /orders/42` | 200 / 404 |
| Oluştur | `POST /orders` | 201 + `Location` başlığı |
| Tamamen değiştir | `PUT /orders/42` | 200 / 204 |
| Kısmi güncelle | `PATCH /orders/42` | 200 |
| Sil | `DELETE /orders/42` | 204 |

### CRUD'a uymayan işlemler

Durum değişikliğini alt kaynak olarak modelleyin:

```
POST /orders/42/cancellation
POST /orders/42/refunds
```

Bu mümkün değilse pragmatik bir aksiyon ucu kabul edilebilir (`POST /orders/42/cancel`), ama tutarlı olun.

### Tutarlılık

Hata yanıtları için tek bir format (ör. RFC 9457 Problem Details: `type`, `title`, `status`, `detail`), JSON alanlarında tek bir isimlendirme stili (camelCase veya snake_case) ve tarihler için ISO 8601 kullanın.$md$, null, $md$easy$md$, $md$backend-developer$md$, $md$api-tasarimi$md$),
  ($md$offset-tabanli-ve-cursor-tabanli-sayfalama-pagination-arasindaki-fark-nedir$md$, $md$Offset tabanlı ve cursor tabanlı sayfalama (pagination) arasındaki fark nedir?$md$, $md$### Offset pagination

```
GET /posts?limit=20&offset=40
```
```sql
SELECT * FROM posts ORDER BY created_at DESC LIMIT 20 OFFSET 40;
```

Basit ve "5. sayfaya git" gibi rastgele erişime izin verir. Sorunları:

- **Performans:** `OFFSET 100000` için veritabanı 100.000 satırı okuyup atar; derin sayfalar yavaşlar.
- **Tutarsızlık:** kullanıcı sayfalar arasında gezerken yeni kayıt eklenirse kayıtlar kayar; aynı öğe iki kez görünür ya da atlanır.

### Cursor (keyset) pagination

Son görülen kaydın sıralama anahtarı "cursor" olarak döndürülür, sonraki sayfa ondan sonrasını ister.

```
GET /posts?limit=20&cursor=eyJjIjoiMjAyNi0xMC0xOVQxMDowMDowMFoiLCJpZCI6OTgxfQ
```
```sql
SELECT * FROM posts
WHERE (created_at, id) < ('2026-10-19T10:00:00Z', 981)
ORDER BY created_at DESC, id DESC
LIMIT 20;
```

- Index üzerinden doğrudan konumlanır; sayfa derinliğinden bağımsız hızlıdır.
- Ekleme/silmede kayma olmaz.
- Eşitlikleri çözmek için sıralamaya benzersiz bir sütun (`id`) eklenmelidir.
- Cursor genelde base64 ile kodlanmış opak bir değerdir; istemci içeriğine güvenmemelidir.

| | Offset | Cursor |
| --- | --- | --- |
| Belirli sayfaya atlama | Var | Yok |
| Derin sayfa performansı | Kötü | İyi |
| Eşzamanlı yazmada tutarlılık | Zayıf | Güçlü |
| Uygun yer | Admin tabloları, küçük veri | Sonsuz kaydırma, feed, büyük veri, public API |

Yanıtta `next_cursor` (veya `has_more`) döndürülür; `null` ise son sayfadır.$md$, $md$Toplam kayıt sayısı (`COUNT(*)`) büyük tablolarda pahalıdır. Bunun gerçekten gerekip gerekmediğini sorgulamak iyi bir tasarım refleksi olarak görülür.$md$, $md$medium$md$, $md$backend-developer$md$, $md$api-tasarimi$md$),
  ($md$api-versiyonlama-yontemleri-nelerdir-geriye-donuk-uyumlulugu-nasil-korursunuz$md$, $md$API versiyonlama yöntemleri nelerdir? Geriye dönük uyumluluğu nasıl korursunuz?$md$, $md$Versiyonlama, mevcut istemcileri bozmadan API'yi geliştirebilmek içindir.

### Yöntemler

| Yöntem | Örnek | Artı | Eksi |
| --- | --- | --- | --- |
| URL path | `/v1/orders` | Açık, kolay test, cache dostu | URL kaynağı değil versiyonu da taşır |
| Query param | `/orders?version=2` | Kolay | Unutulabilir, cache karmaşası |
| Header | `Api-Version: 2` | URL temiz kalır | Tarayıcıdan test zor, görünmez |
| Media type | `Accept: application/vnd.firma.v2+json` | REST'e en uygun | Karmaşık |

Pratikte en yaygın yöntem **URL path**'tir. Stripe gibi bazı API'ler tarih bazlı header versiyonları kullanır (`Stripe-Version: 2024-06-20`).

### Breaking vs non-breaking değişiklik

Non-breaking (aynı versiyonda yapılabilir):
- Yeni endpoint eklemek
- Yanıta yeni, opsiyonel alan eklemek
- Yeni opsiyonel istek parametresi

Breaking (yeni versiyon gerektirir):
- Alan silmek veya adını değiştirmek
- Alanın tipini değiştirmek (`id` sayıdan string'e)
- Opsiyonel alanı zorunlu yapmak
- Hata kodlarını veya anlamını değiştirmek

### Geriye dönük uyumluluk pratikleri

1. İstemcilerin bilinmeyen alanları yok saymasını bekleyin (tolerant reader).
2. Yeni versiyonu yayınlayınca eskisini hemen kapatmayın; `Deprecation` ve `Sunset` başlıklarıyla duyurun.
3. Eski versiyonun kullanımını metriklerle izleyin, istemcilerle iletişim kurun.
4. Versiyonu yalnızca major değişiklikte artırın; her küçük değişiklikte v3, v4 açmak bakım yükünü katlar.
5. Mümkünse versiyonlar arası farkı ayrı controller kopyaları yerine bir dönüşüm katmanıyla yönetin.$md$, null, $md$medium$md$, $md$backend-developer$md$, $md$api-tasarimi$md$),
  ($md$webhook-nedir-guvenilir-ve-guvenli-bir-webhook-sistemi-nasil-tasarlanir$md$, $md$Webhook nedir? Güvenilir ve güvenli bir webhook sistemi nasıl tasarlanır?$md$, $md$Webhook, bir olay gerçekleştiğinde sistemin karşı tarafa **HTTP POST ile bildirim göndermesidir** ("bizi aramayın, biz sizi ararız"). İstemcinin sürekli polling yapmasına gerek bırakmaz. Örnek: ödeme sağlayıcısının `payment.succeeded` olayını sizin `/webhooks/payments` adresinize göndermesi.

### Gönderen taraf (provider)

- **İmza:** gövdeyi paylaşılan bir secret ile HMAC-SHA256 imzalayıp başlıkta gönderin.
- **Timestamp:** imzaya zaman damgasını dahil edin; alıcı eski istekleri reddederek replay saldırısını önler.
- **Retry:** 2xx dışı yanıt veya timeout'ta exponential backoff ile yeniden deneyin (ör. 1 dk, 5 dk, 30 dk ... 24 saat).
- **Event ID:** her olaya benzersiz ID verin.
- Başarısız teslimatları görüntüleyip elle yeniden göndermeye imkân tanıyın.

### Alan taraf (consumer)

```js
app.post("/webhooks/payments", express.raw({ type: "application/json" }), async (req, res) => {
  const imza = req.header("X-Signature");
  const beklenen = crypto.createHmac("sha256", SECRET).update(req.body).digest("hex");
  if (!imza || !crypto.timingSafeEqual(Buffer.from(imza), Buffer.from(beklenen))) {
    return res.sendStatus(401);
  }
  const olay = JSON.parse(req.body);
  await kuyruk.ekle(olay);   // ağır işi sonra yap
  res.sendStatus(200);       // hızlıca onayla
});
```

1. İmzayı **ham gövde** üzerinden doğrulayın; parse edilip yeniden serialize edilmiş JSON farklı olabilir.
2. Hızlıca 2xx dönün, asıl işi kuyrukta yapın; aksi hâlde timeout ve gereksiz retry oluşur.
3. **Idempotent** olun: retry nedeniyle aynı olay birden çok kez gelebilir (at-least-once). İşlenen event ID'lerini saklayıp tekrarları atlayın.
4. Sıralamaya güvenmeyin; olaylar sırasız gelebilir. Gerekirse kaynağın güncel durumunu API'den çekin.$md$, $md$Webhook teslimatının "at-least-once" olduğunu ve bu yüzden alıcının idempotent olması gerektiğini vurgulamak, bu sorunun anahtar noktasıdır.$md$, $md$medium$md$, $md$backend-developer$md$, $md$api-tasarimi$md$),
  ($md$grpc-nedir-rest-ten-farki-nedir-ve-ne-zaman-tercih-edilir$md$, $md$gRPC nedir? REST'ten farkı nedir ve ne zaman tercih edilir?$md$, $md$gRPC, Google'ın geliştirdiği, **HTTP/2** üzerinde çalışan ve veriyi **Protocol Buffers** (protobuf) ile binary olarak serileştiren bir RPC framework'üdür. Servis sözleşmesi `.proto` dosyasında tanımlanır, istemci ve sunucu kodu bu dosyadan üretilir.

```protobuf
syntax = "proto3";

service SiparisServisi {
  rpc SiparisGetir (SiparisIstegi) returns (Siparis);
  rpc DurumIzle (SiparisIstegi) returns (stream DurumGuncelleme);
}

message SiparisIstegi { int64 id = 1; }
message Siparis {
  int64 id = 1;
  string musteri = 2;
  double toplam = 3;
}
message DurumGuncelleme { string durum = 1; }
```

### İletişim tipleri

- Unary (tek istek, tek yanıt)
- Server streaming
- Client streaming
- Bidirectional streaming

### REST ile karşılaştırma

| | REST (JSON) | gRPC |
| --- | --- | --- |
| Protokol | Genelde HTTP/1.1 | HTTP/2 |
| Format | JSON, okunabilir | Protobuf, binary ve küçük |
| Sözleşme | Opsiyonel (OpenAPI) | Zorunlu (.proto), kod üretimi |
| Streaming | Sınırlı (SSE, WebSocket) | Yerleşik, çift yönlü |
| Tarayıcı desteği | Doğal | Doğrudan yok, gRPC-Web proxy gerekir |
| Hata ayıklama | curl ile kolay | grpcurl gibi araçlar gerekir |

### Ne zaman gRPC?

- Mikroservisler arası iç iletişim, düşük gecikme ve yüksek hacim
- Çok dilli ortamlarda tip güvenli sözleşme
- Gerçek zamanlı streaming ihtiyacı

### Ne zaman REST?

- Public API'ler, tarayıcı ve üçüncü parti istemciler
- Basitlik ve HTTP cache'lemenin önemli olduğu durumlar

Protobuf'ta alan numaraları (`= 1`, `= 2`) binary formatın parçasıdır; geriye uyumluluk için mevcut numaralar asla değiştirilmez veya yeniden kullanılmaz.$md$, null, $md$medium$md$, $md$backend-developer$md$, $md$api-tasarimi$md$),
  ($md$rate-limiting-nedir-token-bucket-ve-sliding-window-algoritmalarini-aciklayin$md$, $md$Rate limiting nedir? Token bucket ve sliding window algoritmalarını açıklayın.$md$, $md$Rate limiting, bir istemcinin belirli sürede yapabileceği istek sayısını sınırlar. Amaç: kötüye kullanımı ve brute force'u önlemek, sistemi aşırı yükten korumak, kullanım planlarını (free/pro) uygulamak.

### Algoritmalar

**Fixed window:** her dakika için bir sayaç. Basit, ama pencere sınırında patlamaya izin verir (00:59'da 100, 01:00'da 100 istek = 1 saniyede 200).

**Sliding window log:** her isteğin zaman damgası saklanır, son 60 saniyedekiler sayılır. Kesin ama bellek maliyeti yüksek.

**Sliding window counter:** önceki ve mevcut pencere sayaçlarının ağırlıklı ortalaması. Az bellekle iyi yaklaşım:
`tahmini = mevcut + onceki * (pencerede kalan oran)`

**Token bucket:** kova sabit hızla token ile dolar (ör. saniyede 10), kapasitesi sınırlıdır (ör. 100). Her istek bir token harcar; token yoksa reddedilir. Kısa patlamalara (burst) izin verirken ortalama hızı sınırlar. AWS ve Stripe gibi birçok API bunu kullanır.

**Leaky bucket:** istekler kuyruğa girer ve sabit hızla işlenir; çıkışı düzleştirir.

### Dağıtık ortamda uygulama

Birden çok sunucu varsa sayaç paylaşılmalıdır; genelde **Redis** kullanılır. Yarış durumunu önlemek için işlem atomik olmalıdır:

```lua
-- Redis Lua: fixed window, atomik
local n = redis.call("INCR", KEYS[1])
if n == 1 then redis.call("EXPIRE", KEYS[1], ARGV[1]) end
return n
```

### API davranışı

- Limit aşılınca `429 Too Many Requests` ve `Retry-After` başlığı dönün.
- Kalan kotayı başlıklarla bildirin: `RateLimit-Limit`, `RateLimit-Remaining`, `RateLimit-Reset`.
- Anahtarı amaca göre seçin: API key, kullanıcı ID veya IP (login gibi uçlarda IP + kullanıcı adı).
- Katmanlı uygulayın: API gateway / Nginx seviyesinde kaba limit, uygulamada iş kuralına özel limit.$md$, $md$Tasarım sorusu olarak gelirse "tek sunucu mu, dağıtık mı?" diye netleştirin ve Redis tarafında INCR+EXPIRE işlemlerinin atomikliğini (Lua script veya MULTI) mutlaka belirtin.$md$, $md$hard$md$, $md$backend-developer$md$, $md$api-tasarimi$md$),
  ($md$oauth-2-0-nedir-authorization-code-pkce-ve-client-credentials-akislari-nasil-cal$md$, $md$OAuth 2.0 nedir? Authorization Code (PKCE) ve Client Credentials akışları nasıl çalışır?$md$, $md$OAuth 2.0 bir **yetkilendirme (authorization)** çerçevesidir: bir uygulamanın, kullanıcının şifresini öğrenmeden, kullanıcı adına sınırlı yetkiyle (scope) bir kaynağa erişmesini sağlar. Kimlik doğrulama (authentication) için üzerine **OpenID Connect** (OIDC) katmanı eklenir ve `id_token` döner.

### Roller

- **Resource Owner:** kullanıcı
- **Client:** erişim isteyen uygulama
- **Authorization Server:** token veren sunucu (Keycloak, Auth0, Google)
- **Resource Server:** korunan API

### Authorization Code + PKCE (kullanıcılı akış)

Web, SPA ve mobil uygulamalar için önerilen akıştır.

1. Client rastgele bir `code_verifier` üretir, bunun SHA-256 özetini `code_challenge` olarak hazırlar.
2. Kullanıcı authorization server'a yönlendirilir: `/authorize?response_type=code&client_id=...&redirect_uri=...&scope=read&state=xyz&code_challenge=...&code_challenge_method=S256`
3. Kullanıcı giriş yapıp onay verir; `redirect_uri`'ye kısa ömürlü bir `code` ve `state` döner.
4. Client `state`'i kontrol eder (CSRF koruması), `code` + `code_verifier` ile `/token` ucundan **access token** ve **refresh token** alır.
5. API çağrılarında `Authorization: Bearer <access_token>` kullanılır.

PKCE, yakalanan `code`'un başkası tarafından token'a çevrilmesini engeller; çünkü saldırgan `code_verifier`'ı bilmez.

### Client Credentials (makineden makineye)

Kullanıcı yoktur; servis kendi kimliğiyle token alır:

```http
POST /oauth/token
Content-Type: application/x-www-form-urlencoded

grant_type=client_credentials&client_id=fatura-servisi&client_secret=...&scope=orders.read
```

Mikroservisler arası ve cron işleri için kullanılır.

### Kullanılmaması gerekenler

- **Implicit flow:** token URL fragment'ında döner, sızmaya açıktır; OAuth 2.1 ile kaldırıldı.
- **Resource Owner Password:** client kullanıcının şifresini görür; OAuth'un amacına aykırıdır.

### Token pratikleri

Access token kısa ömürlü (5-15 dk), refresh token uzun ömürlü ve rotate edilerek kullanılır. Resource server token'ın imzasını, `exp`, `aud` ve `scope` alanlarını doğrulamalıdır.$md$, null, $md$hard$md$, $md$backend-developer$md$, $md$api-tasarimi$md$),
  ($md$commonjs-ile-es-modules-esm-arasindaki-fark-nedir$md$, $md$CommonJS ile ES Modules (ESM) arasındaki fark nedir?$md$, $md$Node.js iki modül sistemini destekler.

```js
// CommonJS
const fs = require("fs");
module.exports = { topla };

// ES Modules
import fs from "node:fs";
export function topla(a, b) { return a + b; }
```

| | CommonJS | ESM |
| --- | --- | --- |
| Söz dizimi | `require` / `module.exports` | `import` / `export` |
| Yükleme | Senkron, çalışma zamanında | Asenkron, önce statik analiz |
| Dinamik yükleme | `require(degisken)` her yerde | `await import(degisken)` |
| Top-level await | Yok | Var |
| `__dirname`, `__filename` | Var | Yok, `import.meta.dirname` (Node 20.11+) veya `import.meta.url` |
| Tree shaking | Zor | Kolay (statik yapı) |
| Dışa aktarılan değer | Kopya (o anki değer) | Canlı bağlantı (live binding) |

### Node.js bir dosyanın hangisi olduğuna nasıl karar verir?

- `.mjs` her zaman ESM, `.cjs` her zaman CommonJS.
- `.js` uzantısı için en yakın `package.json` içindeki `"type"` alanına bakılır: `"module"` ise ESM, yoksa veya `"commonjs"` ise CommonJS.

### Birlikte kullanım

- ESM içinden CommonJS modülü `import` edilebilir.
- CommonJS içinden ESM için `await import()` kullanılır; yeni Node sürümleri (22+) senkron ESM'i `require()` ile yüklemeyi de destekler.
- ESM'de göreli importlarda dosya uzantısı zorunludur: `import { x } from "./util.js"`.

Yeni projelerde standart olan ESM tercih edilir; CommonJS eski paketler ve mevcut kod tabanlarında hâlâ yaygındır.$md$, null, $md$easy$md$, $md$backend-developer$md$, $md$nodejs$md$),
  ($md$express-js-te-middleware-nedir-ve-nasil-calisir$md$, $md$Express.js'te middleware nedir ve nasıl çalışır?$md$, $md$Middleware, istek (`req`) ile yanıt (`res`) arasında sırayla çalışan fonksiyonlardır. Her biri isteği değiştirebilir, yanıtı bitirebilir ya da `next()` çağırarak sıradakine devredebilir. Kimlik doğrulama, loglama, body parsing, CORS, rate limiting gibi kesişen işler middleware ile yapılır.

```js
import express from "express";
const app = express();

// 1. Uygulama seviyesi: her istekte çalışır
app.use(express.json());

app.use((req, res, next) => {
  const bas = Date.now();
  res.on("finish", () => console.log(req.method, req.url, Date.now() - bas, "ms"));
  next();
});

// 2. Route seviyesi
function yetkiKontrol(req, res, next) {
  if (!req.headers.authorization) {
    return res.status(401).json({ hata: "Yetkisiz" });  // zinciri keser
  }
  req.kullanici = { id: 1 };
  next();
}

app.get("/profil", yetkiKontrol, (req, res) => res.json(req.kullanici));

// 3. Hata middleware'i: 4 parametre, en sonda tanımlanır
app.use((err, req, res, next) => {
  console.error(err);
  res.status(err.status || 500).json({ hata: "Sunucu hatası" });
});
```

### Önemli kurallar

- **Sıra önemlidir:** middleware'ler tanımlanma sırasıyla çalışır. `express.json()` route'lardan önce gelmelidir.
- Bir middleware ya yanıt göndermeli ya da `next()` çağırmalıdır; ikisini de yapmazsa istek **asılı kalır**.
- `next(err)` çağrısı normal middleware'leri atlayıp doğrudan hata middleware'ine gider.
- Hata middleware'i, Express tarafından **4 parametreli** olmasından tanınır.
- `express.Router()` ile middleware'ler belirli bir route grubuna uygulanabilir: `app.use("/admin", adminRouter)`.$md$, null, $md$easy$md$, $md$backend-developer$md$, $md$nodejs$md$),
  ($md$process-nexttick-promise-then-setimmediate-ve-settimeout-fn-0-hangi-sirayla-cali$md$, $md$process.nextTick, Promise.then, setImmediate ve setTimeout(fn, 0) hangi sırayla çalışır?$md$, $md$```js
console.log("1: senkron");

setTimeout(() => console.log("5: setTimeout"), 0);
setImmediate(() => console.log("6: setImmediate"));

Promise.resolve().then(() => console.log("4: promise"));
process.nextTick(() => console.log("3: nextTick"));

console.log("2: senkron");
```

Çıktı (ana modülde):

```
1: senkron
2: senkron
3: nextTick
4: promise
5: setTimeout
6: setImmediate
```

### Neden?

1. Önce tüm **senkron kod** çalışır.
2. Mevcut işlem biter bitmez **nextTick kuyruğu**, ardından **Promise (microtask) kuyruğu** boşaltılır. Bu iki kuyruk, event loop'un her aşama geçişinde ve her callback sonrasında tekrar kontrol edilir.
3. Sonra event loop aşamalarına geçilir: `setTimeout` **timers** aşamasında, `setImmediate` **check** aşamasında çalışır.

### setTimeout(0) mı, setImmediate mi önce?

- Ana modülden çağrıldığında sıra **garanti değildir**; loop'un başlama süresine bağlıdır (timeout en az 1 ms'dir).
- Bir **I/O callback'i içinden** çağrıldığında `setImmediate` **her zaman önce** çalışır, çünkü poll aşamasından sonra doğrudan check aşaması gelir.

```js
fs.readFile(__filename, () => {
  setTimeout(() => console.log("timeout"), 0);
  setImmediate(() => console.log("immediate")); // her zaman önce
});
```

### Pratik uyarı

`process.nextTick` özyinelemeli çağrılırsa event loop bir sonraki aşamaya hiç geçemez ve I/O **aç kalır** (starvation). Node dokümantasyonu çoğu durumda `setImmediate` veya `queueMicrotask` kullanılmasını önerir.$md$, $md$Bu soruda çıktıyı söyledikten sonra I/O callback'i içindeki setTimeout/setImmediate istisnasını kendiliğinden belirtmek, konuyu ezberlemediğinizi gösterir.$md$, $md$medium$md$, $md$backend-developer$md$, $md$nodejs$md$),
  ($md$node-js-te-stream-nedir-turleri-nelerdir-ve-backpressure-ne-demektir$md$, $md$Node.js'te stream nedir? Türleri nelerdir ve backpressure ne demektir?$md$, $md$Stream, veriyi tamamını belleğe almadan **parça parça (chunk)** işlemeyi sağlar. 5 GB'lık bir dosyayı `fs.readFile` ile okumak belleği doldurur; stream ile sabit ve küçük bellekle işlenir.

### Türler

- **Readable:** okunabilir kaynak (`fs.createReadStream`, HTTP isteği `req`)
- **Writable:** yazılabilir hedef (`fs.createWriteStream`, HTTP yanıtı `res`)
- **Duplex:** iki yönlü (TCP socket)
- **Transform:** okurken veriyi dönüştüren duplex (`zlib.createGzip`, şifreleme)

### Örnek: dosyayı sıkıştırarak HTTP yanıtı olarak göndermek

```js
import { createReadStream } from "node:fs";
import { createGzip } from "node:zlib";
import { pipeline } from "node:stream/promises";

app.get("/rapor", async (req, res, next) => {
  res.setHeader("Content-Encoding", "gzip");
  try {
    await pipeline(createReadStream("./buyuk-rapor.csv"), createGzip(), res);
  } catch (err) {
    next(err);
  }
});
```

### Backpressure

Okuma tarafı, yazma tarafından hızlıysa (ör. disk hızlı, istemcinin ağı yavaş) veriler bellekte birikir. Backpressure bu durumu yönetme mekanizmasıdır:

- `writable.write(chunk)` iç tampon `highWaterMark` sınırını aşınca `false` döner.
- Üretici bu durumda durmalı ve `drain` olayını beklemelidir.

`pipe()` ve `pipeline()` bunu otomatik yapar. Elle `on("data")` ile yazıp `write()` dönüşünü yok saymak bellek sızıntısına benzer şişmeye yol açar.

### Neden pipeline?

`a.pipe(b).pipe(c)` zincirinde bir stream hata verirse diğerleri kapatılmaz ve hata yayılmaz. `stream.pipeline` hataları tek yerde toplar ve tüm stream'leri düzgünce kapatır.

Readable stream'ler async iterable'dır: `for await (const chunk of stream) { ... }` ile de tüketilebilir.$md$, null, $md$medium$md$, $md$backend-developer$md$, $md$nodejs$md$),
  ($md$node-js-te-asenkron-kodda-hata-yonetimi-nasil-yapilir-unhandledrejection-nedir$md$, $md$Node.js'te asenkron kodda hata yönetimi nasıl yapılır? unhandledRejection nedir?$md$, $md$### Callback, Promise ve async/await

```js
// Callback: hata ilk parametredir (error-first)
fs.readFile("a.txt", (err, data) => {
  if (err) return console.error(err);
});

// Promise
getir().then(isle).catch(err => console.error(err));

// async/await: try/catch
async function siparisOlustur(veri) {
  try {
    const kullanici = await db.kullaniciBul(veri.kullaniciId);
    return await db.siparisEkle(kullanici, veri);
  } catch (err) {
    throw new SiparisHatasi("Sipariş oluşturulamadı", { cause: err });
  }
}
```

### Sık yapılan hatalar

1. **`await` unutmak:** `try { db.kaydet() } catch {}` hatayı yakalamaz; çünkü Promise reddi try bloğu bittikten sonra olur.
2. **Callback içinde throw:** `setTimeout(() => { throw err })` dıştaki try/catch tarafından yakalanmaz.
3. **forEach ile async:** `arr.forEach(async x => await f(x))` beklenmez ve hataları kaybolur. `for...of` veya `Promise.all` kullanın.
4. **Express 4'te async route:** reddedilen Promise hata middleware'ine ulaşmaz. `try/catch` + `next(err)` ya da bir sarmalayıcı gerekir. Express 5 bunu otomatik yapar.

```js
const asyncHandler = fn => (req, res, next) =>
  Promise.resolve(fn(req, res, next)).catch(next);
```

### Global yakalayıcılar

```js
process.on("unhandledRejection", (reason) => {
  logger.error({ reason }, "Yakalanmamış promise reddi");
  process.exit(1);
});

process.on("uncaughtException", (err) => {
  logger.fatal(err);
  process.exit(1);
});
```

Node 15+ yakalanmamış Promise reddinde süreci varsayılan olarak sonlandırır. Bu yakalayıcılar hatayı "kurtarmak" için değil, **loglayıp düzgünce kapanmak** içindir; uygulama belirsiz durumda kalmasın diye süreç yeniden başlatılır (PM2, Kubernetes).

### Operasyonel ve programcı hataları

Operasyonel hatalar (timeout, bulunamayan kayıt, geçersiz girdi) beklenir ve ele alınır. Programcı hataları (undefined okuma, bug) düzeltilmesi gereken kusurlardır; bunlarda süreci yeniden başlatmak daha güvenlidir.$md$, null, $md$medium$md$, $md$backend-developer$md$, $md$nodejs$md$),
  ($md$node-js-event-loop-u-nasil-calisir-libuv-nin-rolu-ve-event-loop-asamalari-nelerd$md$, $md$Node.js event loop'u nasıl çalışır? libuv'nin rolü ve event loop aşamaları nelerdir?$md$, $md$Node.js JavaScript'i **tek bir thread**'de çalıştırır, ama I/O işlemlerini engellemeden (non-blocking) yürütür. Bunu, C ile yazılmış **libuv** kütüphanesi sağlar.

### libuv ne yapar?

- Ağ I/O'su için işletim sisteminin asenkron mekanizmalarını kullanır (Linux'ta epoll, macOS'ta kqueue, Windows'ta IOCP). Burada ek thread gerekmez.
- İşletim sisteminin asenkron desteği olmayan işleri **thread pool**'da yürütür (varsayılan 4 thread, `UV_THREADPOOL_SIZE`): dosya sistemi (`fs`), `dns.lookup`, `crypto.pbkdf2`, `zlib`.
- İş bitince callback'i event loop'un ilgili kuyruğuna koyar.

### Event loop aşamaları

1. **timers:** süresi dolmuş `setTimeout` / `setInterval` callback'leri
2. **pending callbacks:** bir önceki turdan ertelenen bazı sistem callback'leri (ör. TCP hataları)
3. **idle, prepare:** iç kullanım
4. **poll:** yeni I/O olaylarını alır ve callback'lerini çalıştırır; yapılacak iş yoksa burada bekler
5. **check:** `setImmediate` callback'leri
6. **close callbacks:** `socket.on("close")` gibi kapanış callback'leri

Her callback'ten sonra `process.nextTick` kuyruğu, ardından Promise microtask kuyruğu tamamen boşaltılır.

### Pratik sonuç: event loop'u bloklamayın

Tek thread olduğu için uzun süren senkron bir işlem **tüm istekleri** durdurur:

```js
app.get("/rapor", (req, res) => {
  const sonuc = agirHesap();   // 2 saniye CPU: bu sürede hiçbir istek yanıtlanmaz
  res.json(sonuc);
});
```

Bloklayan örnekler: büyük `JSON.parse`/`stringify`, senkron `fs.*Sync` çağrıları, `crypto.pbkdf2Sync`, felaketsel backtracking yapan regex (ReDoS), büyük dizilerde yoğun döngüler.

Çözümler: işi parçalara bölmek, `worker_threads`, iş kuyruğu (BullMQ) ile ayrı worker'lara taşımak.

### Teşhis

`perf_hooks.monitorEventLoopDelay()` ile event loop gecikmesi ölçülür; `clinic.js` veya `--cpu-prof` ile bloklayan fonksiyon bulunur.$md$, $md$Thread pool'un yalnızca belirli işler için kullanıldığını (fs, dns.lookup, crypto, zlib) ve ağ soketlerinin thread pool kullanmadığını söylemek sık beklenen bir ayrıntıdır.$md$, $md$hard$md$, $md$backend-developer$md$, $md$nodejs$md$),
  ($md$cluster-modulu-ile-worker-threads-arasindaki-fark-nedir-hangisini-ne-zaman-kulla$md$, $md$cluster modülü ile worker_threads arasındaki fark nedir? Hangisini ne zaman kullanırsınız?$md$, $md$Bir Node.js süreci JavaScript'i tek çekirdekte çalıştırır. Birden çok çekirdeği kullanmanın iki yerleşik yolu vardır.

### cluster

Aynı uygulamanın birden çok **ayrı sürecini (process)** başlatır. Hepsi aynı portu paylaşır; ana süreç gelen bağlantıları worker'lara dağıtır (Linux'ta varsayılan round-robin).

```js
import cluster from "node:cluster";
import os from "node:os";
import http from "node:http";

if (cluster.isPrimary) {
  for (let i = 0; i < os.availableParallelism(); i++) cluster.fork();
  cluster.on("exit", () => cluster.fork());   // çöken worker'ı yenile
} else {
  http.createServer((req, res) => res.end(`pid ${process.pid}`)).listen(3000);
}
```

### worker_threads

Aynı süreç içinde ayrı **thread**'ler açar. Her thread'in kendi V8 isolate'i ve event loop'u vardır; veri `postMessage` ile kopyalanarak, ya da `SharedArrayBuffer` ile paylaşılarak aktarılır.

```js
import { Worker } from "node:worker_threads";

function hashHesapla(veri) {
  return new Promise((resolve, reject) => {
    const w = new Worker("./hash-worker.js", { workerData: veri });
    w.once("message", resolve);
    w.once("error", reject);
  });
}
```

### Karşılaştırma

| | cluster | worker_threads |
| --- | --- | --- |
| Birim | Ayrı süreç | Aynı süreçte thread |
| Bellek | Her süreç ayrı, yüksek | Daha düşük, paylaşım mümkün |
| İzolasyon | Tam: biri çökerse diğerleri yaşar | Kısmi |
| İletişim | IPC (yavaş, serialize) | postMessage, SharedArrayBuffer |
| Amaç | HTTP throughput'unu çekirdeklere yaymak | CPU-yoğun işi ana thread'den almak |

### Ne zaman hangisi?

- **cluster:** I/O ağırlıklı bir web sunucusunu tüm çekirdeklere yaymak. Ancak container ortamında genelde cluster yerine Kubernetes'te **birden çok pod/replica** çalıştırmak ve PM2 gibi araçlar tercih edilir.
- **worker_threads:** görüntü işleme, PDF üretimi, büyük JSON dönüşümü, şifreleme gibi CPU-bound işler. Her istekte yeni Worker açmak pahalıdır; **worker pool** (ör. `piscina`) kullanın.

Her iki durumda da süreçler/thread'ler bellek paylaşmadığından session ve cache gibi durumlar Redis gibi harici bir yerde tutulmalıdır.$md$, null, $md$hard$md$, $md$backend-developer$md$, $md$nodejs$md$),
  ($md$container-ile-sanal-makine-vm-arasindaki-fark-nedir$md$, $md$Container ile sanal makine (VM) arasındaki fark nedir?$md$, $md$| | Container | Sanal makine |
| --- | --- | --- |
| Sanallaştırma seviyesi | İşletim sistemi (çekirdek paylaşılır) | Donanım (hypervisor) |
| İçerdiği | Uygulama + bağımlılıklar | Tam bir işletim sistemi + uygulama |
| Boyut | MB seviyesi | GB seviyesi |
| Açılış süresi | Saniye altı / saniyeler | Dakikalar |
| İzolasyon | Süreç seviyesi, daha zayıf | Güçlü, ayrı çekirdek |
| Farklı işletim sistemi | Hayır, host çekirdeği kullanılır | Evet (Linux üstünde Windows) |

### Container nasıl izole edilir?

Container aslında host üzerinde çalışan, Linux çekirdek özellikleriyle sınırlandırılmış bir süreçtir:

- **Namespaces:** sürecin gördüğü dünyayı ayırır (PID, network, mount, user, hostname).
- **cgroups:** CPU, bellek, I/O kullanımını sınırlar.
- **Union filesystem (OverlayFS):** image katmanlarını üst üste bindirir; katmanlar container'lar arasında paylaşılır.

### Temel Docker kavramları

- **Image:** salt okunur şablon (sınıf gibi).
- **Container:** image'ın çalışan örneği (nesne gibi). Üzerine yazılabilir ince bir katman eklenir; container silinince bu katman da gider. Kalıcı veri için **volume** kullanılır.
- **Registry:** image deposu (Docker Hub, GHCR, ECR).

### Ne zaman hangisi?

Container: mikroservisler, CI ortamları, "benim makinemde çalışıyordu" sorununu ortadan kaldırmak, hızlı ölçekleme. VM: güçlü izolasyon gereken çok kiracılı ortamlar, farklı işletim sistemi ihtiyacı. Pratikte ikisi birlikte kullanılır: bulutta container'lar genellikle VM'lerin üzerinde çalışır.

macOS ve Windows'ta Docker Desktop, Linux çekirdeği için arka planda hafif bir VM çalıştırır.$md$, null, $md$easy$md$, $md$backend-developer$md$, $md$docker-devops$md$),
  ($md$docker-compose-ne-ise-yarar-basit-bir-ornekle-aciklayin$md$, $md$Docker Compose ne işe yarar? Basit bir örnekle açıklayın.$md$, $md$Docker Compose, birden çok container'dan oluşan bir uygulamayı tek bir YAML dosyasıyla tanımlayıp tek komutla ayağa kaldırmayı sağlar. Özellikle **lokal geliştirme** ve test ortamlarında kullanılır.

```yaml
# compose.yaml
services:
  api:
    build: .
    ports:
      - "3000:3000"
    environment:
      DATABASE_URL: postgres://app:secret@db:5432/app
      REDIS_URL: redis://cache:6379
    depends_on:
      db:
        condition: service_healthy
    volumes:
      - ./src:/app/src        # kod değişikliği anında yansısın

  db:
    image: postgres:16
    environment:
      POSTGRES_USER: app
      POSTGRES_PASSWORD: secret
      POSTGRES_DB: app
    volumes:
      - pgdata:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U app"]
      interval: 5s
      retries: 5

  cache:
    image: redis:7

volumes:
  pgdata:
```

### Temel komutlar

- `docker compose up -d`: tüm servisleri arka planda başlatır
- `docker compose logs -f api`: logları izler
- `docker compose exec db psql -U app`: çalışan container'da komut çalıştırır
- `docker compose down`: durdurur ve siler (`-v` ile volume'ları da siler)

### Önemli noktalar

- Compose tüm servisler için ortak bir ağ kurar; servisler birbirine **servis adıyla** erişir (`db:5432`). Container içinden `localhost` kendi container'ını gösterir.
- `depends_on` tek başına yalnızca başlama sırasını belirler, servisin **hazır** olmasını beklemez. Hazır olmayı beklemek için `healthcheck` + `condition: service_healthy` gerekir.
- Adlandırılmış volume (`pgdata`) container silinse de veriyi korur.

Production'da çok sunuculu orkestrasyon için genellikle Kubernetes veya yönetilen servisler (ECS, Cloud Run) tercih edilir.$md$, null, $md$easy$md$, $md$backend-developer$md$, $md$docker-devops$md$),
  ($md$iyi-bir-dockerfile-nasil-yazilir-multi-stage-build-ne-ise-yarar$md$, $md$İyi bir Dockerfile nasıl yazılır? Multi-stage build ne işe yarar?$md$, $md$### Örnek: Node.js için multi-stage Dockerfile

```dockerfile
# 1. aşama: bağımlılıklar ve build
FROM node:20-alpine AS build
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci
COPY . .
RUN npm run build && npm prune --omit=dev

# 2. aşama: yalnızca çalışma zamanı
FROM node:20-alpine
WORKDIR /app
ENV NODE_ENV=production
COPY --from=build --chown=node:node /app/node_modules ./node_modules
COPY --from=build --chown=node:node /app/dist ./dist
USER node
EXPOSE 3000
CMD ["node", "dist/server.js"]
```

**Multi-stage build**, derleyici, dev bağımlılıkları ve kaynak kodu gibi yalnızca build sırasında gereken her şeyi ilk aşamada bırakır. Son image yalnızca çalışması gerekenleri içerir: daha küçük boyut, daha hızlı dağıtım, daha az güvenlik açığı yüzeyi. Go gibi derlenen dillerde son aşama `distroless` veya `scratch` olabilir.

### Best practice'ler

1. **Layer cache'i doğru kullanın:** az değişen dosyaları önce kopyalayın. Önce `package.json` kopyalanıp `npm ci` çalıştırılır; böylece yalnızca kod değiştiğinde bağımlılıklar yeniden kurulmaz.
2. **Küçük ve sabit base image:** `node:20-alpine` veya `-slim`; `latest` etiketi yerine sürüm belirtin.
3. **`.dockerignore`:** `node_modules`, `.git`, `.env`, test çıktıları image'a girmesin.
4. **Root olarak çalıştırmayın:** `USER node` veya kendi oluşturduğunuz kullanıcı.
5. **RUN komutlarını birleştirin** ve aynı katmanda temizlik yapın: `apt-get update && apt-get install -y x && rm -rf /var/lib/apt/lists/*`
6. **Secret'ları image'a gömmeyin:** `ENV API_KEY=...` veya `COPY .env` image geçmişinde kalır. Build sırasında gerekiyorsa `RUN --mount=type=secret` kullanın.
7. **Exec form CMD:** `CMD ["node", "server.js"]`. Shell form (`CMD node server.js`) sinyalleri sürece iletmez; `docker stop` sonrası graceful shutdown çalışmaz.
8. Image'ları `docker scout` veya `trivy` ile güvenlik açıklarına karşı tarayın.$md$, $md$Mülakatta layer cache sırasını (önce manifest, sonra install, sonra kod) somut olarak anlatmak ve bunun build süresine etkisini belirtmek en çok puan getiren kısımdır.$md$, $md$medium$md$, $md$backend-developer$md$, $md$docker-devops$md$),
  ($md$ci-cd-nedir-tipik-bir-backend-ci-cd-pipeline-inin-asamalari-nelerdir$md$, $md$CI/CD nedir? Tipik bir backend CI/CD pipeline'ının aşamaları nelerdir?$md$, $md$- **Continuous Integration (CI):** her commit/PR'da kodun otomatik olarak derlenmesi ve test edilmesi. Amaç hataları erken yakalamak, ana dalı her zaman çalışır tutmak.
- **Continuous Delivery:** her değişiklik production'a çıkmaya hazır bir artefakt üretir; yayın tek tıkla (onaylı) yapılır.
- **Continuous Deployment:** testleri geçen her değişiklik insan onayı olmadan otomatik production'a çıkar.

### Tipik pipeline

1. **Checkout + bağımlılık kurulumu** (cache ile hızlandırılır)
2. **Lint ve statik analiz** (ESLint, ruff, tip kontrolü)
3. **Unit testler**
4. **Integration testler** (gerçek PostgreSQL/Redis container'ları ile)
5. **Güvenlik taramaları** (bağımlılık açıkları, secret taraması)
6. **Docker image build** ve commit SHA ile etiketleyip registry'ye push
7. **Staging'e deploy** + veritabanı migration'ları + smoke test
8. **Production'a deploy** (onaylı veya otomatik)
9. **Deploy sonrası izleme** ve gerekirse geri alma (rollback)

```yaml
# .github/workflows/ci.yml (GitHub Actions)
name: ci
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    services:
      postgres:
        image: postgres:16
        env: { POSTGRES_PASSWORD: test }
        ports: ["5432:5432"]
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with: { node-version: 20, cache: npm }
      - run: npm ci
      - run: npm run lint
      - run: npm test
```

### Deployment stratejileri

| Strateji | Nasıl çalışır | Not |
| --- | --- | --- |
| Rolling | Instance'lar tek tek yenilenir | Varsayılan, ek kaynak az |
| Blue-green | Yeni ortam hazırlanır, trafik bir anda geçirilir | Anında rollback, iki kat kaynak |
| Canary | Trafiğin küçük yüzdesi yeni sürüme yönlendirilir | Riski azaltır, iyi metrik gerektirir |

Veritabanı migration'ları geriye uyumlu yazılmalıdır (expand/contract): önce yeni sütunu ekle, kodu güncelle, eski sütunu sonraki sürümde kaldır. Böylece rolling deploy sırasında eski ve yeni kod aynı şemayla çalışabilir.$md$, null, $md$medium$md$, $md$backend-developer$md$, $md$docker-devops$md$),
  ($md$ortam-degiskenleri-ve-secret-lar-sifre-api-anahtari-guvenli-sekilde-nasil-yoneti$md$, $md$Ortam değişkenleri ve secret'lar (şifre, API anahtarı) güvenli şekilde nasıl yönetilir?$md$, $md$**12-Factor App** prensibine göre yapılandırma koddan ayrılmalı ve ortama göre (dev, staging, prod) değişmelidir. Aynı image her ortamda çalışır; yalnızca yapılandırma farklıdır.

### Ortam değişkenleri

```js
// config.js: uygulama açılışında doğrula, eksikse hemen çök
import { z } from "zod";

const schema = z.object({
  DATABASE_URL: z.string().url(),
  PORT: z.coerce.number().default(3000),
  JWT_SECRET: z.string().min(32),
});

export const config = schema.parse(process.env);
```

Yapılandırmayı tek bir modülde toplayıp açılışta doğrulamak, eksik değişken yüzünden saatler sonra ortaya çıkan hataları önler.

### Yapılmaması gerekenler

- Secret'ları git'e commit etmek (`.env` dosyası `.gitignore`'da olmalı; repoda yalnızca örnek `.env.example` bulunur).
- Dockerfile'da `ENV` ile veya image'a kopyalayarak secret gömmek.
- Secret'ları loglamak (hata mesajları, istek dökümleri, `console.log(config)`).
- Tüm ortamlarda aynı secret'ı kullanmak.

### Doğru yaklaşım

1. **Secret yöneticisi:** HashiCorp Vault, AWS Secrets Manager, GCP Secret Manager, Azure Key Vault. Secret'lar merkezi, şifreli, erişim kontrollü ve denetim kaydıyla tutulur.
2. **Kubernetes:** `Secret` nesneleri (varsayılan olarak yalnızca base64 kodludur, etcd şifrelemesi açılmalı) veya External Secrets Operator ile bulut secret yöneticisinden çekme.
3. **CI/CD:** platformun şifreli secret deposu (GitHub Actions secrets); mümkünse statik anahtar yerine OIDC ile kısa ömürlü bulut kimlikleri.
4. **En az yetki:** her servis yalnızca kendi ihtiyacı olan secret'a erişsin.
5. **Rotasyon:** secret'lar düzenli ve sızıntı şüphesinde hemen değiştirilebilmelidir; dinamik, kısa ömürlü veritabanı kimlik bilgileri ideal çözümdür.
6. **Tarama:** gitleaks veya GitHub secret scanning ile yanlışlıkla commit edilen secret'ları yakalayın.

Git geçmişine giren bir secret, commit silinse bile **sızmış kabul edilir** ve hemen rotate edilmelidir.$md$, null, $md$medium$md$, $md$backend-developer$md$, $md$docker-devops$md$),
  ($md$load-balancer-nedir-yuk-dagitim-algoritmalari-nelerdir$md$, $md$Load balancer nedir? Yük dağıtım algoritmaları nelerdir?$md$, $md$Load balancer, gelen trafiği birden çok sunucuya dağıtarak yatay ölçeklemeyi ve yüksek erişilebilirliği sağlar. Sağlıksız sunucuları **health check** ile tespit edip trafiği onlardan çeker.

### Katmanlar

- **L4 (transport):** IP ve port seviyesinde, içeriğe bakmadan dağıtır. Çok hızlıdır (AWS NLB).
- **L7 (application):** HTTP seviyesinde; URL, header, cookie'ye göre yönlendirebilir, TLS sonlandırma yapabilir (Nginx, HAProxy, AWS ALB).

### Algoritmalar

| Algoritma | Nasıl çalışır | Uygun durum |
| --- | --- | --- |
| Round robin | Sunuculara sırayla dağıtır | Eş güçte sunucular, benzer istekler |
| Weighted round robin | Güçlü sunucuya daha çok istek | Farklı kapasitede sunucular, canary |
| Least connections | En az aktif bağlantısı olana | Süresi değişken istekler, WebSocket |
| Least response time | En hızlı yanıt verene | Gecikmeye duyarlı servisler |
| IP hash | İstemci IP'sinin hash'ine göre | Basit oturum yapışkanlığı |
| Consistent hashing | Anahtar halka üzerinde sunucuya eşlenir | Cache sunucuları; sunucu eklenince az anahtar yer değiştirir |
| Random / power of two choices | Rastgele iki sunucu seçip daha az yüklüsü | Büyük, dağıtık sistemler |

### Sticky session

Aynı kullanıcıyı hep aynı sunucuya göndermektir (cookie veya IP hash). Sunucu belleğinde oturum tutuluyorsa gerekir; ama dengesiz yük oluşturur ve sunucu düşünce oturumlar kaybolur. Daha iyi çözüm, sunucuları **stateless** yapıp oturumu Redis'te veya JWT'de tutmaktır.

### Load balancer'ın kendisi tek hata noktası mı?

Evet olabilir; bu yüzden aktif-pasif çift kurulum (keepalived ile sanal IP), DNS seviyesinde birden çok LB veya bulutun yönetilen, kendinden yedekli load balancer'ları kullanılır.$md$, null, $md$medium$md$, $md$backend-developer$md$, $md$sistem-tasarimi$md$),
  ($md$cap-teoremi-nedir-gercek-sistemlerde-nasil-yorumlanir$md$, $md$CAP teoremi nedir? Gerçek sistemlerde nasıl yorumlanır?$md$, $md$CAP teoremine göre dağıtık bir veri sistemi, bir **ağ bölünmesi (network partition)** sırasında aşağıdaki iki özellikten yalnızca birini garanti edebilir:

- **Consistency (C):** her okuma en son yazılan değeri döner (linearizability) ya da hata verir.
- **Availability (A):** çalışan her düğüm her isteğe (hata olmadan) yanıt verir.
- **Partition tolerance (P):** düğümler arası mesajlar kaybolsa da sistem çalışmaya devam eder.

### Yaygın yanılgı: "3'ten 2'sini seç"

Dağıtık sistemde ağ bölünmesi kaçınılmazdır, yani **P bir seçenek değildir**. Asıl soru şudur: bölünme olduğunda sistem ne yapar?

- **CP:** tutarsız veri döndürmektense bazı istekleri reddeder. Örnek: ZooKeeper, etcd, çoğunluk (quorum) gerektiren HBase. Kullanım: lider seçimi, kilitler, finansal kayıtlar.
- **AP:** yanıt vermeye devam eder ama veri eski olabilir; bölünme bitince düğümler uzlaşır (eventual consistency). Örnek: Cassandra, DynamoDB (varsayılan ayarlarla), DNS. Kullanım: sepet, beğeni sayısı, sosyal akış.

Bölünme yokken C ve A birlikte sağlanabilir.

### PACELC: daha gerçekçi bir model

**P**artition varsa **A** ile **C** arasında seç; **E**lse (normal durumda) **L**atency ile **C** arasında seç. Bölünme olmasa da güçlü tutarlılık, replikalar arası senkron koordinasyon gerektirdiği için gecikmeyi artırır.

### Ayarlanabilir tutarlılık

Cassandra ve DynamoDB'de tutarlılık istek bazında seçilebilir. N replika için okuma (R) ve yazma (W) quorum'ları `R + W > N` olacak şekilde seçilirse (ör. N=3, W=2, R=2) okumalar en son yazmayı görür.

### Mülakatta nasıl kullanılır?

Sistemi tek etiketle (CP/AP) değil, **her veri türü için** değerlendirin: bir e-ticaret sisteminde ödeme ve stok rezervasyonu tutarlılık ister; ürün yorumları ve öneri listesi eventual consistency ile sorunsuz çalışır.$md$, $md$CAP'teki "Consistency"nin ACID'deki "Consistency" ile aynı şey olmadığını (biri replikalar arası güncellik, diğeri kısıtların korunması) belirtmek iyi bir artı puandır.$md$, $md$hard$md$, $md$backend-developer$md$, $md$sistem-tasarimi$md$),
  ($md$monolith-ile-mikroservis-mimarisi-arasindaki-fark-nedir-mikroservislere-ne-zaman$md$, $md$Monolith ile mikroservis mimarisi arasındaki fark nedir? Mikroservislere ne zaman geçilmeli?$md$, $md$- **Monolith:** uygulamanın tüm modülleri tek bir kod tabanı ve tek bir deploy birimi olarak çalışır, genellikle tek veritabanı kullanır.
- **Mikroservis:** uygulama, iş alanlarına (bounded context) göre ayrılmış, bağımsız deploy edilen, **kendi verisine sahip** küçük servislerden oluşur. Servisler ağ üzerinden (REST, gRPC, mesaj kuyruğu) haberleşir.

| | Monolith | Mikroservis |
| --- | --- | --- |
| Geliştirme başlangıcı | Hızlı ve basit | Yavaş, altyapı yükü yüksek |
| Deploy | Tek parça, hepsi birlikte | Servis bazında bağımsız |
| Ölçekleme | Tüm uygulama birlikte | Yalnızca ihtiyaç duyan servis |
| Veri tutarlılığı | Tek DB, ACID transaction | Dağıtık; saga, eventual consistency |
| Hata ayıklama | Tek süreç, kolay | Distributed tracing gerekir |
| Ekip yapısı | Küçük-orta ekipler | Çok sayıda bağımsız ekip |
| Teknoloji çeşitliliği | Tek stack | Servis başına farklı olabilir |

### Mikroservislerin gizli maliyetleri

- Ağ gecikmesi ve kısmi hatalar: timeout, retry, circuit breaker gerekir.
- Servisler arası transaction yoktur; **saga pattern** ve telafi (compensation) işlemleri yazılır.
- Gözlemlenebilirlik: merkezi log, metrik, trace (OpenTelemetry).
- Servis keşfi, API gateway, CI/CD ve container orkestrasyonu (Kubernetes) gerektirir.
- Ortak veritabanını paylaşan servisler "dağıtık monolith" oluşturur: iki mimarinin dezavantajlarını birleştirir.

### Ne zaman geçilmeli?

Mikroservis bir **organizasyonel ölçekleme** çözümüdür. Mantıklı olduğu sinyaller:
- Çok sayıda ekip aynı kod tabanında birbirini bloke ediyor, deploy'lar kuyruğa giriyor.
- Belirli modüllerin ölçekleme veya güvenilirlik ihtiyacı belirgin şekilde farklı.
- Domain sınırları netleşmiş.

Çoğu yeni proje için önerilen yol **modüler monolith**'tir: tek deploy birimi, ama sınırları net modüller ve modüller arası yalnızca tanımlı arayüzler. Gerektiğinde bir modül **strangler fig** yaklaşımıyla parça parça ayrı servise çıkarılır.$md$, $md$"Her zaman mikroservis" demek kırmızı bayraktır. Kararı ekip büyüklüğü, domain olgunluğu ve operasyonel kapasiteye bağlayarak anlatın.$md$, $md$hard$md$, $md$backend-developer$md$, $md$sistem-tasarimi$md$),
  ($md$c-de-pointer-aritmetigi-nasil-calisir-ptr-1-ifadesi-adresi-kac-byte-ilerletir$md$, $md$C'de pointer aritmetiği nasıl çalışır? ptr + 1 ifadesi adresi kaç byte ilerletir?$md$, $md$Pointer'a bir tamsayı eklemek adresi **byte olarak değil, işaret ettiği tipin boyutu kadar** ilerletir: `ptr + n` adresi `n * sizeof(*ptr)` byte kaydırır.

```c
uint8_t  a8[4];
uint32_t a32[4];

uint8_t  *p8  = a8;    /* 0x2000 varsayalım */
uint32_t *p32 = a32;   /* 0x3000 varsayalım */

p8  + 1;   /* 0x2001 */
p32 + 1;   /* 0x3004 */

/* Dizi erişimi aslında pointer aritmetiğidir */
a32[2] == *(a32 + 2);

/* İki pointer farkı eleman sayısını verir (ptrdiff_t) */
ptrdiff_t n = &a32[3] - &a32[0];   /* 3 */
```

### Gömülü sistemlerde tipik kullanım

```c
/* Bellek eşlemeli register erişimi */
#define GPIOA_BASE  0x40020000UL
#define GPIOA_ODR   (*(volatile uint32_t *)(GPIOA_BASE + 0x14))

GPIOA_ODR |= (1U << 5);   /* PA5 = 1 */
```

Burada önce sayıya offset eklenir, sonra pointer'a cast edilir. Sırayı ters yapmak (`(uint32_t *)GPIOA_BASE + 0x14`) adresi `0x14 * 4` byte kaydırır; klasik bir hatadır.

### Dikkat edilmesi gerekenler

- `void *` üzerinde aritmetik standart C'de **tanımsızdır** (GCC uzantı olarak 1 byte kabul eder).
- Dizi sınırının dışına çıkan pointer (sondan bir sonrası hariç) **undefined behavior**'dır.
- Farklı tipe cast edip okumak **strict aliasing** kuralını ihlal edebilir; byte bazlı erişim için `uint8_t *` veya `memcpy` kullanın.
- Hizalanmamış adresten `uint32_t` okumak Cortex-M0 gibi çekirdeklerde **HardFault** üretir.
- Donanım register'ları için pointer mutlaka `volatile` olmalıdır.$md$, $md$Register makrosunu cast sırası hatasıyla birlikte anlatmak, gerçek donanım kodu yazdığınızı gösterir.$md$, $md$easy$md$, $md$embedded-engineer$md$, $md$c-programlama$md$),
  ($md$const-int-p-int-const-p-ve-const-int-const-p-arasindaki-fark-nedir$md$, $md$const int *p, int * const p ve const int * const p arasındaki fark nedir?$md$, $md$Kural: **`const` solundaki şeye uygulanır**; solunda bir şey yoksa sağındakine. Bildirimi sağdan sola okumak işi kolaylaştırır.

| Bildirim | Okunuşu | Veri değişir mi? | Pointer değişir mi? |
| --- | --- | --- | --- |
| `const int *p` | p, const int'e pointer | Hayır | Evet |
| `int const *p` | Yukarıdakiyle aynı | Hayır | Evet |
| `int * const p` | p, int'e const pointer | Evet | Hayır |
| `const int * const p` | const int'e const pointer | Hayır | Hayır |

```c
int a = 1, b = 2;

const int *p1 = &a;
/* *p1 = 5;   HATA */
p1 = &b;      /* OK */

int * const p2 = &a;
*p2 = 5;      /* OK */
/* p2 = &b;   HATA */

const int * const p3 = &a;   /* ikisi de yasak */
```

### Gömülü sistemlerde neden önemli?

- **Fonksiyon sözleşmesi:** `void send(const uint8_t *buf, size_t len)` fonksiyonun tamponu değiştirmeyeceğini garanti eder ve string literal geçirilebilir.
- **Flash'a yerleşim:** `const` global tablolar (lookup table, font) genelde `.rodata` bölümüne, yani **Flash**'a konur ve değerli RAM harcamaz.

```c
static const uint16_t sine_lut[256] = { /* ... */ };
```

- **Register tanımları:** Sabit adresli ama içeriği değişen register için `volatile uint32_t * const REG`. Salt okunur bir durum register'ı için `const volatile uint32_t *`; yazılım değiştiremez, donanım değiştirebilir.

`const volatile` birlikte kullanılabilir ve çelişkili değildir: "**ben** değiştirmem ama **değer** değişebilir".$md$, null, $md$easy$md$, $md$embedded-engineer$md$, $md$c-programlama$md$),
  ($md$c-de-static-anahtar-kelimesinin-farkli-kullanimlari-nelerdir$md$, $md$C'de static anahtar kelimesinin farklı kullanımları nelerdir?$md$, $md$`static` kullanıldığı yere göre iki farklı şeyi değiştirir: **ömür (storage duration)** ve **görünürlük (linkage)**.

### 1. Fonksiyon içindeki yerel değişken

Değişken stack'te değil, `.data`/`.bss` bölümünde yaşar; değeri çağrılar arasında korunur. İlk değer ataması **bir kez**, program başlarken yapılır.

```c
uint32_t next_id(void) {
    static uint32_t id = 0;
    return ++id;
}
```

### 2. Dosya kapsamındaki global değişken

**Internal linkage** verir: değişken yalnızca o `.c` dosyasından görülebilir. Modüller arası isim çakışmasını ve istenmeyen erişimi önler; C'de "private" kapsülleme budur.

```c
static uint8_t rx_buf[64];   /* sadece uart.c görür */
```

### 3. Fonksiyon

Fonksiyonu dosyaya özel yapar. Derleyici fonksiyonun başka yerden çağrılmadığını bildiği için agresif **inline** yapabilir veya kullanılmıyorsa tamamen silebilir.

```c
static void uart_flush(void) { /* ... */ }
```

### 4. Dizi parametresinde (C99)

Çağıranın en az N elemanlık geçerli bir dizi geçireceğini belirtir; optimizasyon ipucudur.

```c
void crc(const uint8_t data[static 4]);
```

### Gömülü sistemlerde dikkat

- Fonksiyon içi `static` değişken **reentrant değildir**: aynı fonksiyon hem ISR'dan hem ana döngüden veya iki RTOS task'ından çağrılırsa yarış oluşur.
- Büyük tamponları fonksiyon içinde `static` yapmak stack taşmasını önler ama RAM'i kalıcı olarak ayırır.
- ISR ile paylaşılan `static` değişken ayrıca `volatile` olmalıdır.$md$, $md$'static yerel değişken nerede saklanır?' sorusuna '.bss veya .data, stack değil' cevabını net verin ve reentrancy riskini ekleyin.$md$, $md$medium$md$, $md$embedded-engineer$md$, $md$c-programlama$md$),
  ($md$struct-padding-ve-alignment-nedir-attribute-packed-ne-zaman-kullanilmali-riskler$md$, $md$Struct padding ve alignment nedir? __attribute__((packed)) ne zaman kullanılmalı, riskleri nelerdir?$md$, $md$İşlemciler veriye **doğal hizalamasında** (4 byte'lık `uint32_t` için 4'ün katı adres) en verimli erişir. Derleyici bu yüzden struct alanları arasına **padding** byte'ları ekler. Struct'ın toplam boyutu da en büyük üyenin hizalamasının katına yuvarlanır.

```c
struct A {          /* offset */
    uint8_t  a;     /* 0, sonra 3 byte padding */
    uint32_t b;     /* 4 */
    uint16_t c;     /* 8, sonra 2 byte padding */
};                  /* sizeof = 12 */

struct B {          /* aynı alanlar, büyükten küçüğe */
    uint32_t b;     /* 0 */
    uint16_t c;     /* 4 */
    uint8_t  a;     /* 6, sonra 1 byte padding */
};                  /* sizeof = 8 */
```

**Alanları büyükten küçüğe sıralamak** padding'i en aza indirir ve RAM kazandırır.

### packed

```c
typedef struct __attribute__((packed)) {
    uint8_t  cmd;
    uint32_t value;
    uint16_t crc;
} frame_t;          /* sizeof = 7 */
```

Kullanım yerleri: haberleşme protokol çerçeveleri, dosya formatları, donanıma birebir uyması gereken yapılar.

### Riskler

- **Hizalanmamış erişim:** Cortex-M0/M0+ hizalanmamış `LDR` ile **HardFault** verir. Cortex-M3/M4 destekler ama daha yavaştır. Derleyici packed alana doğrudan erişirken güvenli kod üretir, ama alanın adresi bir `uint32_t *` pointer'a alınırsa bu garanti kaybolur.
- **Performans:** Byte byte okuma kodu üretilir.
- **Taşınabilirlik:** Endianness hâlâ çözülmez; farklı mimaride byte sırası değişir.

### Daha güvenli alternatif

Protokol verisini struct'a cast etmek yerine açıkça serialize etmek:

```c
buf[0] = f->cmd;
buf[1] = (uint8_t)(f->value);
buf[2] = (uint8_t)(f->value >> 8);
buf[3] = (uint8_t)(f->value >> 16);
buf[4] = (uint8_t)(f->value >> 24);   /* little-endian, açık ve taşınabilir */
```

Boyutu derleme zamanında doğrulamak için: `_Static_assert(sizeof(frame_t) == 7, "frame size");`$md$, $md$Bir struct'ın sizeof değerini kağıt üzerinde hesaplamanız istenebilir; offset'leri tek tek yazarak ilerleyin.$md$, $md$medium$md$, $md$embedded-engineer$md$, $md$c-programlama$md$),
  ($md$makrolar-ile-inline-fonksiyonlar-arasindaki-fark-nedir-makrolarin-klasik-tuzakla$md$, $md$Makrolar ile inline fonksiyonlar arasındaki fark nedir? Makroların klasik tuzakları nelerdir?$md$, $md$Makrolar **preprocessor** tarafından metin olarak yerine konur; tip kontrolü, kapsam ve debug bilgisi yoktur. `static inline` fonksiyonlar ise gerçek fonksiyon semantiğine sahiptir ve optimizasyonla genelde aynı hızda kod üretir.

### Tuzak 1: Parantez eksikliği

```c
#define SQUARE(x) x * x
SQUARE(a + 1);          /* a + 1 * a + 1  →  yanlış */

#define SQUARE(x) ((x) * (x))   /* doğru */
```

### Tuzak 2: Argümanın birden fazla değerlendirilmesi

```c
#define MAX(a, b) ((a) > (b) ? (a) : (b))
MAX(i++, j);            /* i iki kez artabilir */
MAX(read_adc(), 100);   /* ADC iki kez okunur */
```

### Tuzak 3: Çok satırlı makro ve if-else

```c
#define RESET() led_off(); motor_off()
if (err) RESET();       /* motor_off() her zaman çalışır */

#define RESET() do { led_off(); motor_off(); } while (0)   /* doğru */
```

### inline alternatifi

```c
static inline int32_t max_i32(int32_t a, int32_t b) {
    return a > b ? a : b;
}
```

| Kriter | Makro | static inline |
| --- | --- | --- |
| Tip güvenliği | Yok | Var |
| Yan etkiler | Tekrar değerlendirme | Argüman bir kez değerlendirilir |
| Debug | Adım adım izlenemez | Breakpoint konabilir |
| Inline garantisi | Her zaman | Derleyici kararı (`always_inline` ile zorlanabilir) |
| Generic kullanım | Her tipe uyar | `_Generic` gerekir |

### Makronun hâlâ gerekli olduğu yerler

- Koşullu derleme: `#ifdef DEBUG`
- Derleme zamanı sabitler ve register adresleri
- `__FILE__`, `__LINE__` kullanan log/assert makroları
- Token birleştirme (`##`) ve stringize (`#`)
- Statik dizi boyutu olarak kullanılan sabitler$md$, null, $md$medium$md$, $md$embedded-engineer$md$, $md$c-programlama$md$),
  ($md$fonksiyon-pointer-lari-ve-callback-tablolari-gomulu-sistemlerde-nasil-kullanilir$md$, $md$Fonksiyon pointer'ları ve callback tabloları gömülü sistemlerde nasıl kullanılır? Bir state machine örneği verin.$md$, $md$Fonksiyon pointer'ı, çalışma zamanında hangi fonksiyonun çağrılacağına karar vermeyi sağlar. Gömülü yazılımda **callback**'ler, **sürücü soyutlama (HAL)**, **komut çözümleyiciler** ve **state machine**'lerde yaygındır; uzun `switch-case` bloklarının yerini alır.

### Sözdizimi

```c
typedef void (*callback_t)(uint8_t data);

void uart_register_rx_cb(callback_t cb);

static void on_rx(uint8_t b) { /* ... */ }
uart_register_rx_cb(on_rx);
```

`typedef` olmadan okunması zordur: `void (*cb)(uint8_t)`.

### State machine tablosu

```c
typedef enum { ST_IDLE, ST_RUN, ST_ERROR, ST_COUNT } state_t;
typedef enum { EV_START, EV_STOP, EV_FAULT, EV_COUNT } event_t;

typedef state_t (*handler_t)(void);

static state_t start_motor(void) { motor_on();  return ST_RUN;   }
static state_t stop_motor(void)  { motor_off(); return ST_IDLE;  }
static state_t go_error(void)    { motor_off(); return ST_ERROR; }
static state_t ignore(void);     /* mevcut durumu döndürür */

static state_t current = ST_IDLE;
static state_t ignore(void) { return current; }

static const handler_t table[ST_COUNT][EV_COUNT] = {
    /*            START        STOP        FAULT    */
    [ST_IDLE]  = { start_motor, ignore,     go_error },
    [ST_RUN]   = { ignore,      stop_motor, go_error },
    [ST_ERROR] = { ignore,      stop_motor, ignore   },
};

void fsm_dispatch(event_t ev) {
    if (ev < EV_COUNT) {
        current = table[current][ev]();
    }
}
```

Tablo `static const` olduğu için **Flash**'ta durur; yeni durum eklemek kodu değil tabloyu değiştirmektir.

### Sürücü soyutlama

```c
typedef struct {
    int  (*init)(void);
    int  (*write)(const uint8_t *buf, size_t len);
    int  (*read)(uint8_t *buf, size_t len);
} comm_ops_t;

extern const comm_ops_t uart_ops, spi_ops;
```

Bu, C'de arayüz/polimorfizmin karşılığıdır (Linux kernel `file_operations` aynı yaklaşımı kullanır).

### Dikkat edilecekler

- Çağırmadan önce `NULL` kontrolü yapın; NULL pointer çağrısı HardFault üretir.
- RAM'deki fonksiyon pointer'ı bellek bozulmasıyla ezilirse rastgele adrese atlanır; güvenlik kritik sistemlerde tablolar `const` tutulur.
- MISRA C fonksiyon pointer kullanımını kısıtlar; tip dönüşümü yapmayın.
- Callback'ler ISR bağlamında çağrılıyorsa kısa tutulmalı ve bloklayan API kullanmamalıdır.$md$, $md$Tablo tabanlı FSM'i beyaz tahtada çizip 'yeni durum eklemek sadece tabloya satır eklemek' demek güçlü bir tasarım argümanıdır.$md$, $md$medium$md$, $md$embedded-engineer$md$, $md$c-programlama$md$),
  ($md$bit-field-nedir-donanim-register-larina-erisimde-bit-field-mi-yoksa-bit-maskesi$md$, $md$Bit field nedir? Donanım register'larına erişimde bit field mi yoksa bit maskesi mi kullanılmalı?$md$, $md$**Bit field**, struct üyesine kaç bit ayrılacağını belirtmeyi sağlar:

```c
typedef struct {
    uint32_t enable   : 1;
    uint32_t mode     : 2;
    uint32_t prescale : 4;
    uint32_t reserved : 25;
} ctrl_bits_t;

ctrl_bits_t c = {0};
c.mode = 2;
```

Okunabilir ve RAM'de bayrakları sıkıştırmak için kullanışlıdır.

### Neden register erişiminde risklidir?

C standardı şunları **implementation-defined** bırakır:

- Bitlerin sıralanması (LSB'den mi MSB'den mi başlanacağı)
- Bir alanın word sınırını aşıp aşamayacağı
- Erişim genişliği: derleyici 32 bitlik register'a 8 bitlik okuma/yazma yapabilir. Bazı çevresel birimler yalnızca word erişimini kabul eder.
- `int` tipinde bit field'ın signed olup olmadığı

Ayrıca her alan ataması ayrı bir **read-modify-write** üretir; birkaç alanı değiştirmek register'a birden çok kez yazmak demektir. Yazınca temizlenen (write-1-to-clear) bayraklarda bu, istemeden başka bayrakları silebilir.

### Bit maskesi yaklaşımı

```c
#define CTRL_EN_Pos     0U
#define CTRL_EN         (1UL << CTRL_EN_Pos)
#define CTRL_MODE_Pos   1U
#define CTRL_MODE_Msk   (0x3UL << CTRL_MODE_Pos)

uint32_t r = REG->CTRL;                 /* tek okuma */
r &= ~CTRL_MODE_Msk;
r |= (2UL << CTRL_MODE_Pos) & CTRL_MODE_Msk;
r |= CTRL_EN;
REG->CTRL = r;                          /* tek yazma */
```

Temel işlemler:

```c
x |=  (1U << n);     /* bit set    */
x &= ~(1U << n);     /* bit clear  */
x ^=  (1U << n);     /* bit toggle */
b  = (x >> n) & 1U;  /* bit test   */
```

### Sonuç

- Register erişimi: **maske + shift** (CMSIS da bu yolu kullanır), taşınabilir ve öngörülebilir.
- RAM'deki dahili bayraklar: bit field kabul edilebilir.
- Haberleşme verisi: bit field ile değil, açık shift/mask ile paketlenmelidir.
- Signed tiplerde shift yapmayın; `1U` gibi unsigned sabit kullanın (`1 << 31` int taşmasıdır).$md$, null, $md$medium$md$, $md$embedded-engineer$md$, $md$c-programlama$md$),
  ($md$gpio-pinlerinde-push-pull-open-drain-pull-up-ve-pull-down-yapilandirmalari-ne-is$md$, $md$GPIO pinlerinde push-pull, open-drain, pull-up ve pull-down yapılandırmaları ne işe yarar?$md$, $md$### Çıkış modları

| Mod | Davranış | Kullanım |
| --- | --- | --- |
| **Push-pull** | Pin aktif olarak hem HIGH (VDD) hem LOW (GND) sürülür | LED, chip select, genel dijital çıkış |
| **Open-drain** | Pin yalnızca LOW'a çeker; HIGH için harici/dahili pull-up gerekir | I2C, paylaşılan interrupt hattı, farklı voltaj seviyesine sürme |

Open-drain'de birden fazla cihaz aynı hatta bağlanabilir; biri LOW çektiğinde hat LOW olur (**wired-AND**). Push-pull çıkışlar birbirine bağlanırsa biri HIGH, diğeri LOW sürdüğünde kısa devre oluşur.

### Giriş modları

- **Floating (high-Z):** Pin hiçbir yere bağlı değilse gürültüden rastgele 0/1 okunur ve giriş tamponu fazla akım çekebilir.
- **Pull-up:** Pin direnç üzerinden VDD'ye bağlanır; varsayılan HIGH. Butonun diğer ucu GND'ye bağlanır, basınca LOW okunur (aktif-düşük).
- **Pull-down:** Pin GND'ye çekilir; varsayılan LOW.
- **Analog:** Dijital tampon kapatılır; ADC için ve güç tasarrufu için kullanılmayan pinlerde tercih edilir.

Dahili pull-up'lar genelde **30-50 kΩ** civarındadır; I2C gibi hızlı hatlarda yetersiz kalır, harici **2.2-4.7 kΩ** kullanılır.

### STM32 HAL örneği

```c
GPIO_InitTypeDef g = {0};
g.Pin   = GPIO_PIN_0;
g.Mode  = GPIO_MODE_INPUT;
g.Pull  = GPIO_PULLUP;
HAL_GPIO_Init(GPIOA, &g);

g.Pin   = GPIO_PIN_5;
g.Mode  = GPIO_MODE_OUTPUT_PP;      /* push-pull */
g.Pull  = GPIO_NOPULL;
g.Speed = GPIO_SPEED_FREQ_LOW;      /* EMI için gerekenden hızlı seçmeyin */
HAL_GPIO_Init(GPIOA, &g);
```

Diğer önemli ayarlar: **slew rate/speed** (yüksek hız EMI artırır), **drive strength**, **alternate function** (UART/SPI gibi çevresel birime bağlama) ve pinin **5V tolerant** olup olmadığı.$md$, null, $md$easy$md$, $md$embedded-engineer$md$, $md$mikrodenetleyiciler$md$),
  ($md$timer-ile-pwm-sinyali-nasil-uretilir-frekans-ve-duty-cycle-nasil-hesaplanir$md$, $md$Timer ile PWM sinyali nasıl üretilir? Frekans ve duty cycle nasıl hesaplanır?$md$, $md$Bir donanım timer'ı, giriş saatini **prescaler** ile böler ve bir sayacı **auto-reload (ARR / period)** değerine kadar sayar. PWM modunda çıkış pini, sayaç **compare (CCR)** değerinin altındayken HIGH, üstündeyken LOW olur.

### Formüller

```text
f_timer = f_clk / (PSC + 1)
f_pwm   = f_clk / ((PSC + 1) * (ARR + 1))
duty    = CCR / (ARR + 1)
```

### Örnek

72 MHz saat, 20 kHz PWM (motor sürücü için duyulabilir aralığın üstü):

- `PSC = 0` → timer 72 MHz sayar
- `ARR = 72 000 000 / 20 000 − 1 = 3599`
- %25 duty: `CCR = 3600 * 0.25 = 900`
- Çözünürlük: 3600 adım, yaklaşık **11.8 bit**

Burada **frekans ile çözünürlük arasındaki dengeye** dikkat: PWM frekansı arttıkça ARR küçülür, duty adımları kabalaşır.

```c
/* STM32 register seviyesi, TIM2 CH1 */
TIM2->PSC   = 0;
TIM2->ARR   = 3599;
TIM2->CCR1  = 900;
TIM2->CCMR1 = (6U << TIM_CCMR1_OC1M_Pos) | TIM_CCMR1_OC1PE;  /* PWM mode 1 + preload */
TIM2->CCER |= TIM_CCER_CC1E;
TIM2->CR1  |= TIM_CR1_ARPE | TIM_CR1_CEN;
```

**Preload** açıkken yeni CCR değeri periyot sonunda geçerli olur; böylece duty değişiminde glitch oluşmaz.

### Timer'ın diğer kullanımları

- **Periyodik interrupt:** Kontrol döngüsü, RTOS tick.
- **Input capture:** Harici sinyalin frekans/darbe genişliğini ölçme (enkoder, ultrasonik sensör).
- **Output compare:** Belirli zamanda pin değiştirme.
- **Center-aligned PWM** ve **dead-time insertion:** H-köprü ve üç fazlı motor sürücülerde üst ve alt transistörün aynı anda iletime geçmesini (shoot-through) önler.
- **ADC tetikleme:** Örneklemeyi PWM ile senkronlamak.$md$, $md$Saat frekansı ve hedef PWM frekansını verip PSC/ARR hesaplatmak çok yaygın bir mülakat sorusudur; çözünürlük kaybını da söyleyin.$md$, $md$medium$md$, $md$embedded-engineer$md$, $md$mikrodenetleyiciler$md$),
  ($md$adc-cozunurlugu-referans-voltaji-ve-ornekleme-hizi-nedir-adc-okumasinda-dogrulug$md$, $md$ADC çözünürlüğü, referans voltajı ve örnekleme hızı nedir? ADC okumasında doğruluğu etkileyen faktörler nelerdir?$md$, $md$**ADC**, analog voltajı sayısal değere çevirir.

- **Çözünürlük (N bit):** Toplam seviye sayısı `2^N`. 12 bit ADC 0–4095 arası değer verir.
- **LSB:** `Vref / 2^N`. 3.3 V referansla 12 bit ADC'de 1 LSB ≈ **0.806 mV**.
- **Dönüşüm:** `V = raw * Vref / 2^N` (bazı kaynaklar `2^N − 1` kullanır; fark çoğu uygulamada ihmal edilebilir).

```c
uint16_t raw = adc_read(CH_TEMP);
uint32_t mv  = (uint32_t)raw * 3300U / 4096U;   /* tamsayı aritmetiği */
```

### Örnekleme hızı

**Nyquist** kuralı: sinyaldeki en yüksek frekansın en az **2 katı** hızla örneklemek gerekir. Pratikte 5–10 kat tercih edilir. Aksi hâlde yüksek frekanslar düşük frekans gibi görünür (**aliasing**); bunu önlemek için ADC önüne **anti-aliasing low-pass filtre** konur.

SAR ADC'lerde toplam dönüşüm süresi = **sampling time + conversion time**. Kaynak empedansı yüksekse (ör. 100 kΩ voltaj bölücü) sampling kondansatörü yetişemez; sampling time artırılmalı veya kaynak buffer'lanmalıdır.

### Doğruluğu etkileyen faktörler

| Faktör | Etki / çözüm |
| --- | --- |
| Referans gürültüsü | Vref'i ayrı ve iyi filtrelenmiş tutun |
| Offset ve gain hatası | Kalibrasyon (birçok MCU'da dahili kalibrasyon komutu vardır) |
| INL / DNL | Doğrusallık hataları; datasheet'ten bakılır |
| Kaynak empedansı | Sampling time veya op-amp buffer |
| Dijital gürültü | Ayrı analog/dijital ground, dekuplaj kondansatörleri |
| Kuantalama | Ortalama alma, oversampling |

### Oversampling

4 kat örnek alıp toplamı 1 bit sağa kaydırmak çözünürlüğü **1 bit** artırır (gürültü varsa). Genel: `4^n` örnek ile `n` bit kazanç.

Sürekli ve çok kanallı örneklemede ADC genelde **timer tetiklemeli + DMA** ile çalıştırılır; CPU her dönüşümü beklemez.$md$, null, $md$medium$md$, $md$embedded-engineer$md$, $md$mikrodenetleyiciler$md$),
  ($md$dma-nedir-ne-zaman-kullanilir-dma-kullanirken-cache-coherency-ve-double-bufferin$md$, $md$DMA nedir, ne zaman kullanılır? DMA kullanırken cache coherency ve double buffering gibi konularda nelere dikkat edilmelidir?$md$, $md$**DMA (Direct Memory Access)**, CPU'nun müdahalesi olmadan bellek ile çevresel birim (veya bellek ile bellek) arasında veri taşır. CPU yalnızca transferi başlatır ve bittiğinde interrupt alır.

### Ne zaman kullanılır?

- Yüksek hızlı veya sürekli akışlar: ADC örnekleme, ses (I2S), SPI ekran güncelleme, UART ile büyük veri alımı.
- CPU'nun her byte için interrupt'a girmesinin (ör. 1 Mbps UART'ta saniyede ~100 bin interrupt) kabul edilemeyeceği durumlar.
- Düşük güç: CPU uyurken transfer devam edebilir.

### Temel yapılandırma

- Kaynak ve hedef adres, veri genişliği (8/16/32 bit)
- Adres artırma (bellek tarafı artar, çevresel register sabit kalır)
- Transfer sayısı
- Mod: **normal** veya **circular**
- Tetikleme kaynağı ve öncelik

### Double (ping-pong) buffering

Circular DMA ile tek tampon kullanılır; **half-transfer** ve **transfer-complete** interrupt'ları ile CPU, DMA'nın yazmadığı yarıyı işler.

```c
#define N 256
static uint16_t adc_buf[2 * N];

void HAL_ADC_ConvHalfCpltCallback(ADC_HandleTypeDef *h) {
    process(&adc_buf[0], N);       /* DMA şimdi ikinci yarıda */
}
void HAL_ADC_ConvCpltCallback(ADC_HandleTypeDef *h) {
    process(&adc_buf[N], N);       /* DMA birinci yarıya döndü */
}
```

`process()` yarım tamponun dolma süresinden uzun sürerse veri ezilir; bu süre bütçesi hesaplanmalıdır.

### Cache coherency (Cortex-M7 gibi D-cache olan çekirdekler)

DMA cache'i değil doğrudan RAM'i görür:

- **CPU → DMA (TX):** CPU'nun yazdığı veri cache'te kalmış olabilir. Transferden önce **clean** yapılmalı.
- **DMA → CPU (RX):** DMA RAM'e yazdı ama CPU eski cache satırını okur. Transferden sonra **invalidate** yapılmalı.

```c
SCB_CleanDCache_by_Addr((uint32_t *)tx_buf, sizeof(tx_buf));
/* ... DMA RX tamamlandı ... */
SCB_InvalidateDCache_by_Addr((uint32_t *)rx_buf, sizeof(rx_buf));
```

Tamponlar **32 byte (cache line)** hizalı ve boyutu bu sayının katı olmalıdır; aksi hâlde invalidate komşu değişkenleri bozar. Alternatif: tamponları MPU ile non-cacheable bölgeye koymak.

### Diğer tuzaklar

- DMA tamponu **stack'te** olmamalı; fonksiyon dönünce bellek başka amaçla kullanılır.
- Bazı MCU'larda DMA her RAM bölgesine erişemez (ör. STM32H7'de DTCM).
- CPU ve DMA arasında paylaşılan değişkenler `volatile` olmalı; gerekirse bellek bariyeri (`__DSB()`) kullanılmalıdır.
- UART RX'te uzunluğu bilinmeyen paketler için **IDLE line interrupt + DMA** birlikte kullanılır.$md$, $md$Cortex-M7 ile çalıştıysanız cache clean/invalidate konusunu mutlaka açın; 'ilk seferde çalıştı, sonra rastgele bozuk veri geldi' hikâyesi çok tanıdıktır.$md$, $md$hard$md$, $md$embedded-engineer$md$, $md$mikrodenetleyiciler$md$),
  ($md$mekanik-bir-butonun-debounce-islemi-neden-gereklidir-ve-yazilimda-nasil-yapilir$md$, $md$Mekanik bir butonun debounce işlemi neden gereklidir ve yazılımda nasıl yapılır?$md$, $md$Mekanik kontaklar kapanırken veya açılırken birkaç milisaniye boyunca (tipik olarak 1–20 ms) defalarca açılıp kapanır (**bounce**). MCU bu darbelerin hepsini ayrı basış olarak algılayabilir; tek basışta sayaç 5 artabilir.

### Donanım çözümleri

- **RC filtre + Schmitt trigger** girişli tampon
- SR latch (çift kontaklı anahtarlarda)
- Bazı MCU'larda dahili glitch filtresi

### Yazılım: periyodik örnekleme (önerilen)

Butonu bir timer interrupt'ı veya ana döngüde sabit aralıkla (ör. her 5 ms) okuyup durumun **N ardışık örnek** boyunca sabit kalmasını beklemek:

```c
#define STABLE_COUNT 4          /* 4 x 5 ms = 20 ms */

static uint8_t  stable_state = 1;   /* pull-up, basılı değil = 1 */
static uint8_t  counter = 0;

/* Her 5 ms'de çağrılır; basış anında true döner */
bool button_poll(void) {
    uint8_t raw = gpio_read(BTN_PIN);
    if (raw != stable_state) {
        if (++counter >= STABLE_COUNT) {
            stable_state = raw;
            counter = 0;
            return (stable_state == 0);   /* düşen kenar: basıldı */
        }
    } else {
        counter = 0;
    }
    return false;
}
```

### Kaydırmalı register (shift register) yöntemi

```c
static uint8_t hist = 0xFF;
hist = (hist << 1) | gpio_read(BTN_PIN);
if (hist == 0x80) { /* 1 sonra yedi kez 0: kararlı basış */ }
```

### Interrupt tabanlı yaklaşım

EXTI interrupt'ı ilk kenarda tetiklenir; ISR içinde interrupt geçici olarak kapatılır ve bir timer (veya RTOS'ta bir task'a bildirim) başlatılır. Süre dolunca pin tekrar okunur ve interrupt açılır. Bu yöntem MCU'nun uykudan butonla uyanması gerektiğinde tercih edilir.

### Yapılmaması gereken

ISR içinde `delay_ms(20)` beklemek: diğer interrupt'ları bloklar ve sistemin gerçek zamanlı davranışını bozar.$md$, null, $md$easy$md$, $md$embedded-engineer$md$, $md$mikrodenetleyiciler$md$),
  ($md$bir-bootloader-nasil-calisir-uygulamaya-atlama-ve-guvenli-firmware-guncellemesi$md$, $md$Bir bootloader nasıl çalışır? Uygulamaya atlama ve güvenli firmware güncellemesi nasıl tasarlanır?$md$, $md$**Bootloader**, reset sonrası ilk çalışan küçük programdır. Görevleri: geçerli bir uygulama olup olmadığını kontrol etmek, gerekiyorsa yeni firmware'i (UART, USB, CAN, OTA) alıp Flash'a yazmak ve uygulamaya atlamak.

### Flash yerleşimi

| Bölge | Adres (örnek) | İçerik |
| --- | --- | --- |
| Bootloader | `0x08000000` | 32 KB |
| Uygulama | `0x08008000` | Vektör tablosu + kod |
| Metadata | Son sektör | Versiyon, CRC, imza, boot bayrakları |

Uygulama linker script'inde Flash başlangıcı `0x08008000` olarak ayarlanmalıdır.

### Uygulamaya atlama (Cortex-M)

```c
#define APP_ADDR 0x08008000UL
typedef void (*app_entry_t)(void);

void jump_to_app(void) {
    uint32_t sp    = *(volatile uint32_t *)APP_ADDR;
    uint32_t reset = *(volatile uint32_t *)(APP_ADDR + 4);

    if ((sp & 0x2FFE0000UL) != 0x20000000UL) return;  /* geçerli SRAM mı? */

    __disable_irq();
    SysTick->CTRL = 0;
    /* kullanılan çevresel birimleri ve saatleri sıfırla, NVIC bekleyenleri temizle */
    for (int i = 0; i < 8; i++) { NVIC->ICER[i] = 0xFFFFFFFF; NVIC->ICPR[i] = 0xFFFFFFFF; }

    SCB->VTOR = APP_ADDR;        /* vektör tablosunu taşı */
    __set_MSP(sp);
    __enable_irq();
    ((app_entry_t)reset)();
}
```

Sık yapılan hatalar: VTOR'u güncellememek (interrupt'lar bootloader handler'larına gider), SysTick veya bir çevresel birimin interrupt'ını açık bırakmak.

### Güvenli güncelleme tasarımı

- **Bütünlük:** Her imaj için CRC32 veya SHA-256; atlamadan önce doğrulanır.
- **Özgünlük (secure boot):** İmaj ECDSA/Ed25519 ile imzalanır; bootloader açık anahtarı içerir. Bootloader bölgesi yazma korumalı (RDP/WRP) olmalıdır.
- **A/B (dual bank) şeması:** Yeni imaj pasif slota yazılır; doğrulama başarılıysa aktif slot değiştirilir. Güncelleme yarıda kesilirse eski imaj çalışmaya devam eder.
- **Rollback / deneme sayacı:** Yeni imaj ilk açılışta kendini "onaylanmış" olarak işaretlemezse (watchdog reset sonrası) bootloader eski sürüme döner.
- **Anti-rollback:** Eski ve zafiyetli bir sürümün yüklenmesini versiyon sayacıyla engellemek.
- Güncelleme sırasında güç kesintisine karşı her adım **idempotent** olmalıdır.

Hazır çözümler: **MCUboot** (Zephyr, A/B ve imza desteği), ST'nin ROM bootloader'ı (System Memory), ESP-IDF OTA.$md$, $md$Atlama kodunda VTOR, MSP ve interrupt temizliğini saymak, bootloader'ı gerçekten yazmış olduğunuzu gösterir.$md$, $md$hard$md$, $md$embedded-engineer$md$, $md$mikrodenetleyiciler$md$),
  ($md$uart-ta-baud-rate-frame-yapisi-ve-parity-nedir-rs-485-uart-tan-nasil-farklidir$md$, $md$UART'ta baud rate, frame yapısı ve parity nedir? RS-485 UART'tan nasıl farklıdır?$md$, $md$**UART** asenkron seri haberleşmedir: ortak saat hattı yoktur, iki taraf aynı **baud rate**'e önceden anlaşır. Hatlar: TX, RX, GND (opsiyonel RTS/CTS akış kontrolü).

### Frame yapısı

```text
Idle(1) | Start(0) | D0 D1 ... D7 | [Parity] | Stop(1) | Idle
```

- **Start bit:** Hat 1'den 0'a düşer; alıcı senkronize olur.
- **Data:** 5–9 bit, **LSB önce**.
- **Parity (opsiyonel):** Even, odd veya none. Tek bit hatayı yakalar, çift bit hatayı yakalayamaz.
- **Stop bit:** 1 veya 2 bit, hat 1'e döner.

En yaygın ayar **8N1**: 8 data, parity yok, 1 stop. Bir byte = 10 bit; 115200 baud'da efektif hız ≈ **11.520 byte/s**.

### Baud toleransı

Alıcı her biti ortasından örnekler ve her frame'de start bit ile yeniden senkronize olur. İki taraf arasındaki toplam saat hatası tipik olarak **%2–3**'ün altında olmalıdır. Dahili RC osilatör kullanan MCU'larda yüksek baud oranlarında sorun çıkabilir; kristal tercih edilir.

### Hata türleri

- **Framing error:** Stop bit beklenen yerde 1 değil (baud uyuşmazlığı).
- **Parity error**
- **Overrun:** Yeni byte geldi ama önceki okunmadı (DMA veya ring buffer ile çözülür).

### RS-232, TTL UART ve RS-485

| Özellik | TTL UART | RS-232 | RS-485 |
| --- | --- | --- | --- |
| Sinyal | Single-ended, 3.3/5 V | Single-ended, ±3..±15 V (ters mantık) | **Diferansiyel** (A/B) |
| Mesafe | Kart içi | ~15 m | **~1200 m** |
| Topoloji | Noktadan noktaya | Noktadan noktaya | **Multi-drop bus**, 32+ cihaz |
| Duplex | Full | Full | Genelde half (2 tel) |

RS-485 yalnızca **fiziksel katmandır**; MCU tarafında yine UART kullanılır. Half-duplex'te transceiver'ın **DE/RE** pini gönderim sırasında açılır ve son byte'ın stop biti tamamen gönderildikten sonra (TC bayrağı) kapatılmalıdır. Hattın iki ucuna **120 Ω sonlandırma direnci** konur. Üzerinde genelde **Modbus RTU** çalışır.$md$, null, $md$easy$md$, $md$embedded-engineer$md$, $md$haberlesme-protokolleri$md$),
  ($md$i2c-protokolu-nasil-calisir-adresleme-ack-nack-ve-clock-stretching-nedir$md$, $md$I2C protokolü nasıl çalışır? Adresleme, ACK/NACK ve clock stretching nedir?$md$, $md$**I2C**, iki hatlı (**SDA** veri, **SCL** saat), senkron, **multi-master/multi-slave** bir bus'tır. Hatlar **open-drain**'dir ve pull-up direnci gerektirir. Hızlar: 100 kHz (standard), 400 kHz (fast), 1 MHz (fast-mode plus).

### İşlem sırası

1. **START:** SCL HIGH iken SDA HIGH'tan LOW'a düşer.
2. **Adres byte'ı:** 7 bit slave adresi + 1 bit **R/W** (0 yazma, 1 okuma).
3. **ACK:** Adresi tanıyan slave 9. saat darbesinde SDA'yı LOW çeker.
4. **Veri byte'ları:** Her byte MSB önce, ardından ACK/NACK.
5. **STOP:** SCL HIGH iken SDA LOW'dan HIGH'a çıkar.

```text
S | 1010000 0 | A | 0x10 (register) | A | Sr | 1010000 1 | A | DATA | N | P
  adres+W                              repeated start, adres+R        NACK STOP
```

Register okumada **repeated start (Sr)** kullanılır; böylece bus bırakılmadan yön değişir.

### ACK ve NACK

- Slave adres veya veri sonrası ACK vermezse (**NACK**): cihaz yok, meşgul (EEPROM yazma döngüsü) veya komut hatalı.
- Master okumada **son byte'tan sonra NACK** gönderir; slave'e veri göndermeyi bırakmasını söyler.

### Clock stretching

Slave veriyi hazırlayamıyorsa **SCL'yi LOW tutarak** master'ı bekletir. Master SCL'yi bıraktıktan sonra hattın gerçekten HIGH olduğunu kontrol etmelidir. Bazı master'lar (ör. eski Raspberry Pi donanımı) bunu düzgün desteklemez.

### 10 bit adres ve arbitration

10 bitlik adresler `11110xx` önekiyle iki byte'ta gönderilir. Birden fazla master aynı anda yazarsa, HIGH göndermek isteyip hattı LOW gören master kaybeder ve çekilir (wired-AND).

### Pratik sorunlar

- **Pull-up değeri:** Bus kapasitansına göre seçilir (tipik 4.7 kΩ @100 kHz, 2.2 kΩ @400 kHz). Çok büyük direnç yavaş yükselen kenar üretir.
- **Bus takılması:** Slave transfer ortasında reset olursa SDA'yı LOW tutabilir. Çözüm: SCL'yi GPIO olarak **9 kez toggle** edip STOP üretmek.
- **Adres çakışması:** Aynı sensörden iki tane varsa adres pinleri veya I2C multiplexer (TCA9548A) kullanılır.$md$, $md$Takılı kalan I2C bus'ı 9 saat darbesiyle kurtarma tekniğini bilmek sahada sık karşılaşılan bir problemi çözdüğünüzü gösterir.$md$, $md$medium$md$, $md$embedded-engineer$md$, $md$haberlesme-protokolleri$md$),
  ($md$spi-da-cpol-ve-cpha-nedir-dort-spi-modu-arasindaki-fark-nasil-aciklanir$md$, $md$SPI'da CPOL ve CPHA nedir? Dört SPI modu arasındaki fark nasıl açıklanır?$md$, $md$**SPI**, senkron, full-duplex ve master-slave bir protokoldür. Hatlar: **SCLK**, **MOSI** (master out), **MISO** (master in), **CS/SS** (chip select, genelde aktif-düşük). Adresleme yoktur; her slave için ayrı CS hattı kullanılır. Onlarca MHz hıza çıkabilir ve ACK mekanizması yoktur.

### CPOL ve CPHA

- **CPOL (Clock Polarity):** Boşta saat seviyesi. 0 ise boşta LOW, 1 ise boşta HIGH.
- **CPHA (Clock Phase):** Verinin hangi kenarda örnekleneceği. 0 ise ilk (leading) kenarda örnekle, 1 ise ikinci (trailing) kenarda örnekle.

| Mod | CPOL | CPHA | Boşta SCLK | Örnekleme kenarı | Veri değişim kenarı |
| --- | --- | --- | --- | --- | --- |
| 0 | 0 | 0 | LOW | Yükselen | Düşen |
| 1 | 0 | 1 | LOW | Düşen | Yükselen |
| 2 | 1 | 0 | HIGH | Düşen | Yükselen |
| 3 | 1 | 1 | HIGH | Yükselen | Düşen |

**Mode 0** ve **Mode 3** en yaygın olanlardır; birçok cihaz ikisini de destekler. Mod, slave'in datasheet'indeki timing diyagramından okunur. Yanlış mod seçilirse veri genellikle **1 bit kaymış** gelir; bu, mod hatasının tipik belirtisidir.

### Pratik notlar

- **CS zamanlaması:** Bazı cihazlar CS düştükten sonra ilk saat kenarına kadar minimum süre (setup) ister. Bazıları her byte'ta değil, tüm komut boyunca CS'nin LOW kalmasını şart koşar; donanım NSS yönetimi yerine CS'yi GPIO ile kontrol etmek daha esnektir.
- **Full-duplex doğası:** Okuma yapmak için bile master saat üretmek, yani dummy byte (`0xFF` veya `0x00`) göndermek zorundadır.
- **Bit sırası:** Genelde MSB önce; LSB-first destekleyen cihazlar vardır.
- **Daisy chain:** Bazı cihazlar (shift register, LED sürücü) tek CS ile zincirlenebilir.
- **MISO paylaşımı:** CS'si pasif olan slave MISO'yu high-Z yapmalıdır; yapmayan cihazlar için tampon gerekir.
- Yüksek hızda uzun kablolar ve sinyal bütünlüğü sorun olur; SPI kart içi haberleşme içindir.

```c
uint8_t spi_xfer(uint8_t tx) {
    while (!(SPI1->SR & SPI_SR_TXE));
    *(volatile uint8_t *)&SPI1->DR = tx;
    while (!(SPI1->SR & SPI_SR_RXNE));
    return *(volatile uint8_t *)&SPI1->DR;
}
```$md$, null, $md$medium$md$, $md$embedded-engineer$md$, $md$haberlesme-protokolleri$md$),
  ($md$can-bus-nasil-calisir-arbitration-hata-yonetimi-ve-can-fd-farkini-aciklayin$md$, $md$CAN bus nasıl çalışır? Arbitration, hata yönetimi ve CAN FD farkını açıklayın.$md$, $md$**CAN (Controller Area Network)**, otomotiv ve endüstride kullanılan, **diferansiyel (CAN_H / CAN_L)**, multi-master, mesaj tabanlı bir bus'tır. Mesajlar cihaz adresine değil **identifier**'a göre gönderilir; her node ilgilendiği ID'leri donanım **filtreleriyle** seçer. Bus'ın iki ucunda **120 Ω** sonlandırma bulunur (ölçüldüğünde toplam ~60 Ω).

### Dominant ve recessive

- **Dominant (0):** CAN_H ≈ 3.5 V, CAN_L ≈ 1.5 V.
- **Recessive (1):** İki hat ≈ 2.5 V.

Bir node dominant gönderirse bus dominant olur (wired-AND).

### Bitwise arbitration

Tüm node'lar aynı anda göndermeye başlayabilir. Her biri gönderdiği biti bus'tan geri okur:

1. Recessive (1) gönderip dominant (0) okuyan node **kaybettiğini** anlar ve alıcıya döner.
2. Kazanan node mesajını hiçbir bozulma olmadan göndermeye devam eder (**non-destructive arbitration**).

Sonuç: **ID değeri en düşük olan mesaj en yüksek önceliğe sahiptir.** Örnek: `0x100` ile `0x0F0` yarışırsa `0x0F0` kazanır.

### Frame yapısı (CAN 2.0)

```text
SOF | ID (11 veya 29 bit) | RTR | IDE | r0 | DLC | Data (0-8 byte) | CRC | ACK | EOF
```

- Standart (2.0A) 11 bit, extended (2.0B) 29 bit ID.
- Alıcılardan en az biri ACK slotunda dominant bit yazar.
- Aynı seviyeden 5 bitten sonra **bit stuffing** ile ters bit eklenir; senkronizasyon korunur.

### Hata yönetimi

Beş hata tespit mekanizması: bit, stuff, CRC, form ve ACK hatası. Her node **TEC/REC** (transmit/receive error counter) tutar:

| Durum | Koşul | Davranış |
| --- | --- | --- |
| Error Active | Sayaçlar < 128 | Aktif error frame gönderir |
| Error Passive | TEC veya REC ≥ 128 | Pasif error frame, gönderim öncesi ek bekleme |
| Bus Off | TEC ≥ 256 | Bus'tan tamamen çekilir |

Bu mekanizma, arızalı bir node'un bütün bus'ı kilitlemesini engeller.

### CAN FD farkı

| Özellik | Klasik CAN | CAN FD |
| --- | --- | --- |
| Data uzunluğu | 8 byte | **64 byte** |
| Hız | 1 Mbps'a kadar | Arbitration 1 Mbps, data fazı 5-8 Mbps |
| CRC | 15 bit | 17/21 bit |

Data fazında bit hızının artırılması **BRS** biti ile yapılır. Arbitration hızı aynı kalır; çünkü arbitration için tüm node'ların bit süresi içinde aynı değeri görmesi gerekir ve bu, propagation delay nedeniyle bus uzunluğunu sınırlar (1 Mbps için ~40 m).

Üst katman protokolleri: **CANopen**, **J1939** (ağır vasıtalar), **ISO-TP / UDS** (otomotiv teşhis).$md$, $md$'Neden düşük ID yüksek öncelik?' sorusuna dominant 0 ve wired-AND ile cevap verin; bus off'tan çıkış kuralını (128 x 11 recessive bit) bilmek ek puan getirir.$md$, $md$hard$md$, $md$embedded-engineer$md$, $md$haberlesme-protokolleri$md$),
  ($md$rtos-ta-preemptive-priority-based-scheduling-nasil-calisir-bare-metal-super-loop$md$, $md$RTOS'ta preemptive priority-based scheduling nasıl çalışır? Bare-metal super loop yerine ne zaman RTOS tercih edilir?$md$, $md$### Preemptive priority scheduling

Scheduler her zaman **Ready durumundaki en yüksek öncelikli task'ı** çalıştırır. Daha yüksek öncelikli bir task hazır hâle geldiğinde (ör. bir semaphore verildi, ISR'dan bildirim geldi, delay süresi doldu) çalışan task **hemen kesilir** (preemption).

- **Aynı öncelikteki** task'lar time slicing ile (her tick'te) round-robin paylaşır (FreeRTOS'ta `configUSE_TIME_SLICING`).
- Hiçbir task hazır değilse **idle task** çalışır; burada düşük güç moduna geçilebilir (tickless idle).

### Task durumları

| Durum | Açıklama |
| --- | --- |
| Running | Şu anda CPU'da |
| Ready | Çalışmaya hazır, sıra bekliyor |
| Blocked | Delay, queue, semaphore veya event bekliyor (zaman aşımı olabilir) |
| Suspended | Açıkça askıya alınmış, zaman aşımı yok |

```c
void sensor_task(void *arg) {
    TickType_t last = xTaskGetTickCount();
    for (;;) {
        read_sensor();
        vTaskDelayUntil(&last, pdMS_TO_TICKS(10));   /* sabit periyot, drift yok */
    }
}

xTaskCreate(sensor_task, "sensor", 256, NULL, 3, NULL);
vTaskStartScheduler();
```

`vTaskDelay` "şimdiden itibaren bekle", `vTaskDelayUntil` "sabit periyotla uyan" demektir; periyodik kontrol döngülerinde ikincisi kullanılır.

### Öncelik atama

Klasik yaklaşım **Rate Monotonic**: periyodu kısa olan task'a yüksek öncelik. En yüksek öncelikler deadline'ı sıkı işlere (motor kontrol, haberleşme), düşük öncelikler loglama ve UI'a verilir.

**Starvation riski:** Yüksek öncelikli task hiç bloklanmazsa düşük öncelikli task'lar hiç çalışmaz. Her task'ın döngüsünde mutlaka bloklayan bir çağrı olmalıdır.

### Super loop mu, RTOS mu?

- **Super loop yeterli:** Az sayıda iş, basit zamanlama, çok kısıtlı RAM/Flash, kolay doğrulama gereken sistemler.
- **RTOS tercih edilir:** Farklı periyot ve deadline'lara sahip çok sayıda bağımsız iş; bloklayan sürücüler (TCP/IP, USB, dosya sistemi); yanıt süresinin en uzun döngü süresine bağlı olmaması gerektiğinde.

RTOS'un maliyeti: her task için ayrı stack (RAM), context switch süresi ve senkronizasyon hatası riski (deadlock, race condition).$md$, null, $md$medium$md$, $md$embedded-engineer$md$, $md$rtos$md$),
  ($md$priority-inversion-nedir-priority-inheritance-bu-sorunu-nasil-cozer$md$, $md$Priority inversion nedir? Priority inheritance bu sorunu nasıl çözer?$md$, $md$**Priority inversion**, yüksek öncelikli bir task'ın, düşük öncelikli bir task'ın tuttuğu kaynağı beklerken **orta öncelikli** bir task tarafından dolaylı olarak bloklanmasıdır.

### Senaryo

Task'lar: **H** (yüksek), **M** (orta), **L** (düşük). L ile H aynı mutex'i kullanır.

1. L mutex'i alır, kritik bölgeye girer.
2. H hazır olur, L'yi keser, mutex'i ister ve **bloklanır**.
3. L devam eder, ama bu arada M hazır olur. M, L'den yüksek öncelikli olduğu için **L'yi keser**.
4. M uzun süre çalışır. L mutex'i bırakamaz, H bekler.

Sonuç: Mutex ile hiç ilgisi olmayan M, en yüksek öncelikli H'yi süresiz geciktirir; **sınırsız (unbounded) inversion**. Ünlü örnek: **Mars Pathfinder** (1997) bu yüzden sürekli watchdog reset'i yaşadı; sorun uzaktan priority inheritance açılarak çözüldü.

### Priority inheritance

Düşük öncelikli task, mutex'i beklediği sürece **bekleyen en yüksek öncelikli task'ın önceliğini miras alır**. Senaryoda L geçici olarak H önceliğine yükselir; M onu kesemez. L mutex'i bırakınca eski önceliğine döner ve H hemen çalışır.

FreeRTOS'ta **mutex** (`xSemaphoreCreateMutex`) priority inheritance uygular; **binary semaphore uygulamaz**. Kaynak koruması için bu yüzden semaphore değil mutex kullanılmalıdır.

```c
SemaphoreHandle_t spi_mutex = xSemaphoreCreateMutex();

void task_x(void *arg) {
    for (;;) {
        if (xSemaphoreTake(spi_mutex, pdMS_TO_TICKS(50)) == pdTRUE) {
            spi_transfer(...);
            xSemaphoreGive(spi_mutex);
        } else {
            /* timeout: hata raporla, kilitlenme yerine tespit */
        }
    }
}
```

### Priority ceiling protocol

Alternatif: her mutex'e onu kullanabilecek en yüksek task önceliği (**ceiling**) atanır; mutex'i alan task hemen bu önceliğe çıkar. Inversion'ı sınırlar ve **deadlock'u da önler**, ama her kaynağın kullanıcılarının önceden bilinmesini gerektirir. OSEK/AUTOSAR bu yaklaşımı kullanır.

### Tasarım önerileri

- Kritik bölgeleri **olabildiğince kısa** tutun.
- Mutex tutarken bloklayan çağrı (delay, başka bir queue bekleme) yapmayın.
- İç içe mutex alıyorsanız her yerde **aynı sırayla** alın (deadlock önlemi).
- Bir kaynağa tek bir **gatekeeper task** sahip olsun, diğerleri ona queue ile istek göndersin; mutex ihtiyacı tamamen kalkar.$md$, $md$Mars Pathfinder hikâyesini kısaca anlatmak ve FreeRTOS'ta binary semaphore'un inheritance yapmadığını belirtmek bu sorunun en güçlü cevabıdır.$md$, $md$hard$md$, $md$embedded-engineer$md$, $md$rtos$md$),
  ($md$freertos-ta-queue-binary-semaphore-counting-semaphore-ve-mutex-arasindaki-farkla$md$, $md$FreeRTOS'ta queue, binary semaphore, counting semaphore ve mutex arasındaki farklar nelerdir? Hangisi ne zaman kullanılır?$md$, $md$| Nesne | Amaç | Sahiplik | Priority inheritance | ISR'dan verilebilir mi? |
| --- | --- | --- | --- | --- |
| **Queue** | Veri taşıma (kopyalayarak) | Yok | Yok | Evet (`FromISR`) |
| **Binary semaphore** | Olay bildirimi, senkronizasyon | Yok | Yok | Evet |
| **Counting semaphore** | Olay sayma veya N kaynaklı havuz | Yok | Yok | Evet |
| **Mutex** | Paylaşılan kaynağa karşılıklı dışlama | **Var**: alan task bırakmalı | **Var** | **Hayır** |
| **Recursive mutex** | Aynı task'ın tekrar tekrar alabildiği mutex | Var | Var | Hayır |

### Queue

Task'lar ve ISR'lar arasında **veri** iletimi. Veri queue'ya **kopyalanır**; büyük yapılar için pointer gönderilir (o zaman bellek sahipliğine dikkat).

```c
typedef struct { uint8_t id; int16_t value; } msg_t;
QueueHandle_t q = xQueueCreate(16, sizeof(msg_t));

msg_t m = { .id = 1, .value = 42 };
xQueueSend(q, &m, pdMS_TO_TICKS(10));

msg_t r;
if (xQueueReceive(q, &r, portMAX_DELAY) == pdTRUE) { /* işle */ }
```

### Binary semaphore

"Bir şey oldu" sinyali. Tipik olarak ISR verir, task bekler. Olay task işlerken iki kez gelirse biri kaybolur.

### Counting semaphore

Olayları kaybetmeden saymak veya örneğin 3 adet DMA kanalından oluşan bir havuzu yönetmek için.

### Mutex

Paylaşılan donanım (SPI bus, UART, LCD) veya veri yapısının korunması. Semaphore'dan farkı: **sahiplik** kavramı ve **priority inheritance**. Mutex'i başka task bırakamaz ve ISR'da kullanılamaz.

### Hızlı karar rehberi

- Veri gönderiyorum → **queue**
- ISR'dan task'ı uyandırıyorum → **task notification** (en hızlı ve en az RAM) veya binary semaphore
- Olay sayısını kaybetmemeliyim → **counting semaphore**
- Ortak kaynağı koruyorum → **mutex**
- Birden fazla olayın kombinasyonunu bekliyorum → **event group**

**Task notifications** FreeRTOS'ta binary/counting semaphore yerine kullanılabilen, ayrı nesne gerektirmeyen ve yaklaşık %45 daha hızlı bir mekanizmadır; tek kısıtı alıcının tek bir task olmasıdır.$md$, $md$'Mutex ile binary semaphore arasındaki fark ne?' sorusunda sahiplik ve priority inheritance olmak üzere iki farkı da söyleyin; çoğu aday yalnızca birini bilir.$md$, $md$medium$md$, $md$embedded-engineer$md$, $md$rtos$md$),
  ($md$rtos-ta-isr-icinde-hangi-api-ler-kullanilabilir-deferred-interrupt-processing-na$md$, $md$RTOS'ta ISR içinde hangi API'ler kullanılabilir? Deferred interrupt processing nasıl yapılır?$md$, $md$ISR'lar mümkün olduğunca **kısa** olmalıdır: uzun ISR'lar diğer interrupt'ları geciktirir, jitter'ı artırır ve task'ların zamanlamasını bozar. Ayrıca ISR'lar **bloklayamaz**; bir ISR'ın "beklemesi" diye bir kavram yoktur.

### ISR-safe API kuralları (FreeRTOS)

- Yalnızca adı **`FromISR`** ile biten fonksiyonlar kullanılır: `xQueueSendFromISR`, `xSemaphoreGiveFromISR`, `vTaskNotifyGiveFromISR`, `xEventGroupSetBitsFromISR`.
- Bu fonksiyonlar timeout almaz; queue doluysa hemen hata döner.
- **Mutex ISR'da kullanılamaz** (sahiplik ve inheritance task kavramıdır).
- `printf`, `malloc`, `vTaskDelay` gibi bloklayan veya reentrant olmayan çağrılar yasaktır.
- **Cortex-M'de öncelik sınırı:** RTOS API'si çağıran interrupt'ların donanım önceliği `configMAX_SYSCALL_INTERRUPT_PRIORITY` değerinden daha yüksek (sayısal olarak daha küçük) olamaz. Bu sınırın üstündeki interrupt'lar RTOS tarafından hiç maskelenmez ama API de çağıramaz. Bu ayarın yanlış olması, `configASSERT` ile yakalanan en yaygın hatalardan biridir.

### Deferred interrupt processing

ISR yalnızca donanımı temizler, gerekli minimum veriyi alır ve asıl işi bir **task'a** devreder:

```c
static TaskHandle_t rx_task_handle;

void USART1_IRQHandler(void) {
    BaseType_t woken = pdFALSE;
    uint8_t b = USART1->DR;                     /* bayrağı temizler */
    xStreamBufferSendFromISR(rx_stream, &b, 1, &woken);
    vTaskNotifyGiveFromISR(rx_task_handle, &woken);
    portYIELD_FROM_ISR(woken);                  /* gerekiyorsa hemen context switch */
}

void rx_task(void *arg) {
    for (;;) {
        ulTaskNotifyTake(pdTRUE, portMAX_DELAY);
        uint8_t buf[32];
        size_t n = xStreamBufferReceive(rx_stream, buf, sizeof buf, 0);
        parse_protocol(buf, n);                 /* uzun iş task bağlamında */
    }
}
```

### `pxHigherPriorityTaskWoken` neden önemli?

`FromISR` çağrısı daha yüksek öncelikli bir task'ı uyandırdıysa bu değişken `pdTRUE` olur. ISR sonunda `portYIELD_FROM_ISR` çağrılmazsa uyanan task ancak **bir sonraki tick'te** çalışır; yanıt süresi bir tick kadar (ör. 1 ms) gecikir.

### Diğer seçenekler

- **Timer/daemon task'a havale:** `xTimerPendFunctionCallFromISR` ile bir fonksiyonu timer service task'ında çalıştırmak.
- **Yüksek öncelikli handler task:** Ertelenen işin ISR sonrası gecikmesiz çalışması için bu task'a sistemdeki en yüksek önceliklerden biri verilir.
- Linux karşılığı: top half / bottom half (tasklet, workqueue, threaded IRQ).

### ISR ile task arasında paylaşılan veri

Task tarafında kısa kritik bölgeler için `taskENTER_CRITICAL()` / `taskEXIT_CRITICAL()`, ISR tarafında `taskENTER_CRITICAL_FROM_ISR()` kullanılır; paylaşılan değişkenler `volatile` olmalıdır.$md$, $md$configMAX_SYSCALL_INTERRUPT_PRIORITY ve portYIELD_FROM_ISR detaylarını bilmek, FreeRTOS'u yalnızca örnek projeden değil gerçek üründe kullandığınızı gösterir.$md$, $md$hard$md$, $md$embedded-engineer$md$, $md$rtos$md$),
  ($md$javascript-teki-veri-tipleri-nelerdir-primitive-ve-referans-tipleri-arasindaki-f$md$, $md$JavaScript'teki veri tipleri nelerdir? Primitive ve referans tipleri arasındaki fark nedir?$md$, $md$JavaScript'te 7 primitive tip ve 1 referans tipi (object) vardır.

- **Primitive:** `string`, `number`, `bigint`, `boolean`, `undefined`, `null`, `symbol`
- **Referans:** `object` (diziler, fonksiyonlar, Map, Set, Date de birer nesnedir)

Primitive değerler değiştirilemez (immutable) ve **değer olarak** kopyalanır. Nesneler ise **referans olarak** kopyalanır: iki değişken aynı nesneyi gösterir.

```js
let a = 5;
let b = a;
b++;            // a hâlâ 5

const x = { n: 1 };
const y = x;
y.n = 2;        // x.n de 2 olur, aynı nesne
```

`typeof null` sonucunun `"object"` olması dilin eski bir hatasıdır; null kontrolü için `value === null` kullanılır.$md$, $md$Bir nesneyi kopyalamak için spread (`{...obj}`) yalnızca yüzeysel kopya yapar; iç içe nesneler için `structuredClone` kullanılır.$md$, $md$easy$md$, $md$frontend-developer$md$, $md$javascript$md$),
  ($md$hoisting-nedir$md$, $md$Hoisting nedir?$md$, $md$Hoisting, değişken ve fonksiyon **tanımlarının** kod çalışmadan önce kapsamlarının en üstüne alınmış gibi davranmasıdır. Yalnızca tanım taşınır, atama taşınmaz.

```js
console.log(a); // undefined (var hoist edilir, değeri değil)
var a = 1;

selam();        // çalışır: fonksiyon bildirimi tamamen hoist edilir
function selam() { console.log("merhaba"); }

console.log(b); // ReferenceError: Temporal Dead Zone
let b = 2;

topla(1, 2);    // TypeError: topla is not a function
var topla = (x, y) => x + y;
```

- `var`: hoist edilir, `undefined` ile başlar
- `let` / `const` / `class`: hoist edilir ama tanım satırına kadar erişilemez (TDZ)
- Fonksiyon bildirimi: gövdesiyle birlikte hoist edilir
- Fonksiyon ifadesi / arrow function: değişken kuralına uyar$md$, null, $md$easy$md$, $md$frontend-developer$md$, $md$javascript$md$),
  ($md$promise-nedir-async-await-ile-iliskisi-nasildir$md$, $md$Promise nedir? async/await ile ilişkisi nasıldır?$md$, $md$Promise, henüz tamamlanmamış asenkron bir işlemin gelecekteki sonucunu temsil eden nesnedir. Üç durumu vardır: **pending**, **fulfilled**, **rejected**. Durum bir kez değiştikten sonra bir daha değişmez.

`async/await`, Promise'ler üzerine kurulmuş bir sözdizimidir. `async` fonksiyon her zaman bir Promise döndürür, `await` ise Promise sonuçlanana kadar fonksiyonun geri kalanını bekletir (thread'i bloklamaz).

```js
// Promise zinciri
fetch("/api/kullanici")
  .then(res => res.json())
  .then(user => console.log(user))
  .catch(err => console.error(err));

// Aynısı async/await ile
async function getir() {
  try {
    const res = await fetch("/api/kullanici");
    const user = await res.json();
    console.log(user);
  } catch (err) {
    console.error(err);
  }
}
```$md$, $md$Birbirinden bağımsız istekleri sırayla `await` etmek yerine `Promise.all` ile paralel çalıştırmanın performans farkını anlatın.$md$, $md$medium$md$, $md$frontend-developer$md$, $md$javascript$md$),
  ($md$promise-all-promise-allsettled-promise-race-ve-promise-any-arasindaki-farklar-ne$md$, $md$Promise.all, Promise.allSettled, Promise.race ve Promise.any arasındaki farklar nelerdir?$md$, $md$Dördü de birden çok Promise'i birlikte yönetir, farkları ne zaman ve nasıl sonuçlandıklarıdır.

| Metot | Ne zaman tamamlanır | Hata davranışı |
| --- | --- | --- |
| `Promise.all` | Hepsi başarılı olunca, sonuçlar dizisiyle | İlk hatada hemen reject olur |
| `Promise.allSettled` | Hepsi bitince (başarılı ya da hatalı) | Hiç reject olmaz, her sonucun `status` alanı vardır |
| `Promise.race` | İlk biten Promise ile (başarılı ya da hatalı) | İlk biten hataysa reject |
| `Promise.any` | İlk **başarılı** Promise ile | Hepsi hatalıysa `AggregateError` |

```js
const [user, posts] = await Promise.all([getUser(), getPosts()]);

// Zaman aşımı deseni
const sonuc = await Promise.race([
  fetch(url),
  new Promise((_, rej) => setTimeout(() => rej(new Error("timeout")), 5000)),
]);
```$md$, null, $md$medium$md$, $md$frontend-developer$md$, $md$javascript$md$),
  ($md$call-apply-ve-bind-arasindaki-fark-nedir$md$, $md$call, apply ve bind arasındaki fark nedir?$md$, $md$Üçü de bir fonksiyonun `this` değerini açıkça belirlemeyi sağlar.

- **call:** fonksiyonu hemen çağırır, argümanları tek tek alır
- **apply:** fonksiyonu hemen çağırır, argümanları dizi olarak alır
- **bind:** fonksiyonu çağırmaz; `this`'i (ve isteğe bağlı argümanları) sabitlenmiş **yeni bir fonksiyon** döndürür

```js
function tanit(selam, nokta) {
  return `${selam}, ben ${this.ad}${nokta}`;
}
const kisi = { ad: "Ayşe" };

tanit.call(kisi, "Merhaba", "!");      // "Merhaba, ben Ayşe!"
tanit.apply(kisi, ["Selam", "."]);     // "Selam, ben Ayşe."
const bagli = tanit.bind(kisi, "Hey");
bagli("?");                             // "Hey, ben Ayşe?"
```

`bind` özellikle event handler'larda ve callback olarak geçirilen metotlarda `this`'in kaybolmasını önlemek için kullanılır.$md$, null, $md$medium$md$, $md$frontend-developer$md$, $md$javascript$md$),
  ($md$event-delegation-nedir-neden-kullanilir$md$, $md$Event delegation nedir, neden kullanılır?$md$, $md$Event delegation, çok sayıda alt elemana ayrı ayrı event listener eklemek yerine **ortak ebeveyne tek bir listener** ekleyip olayın hangi elemandan geldiğini `event.target` ile ayırt etmektir. Olay kabarcıklanma (bubbling) sayesinde mümkündür.

```js
document.querySelector("#liste").addEventListener("click", (e) => {
  const satir = e.target.closest("li[data-id]");
  if (!satir) return;
  sil(satir.dataset.id);
});
```

Avantajları:

- Tek listener: daha az bellek
- Sonradan eklenen elemanlar için ek kod gerekmez
- Liste yeniden çizildiğinde listener'ları temizlemekle uğraşılmaz

`focus`, `blur` gibi kabarcıklanmayan olaylar için `focusin` / `focusout` kullanılır.$md$, $md$Event akışının üç aşamasını (capturing, target, bubbling) ve `stopPropagation` ile `preventDefault` farkını bilmek beklenir.$md$, $md$medium$md$, $md$frontend-developer$md$, $md$javascript$md$),
  ($md$throttle-nedir-debounce-tan-farki-nedir-bir-throttle-fonksiyonu-yazin$md$, $md$Throttle nedir? Debounce'tan farkı nedir? Bir throttle fonksiyonu yazın.$md$, $md$- **Debounce:** olaylar durduktan belirli bir süre sonra **bir kez** çalışır. Arama kutusu için idealdir.
- **Throttle:** olaylar devam etse bile fonksiyonu belirli aralıklarla **en fazla bir kez** çalıştırır. Scroll, resize, mousemove gibi sürekli olaylar için uygundur.

```js
function throttle(fn, ms) {
  let son = 0;
  let bekleyen = null;
  return function (...args) {
    const simdi = Date.now();
    const kalan = ms - (simdi - son);
    if (kalan <= 0) {
      son = simdi;
      fn.apply(this, args);
    } else if (!bekleyen) {
      bekleyen = setTimeout(() => {
        son = Date.now();
        bekleyen = null;
        fn.apply(this, args);
      }, kalan);
    }
  };
}

window.addEventListener("scroll", throttle(konumuGuncelle, 100));
```

Son satırdaki `setTimeout`, aralığın sonunda gelen son olayın da kaybolmamasını (trailing call) sağlar.$md$, null, $md$medium$md$, $md$frontend-developer$md$, $md$javascript$md$),
  ($md$bir-nesnenin-derin-kopyasini-deep-clone-nasil-alirsiniz$md$, $md$Bir nesnenin derin kopyasını (deep clone) nasıl alırsınız?$md$, $md$Spread (`{...obj}`) ve `Object.assign` yalnızca **yüzeysel** kopya yapar; iç içe nesneler hâlâ paylaşılır.

Seçenekler:

- **`structuredClone(obj)`**: modern tarayıcılarda ve Node 17+'da yerleşik. Date, Map, Set, döngüsel referansları destekler; fonksiyonları ve DOM düğümlerini kopyalayamaz.
- **`JSON.parse(JSON.stringify(obj))`**: basit ama `Date`'i string'e çevirir, `undefined`, fonksiyon ve `Map`'i kaybeder, döngüsel referansta hata verir.
- **Kendi fonksiyonunuz**: mülakatta genelde istenen budur.

```js
function derinKopya(deger, gorulen = new WeakMap()) {
  if (deger === null || typeof deger !== "object") return deger;
  if (deger instanceof Date) return new Date(deger);
  if (gorulen.has(deger)) return gorulen.get(deger);   // döngüsel referans

  const kopya = Array.isArray(deger) ? [] : {};
  gorulen.set(deger, kopya);
  for (const anahtar of Reflect.ownKeys(deger)) {
    kopya[anahtar] = derinKopya(deger[anahtar], gorulen);
  }
  return kopya;
}
```$md$, $md$WeakMap ile döngüsel referansı ele almanız, çözümü sıradan bir özyinelemeden ayırır.$md$, $md$hard$md$, $md$frontend-developer$md$, $md$javascript$md$),
  ($md$map-filter-reduce-ve-foreach-arasindaki-farklar-nelerdir$md$, $md$map, filter, reduce ve forEach arasındaki farklar nelerdir?$md$, $md$- **forEach:** her eleman için fonksiyon çalıştırır, **hiçbir şey döndürmez** (`undefined`). Yan etki içindir.
- **map:** her elemanı dönüştürür, **aynı uzunlukta yeni dizi** döndürür.
- **filter:** koşulu sağlayan elemanlarla **yeni dizi** döndürür.
- **reduce:** diziyi tek bir değere indirger (toplam, nesne, başka bir dizi).

```js
const urunler = [
  { ad: "Kalem", fiyat: 10, stok: 5 },
  { ad: "Defter", fiyat: 40, stok: 0 },
  { ad: "Silgi", fiyat: 5, stok: 12 },
];

const stoktakiler = urunler.filter(u => u.stok > 0);
const adlar = stoktakiler.map(u => u.ad);              // ["Kalem", "Silgi"]
const toplamDeger = urunler.reduce((t, u) => t + u.fiyat * u.stok, 0); // 110
```

Hiçbiri orijinal diziyi değiştirmez; zincirlenebilmeleri fonksiyonel stilin temelidir.$md$, null, $md$medium$md$, $md$frontend-developer$md$, $md$javascript$md$),
  ($md$es-modules-import-export-ile-commonjs-require-arasindaki-fark-nedir$md$, $md$ES Modules (import/export) ile CommonJS (require) arasındaki fark nedir?$md$, $md$- **CommonJS** (`require`, `module.exports`): Node.js'in eski modül sistemi. Modüller **çalışma zamanında, senkron** yüklenir; `require` kodun herhangi bir yerinde çağrılabilir.
- **ES Modules** (`import`, `export`): dilin standart modül sistemi. İçe aktarmalar **statik** olarak analiz edilir, yükleme asenkron olabilir, tarayıcılar da doğrudan destekler.

ESM'nin statik yapısı sayesinde bundler'lar kullanılmayan kodu atabilir (**tree shaking**). ESM'de içe aktarılan değerler canlı bağlantıdır (live binding), CommonJS'te ise bir kopya alınır.

```js
// ESM
import { topla } from "./matematik.js";
export const kare = x => x * x;

// Dinamik import (kod bölme)
const { Grafik } = await import("./grafik.js");
```$md$, null, $md$medium$md$, $md$frontend-developer$md$, $md$javascript$md$),
  ($md$generator-fonksiyonlar-ve-iterator-protokolu-nedir$md$, $md$Generator fonksiyonlar ve iterator protokolü nedir?$md$, $md$Bir nesne `[Symbol.iterator]()` metodu ile `{ value, done }` döndüren bir `next()` sağlıyorsa **iterable**'dır; `for...of`, spread ve destructuring bu protokolü kullanır.

Generator (`function*`) bu protokolü kolayca üretir: `yield` ile değer üretip durur, `next()` çağrılınca kaldığı yerden devam eder.

```js
function* idUret(baslangic = 1) {
  let id = baslangic;
  while (true) yield id++;
}

const ids = idUret();
ids.next().value; // 1
ids.next().value; // 2

function* aralik(bas, son, adim = 1) {
  for (let i = bas; i < son; i += adim) yield i;
}
[...aralik(0, 10, 3)]; // [0, 3, 6, 9]
```

Kullanım alanları: tembel (lazy) diziler, sonsuz akışlar, sayfalı API'leri gezmek (`async function*` ile).$md$, null, $md$medium$md$, $md$frontend-developer$md$, $md$javascript$md$),
  ($md$weakmap-ve-weakset-nedir-map-ve-set-ten-farklari-nelerdir$md$, $md$WeakMap ve WeakSet nedir, Map ve Set'ten farkları nelerdir?$md$, $md$`WeakMap` ve `WeakSet` anahtarlarını (WeakSet'te elemanlarını) **zayıf referansla** tutar: anahtar nesneye başka hiçbir referans kalmadığında çöp toplayıcı onu silebilir ve kayıt kendiliğinden kaybolur.

| | Map / Set | WeakMap / WeakSet |
| --- | --- | --- |
| Anahtar tipi | Her şey | Yalnızca nesne (ve kayıtlı olmayan symbol) |
| Gezilebilir mi? | Evet (`size`, `for...of`) | Hayır |
| Bellek sızıntısı riski | Anahtar silinmezse var | Yok |

Kullanım alanları: DOM elemanlarına ek veri bağlamak, önbellek (memoization), nesnelere özel (private) veri eklemek.

```js
const tiklamaSayisi = new WeakMap();
function say(el) {
  tiklamaSayisi.set(el, (tiklamaSayisi.get(el) ?? 0) + 1);
}
// el DOM'dan kaldırılıp referansı kalmayınca kayıt da silinir
```$md$, null, $md$medium$md$, $md$frontend-developer$md$, $md$javascript$md$),
  ($md$optional-chaining-ve-nullish-coalescing-operatorleri-ne-ise-yarar$md$, $md$Optional chaining (?.) ve nullish coalescing (??) operatörleri ne işe yarar?$md$, $md$- **Optional chaining (`?.`)**: zincirdeki değer `null` veya `undefined` ise hata vermek yerine `undefined` döndürür.
- **Nullish coalescing (`??`)**: sol taraf yalnızca `null` veya `undefined` ise sağ tarafı döndürür.

```js
const sehir = kullanici?.adres?.sehir;          // adres yoksa undefined
kullanici.kaydet?.();                            // metot varsa çağır

const sayfa = ayar.sayfa ?? 1;                   // 0 geçerli bir değer olarak kalır
const sayfaYanlis = ayar.sayfa || 1;             // 0 gelirse 1 olur!
```

`??` ile `||` farkı önemlidir: `||` tüm falsy değerlerde (`0`, `""`, `false`) varsayılana düşer, `??` yalnızca `null`/`undefined`'da.$md$, null, $md$easy$md$, $md$frontend-developer$md$, $md$javascript$md$),
  ($md$javascript-te-bellek-sizintisi-memory-leak-nasil-olusur-nasil-tespit-edilir$md$, $md$JavaScript'te bellek sızıntısı (memory leak) nasıl oluşur, nasıl tespit edilir?$md$, $md$Bellek sızıntısı, artık ihtiyaç duyulmayan nesnelere hâlâ bir referans kaldığı için çöp toplayıcının onları temizleyememesidir.

Sık nedenler:

- Temizlenmeyen `setInterval` / `setTimeout`
- Kaldırılmayan event listener'lar (özellikle `window`, `document` üzerinde)
- Büyüyüp hiç temizlenmeyen global diziler veya Map tabanlı önbellekler
- DOM'dan kaldırılmış ama JS'te referansı tutulan elemanlar (detached DOM)
- Closure'ların büyük nesneleri gereksiz yere yakalaması

Tespit: Chrome DevTools → **Memory** sekmesinde iki heap snapshot alıp karşılaştırmak, "Detached" elemanları aramak, **Performance** sekmesinde JS heap grafiğinin sürekli yükselip yükselmediğine bakmak.

```js
// React'te doğru temizlik
useEffect(() => {
  const onResize = () => setGenislik(window.innerWidth);
  window.addEventListener("resize", onResize);
  return () => window.removeEventListener("resize", onResize);
}, []);
```$md$, null, $md$hard$md$, $md$frontend-developer$md$, $md$javascript$md$),
  ($md$promise-all-fonksiyonunu-kendiniz-nasil-yazarsiniz$md$, $md$Promise.all fonksiyonunu kendiniz nasıl yazarsınız?$md$, $md$Beklenen davranış: tüm Promise'ler başarılı olunca sonuçları **girdi sırasıyla** döndürmek, herhangi biri hata verirse hemen reject etmek. Promise olmayan değerler de kabul edilmeli.

```js
function promiseAll(girdiler) {
  return new Promise((resolve, reject) => {
    const liste = Array.from(girdiler);
    const sonuclar = new Array(liste.length);
    let biten = 0;

    if (liste.length === 0) return resolve([]);

    liste.forEach((p, i) => {
      Promise.resolve(p).then((deger) => {
        sonuclar[i] = deger;          // sırayı korumak için index ile yaz
        biten++;
        if (biten === liste.length) resolve(sonuclar);
      }, reject);
    });
  });
}
```

Dikkat edilecek noktalar: boş dizi, sıranın korunması (`push` değil index), Promise olmayan değerler için `Promise.resolve`.$md$, $md$Ardından aynı mantıkla `Promise.allSettled` veya eşzamanlılık sınırı olan bir `promisePool` yazmanız istenebilir.$md$, $md$hard$md$, $md$frontend-developer$md$, $md$javascript$md$),
  ($md$microtask-ve-macrotask-nedir-requestanimationframe-bu-siranin-neresindedir$md$, $md$Microtask ve macrotask nedir? requestAnimationFrame bu sıranın neresindedir?$md$, $md$Event loop her turda şunu yapar: call stack boşalınca **bir macrotask** çalıştırır, ardından **tüm microtask kuyruğunu** boşaltır, gerekiyorsa sayfayı yeniden çizer.

- **Macrotask:** `setTimeout`, `setInterval`, I/O, kullanıcı olayları, `MessageChannel`
- **Microtask:** Promise callback'leri (`then`, `await` sonrası), `queueMicrotask`, `MutationObserver`
- **requestAnimationFrame:** bir sonraki ekran çizimi (render) öncesinde çalışır, tipik olarak saniyede 60 kez. Animasyonlar için `setTimeout` yerine kullanılmalıdır.

```js
setTimeout(() => console.log("macrotask"));
Promise.resolve().then(() => console.log("microtask"));
requestAnimationFrame(() => console.log("raf"));
console.log("senkron");
// senkron → microtask → (raf ve macrotask: tarayıcıya göre) …
```

Sonsuz microtask üreten kod (sürekli kendini tekrar eden `then`) render'ı ve macrotask'ları açlıkta bırakıp sayfayı dondurabilir.$md$, null, $md$medium$md$, $md$frontend-developer$md$, $md$javascript$md$),
  ($md$bu-kodun-ciktisi-nedir-for-dongusunde-var-ile-settimeout$md$, $md$Bu kodun çıktısı nedir? for döngüsünde var ile setTimeout.$md$, $md$```js
for (var i = 0; i < 3; i++) {
  setTimeout(() => console.log(i), 0);
}
```

Çıktı: `3, 3, 3`. `var` fonksiyon kapsamlıdır; üç callback de **aynı** `i` değişkenini paylaşır ve çalıştıklarında döngü bitmiş, `i` 3 olmuştur.

Çözümler:

```js
// 1) let: her iterasyonda yeni bir bağlama (binding) oluşur
for (let i = 0; i < 3; i++) setTimeout(() => console.log(i), 0); // 0, 1, 2

// 2) IIFE ile closure
for (var i = 0; i < 3; i++) {
  ((j) => setTimeout(() => console.log(j), 0))(i);
}
```$md$, $md$Mülakatçı burada hem closure'ı hem de `let`'in blok kapsamını anlayıp anlamadığınızı ölçer.$md$, $md$medium$md$, $md$frontend-developer$md$, $md$javascript$md$),
  ($md$typescript-nedir-javascript-e-gore-avantajlari-nelerdir$md$, $md$TypeScript nedir, JavaScript'e göre avantajları nelerdir?$md$, $md$TypeScript, JavaScript'e **statik tip sistemi** ekleyen bir üst kümedir. Kod derleme (transpile) sırasında tip kontrolünden geçer ve sade JavaScript'e dönüştürülür; tarayıcıda çalışan şey yine JavaScript'tir.

Avantajları:

- Hatalar (yanlış alan adı, `undefined` erişimi, yanlış argüman) kod çalışmadan yakalanır
- Editörde güçlü otomatik tamamlama ve güvenli yeniden adlandırma (refactoring)
- Tipler, kodun dokümantasyonu gibi çalışır; büyük ekiplerde okunabilirlik artar

Dezavantajları: derleme adımı, öğrenme eğrisi ve bazı durumlarda tip tanımlarının karmaşıklaşması.$md$, $md$Tiplerin çalışma zamanında var olmadığını (type erasure), API'den gelen veriyi çalışma zamanında doğrulamak için zod gibi kütüphaneler gerektiğini söylemek artı puandır.$md$, $md$easy$md$, $md$frontend-developer$md$, $md$typescript$md$),
  ($md$interface-ile-type-alias-arasindaki-farklar-nelerdir$md$, $md$interface ile type alias arasındaki farklar nelerdir?$md$, $md$İkisi de nesne şekillerini tanımlayabilir ve çoğu durumda birbirinin yerine kullanılabilir. Farklar:

- **interface** yalnızca nesne/fonksiyon şekli tanımlar; **declaration merging** destekler (aynı adla iki interface birleşir). `extends` ile genişletilir.
- **type** her şeyi adlandırabilir: union (`"a" | "b"`), tuple, primitive alias, mapped ve conditional tipler. `&` (intersection) ile birleştirilir.

```ts
interface Kullanici { id: number; ad: string }
interface Kullanici { email: string }        // birleşir

type Durum = "beklemede" | "onaylandi" | "reddedildi";
type Admin = Kullanici & { yetkiler: string[] };
```

Yaygın tercih: genişletilebilir nesne sözleşmeleri (ör. kütüphane API'leri) için `interface`, union ve hesaplanmış tipler için `type`.$md$, null, $md$medium$md$, $md$frontend-developer$md$, $md$typescript$md$),
  ($md$generic-jenerik-tipler-nedir-bir-ornekle-aciklayin$md$, $md$Generic (jenerik) tipler nedir? Bir örnekle açıklayın.$md$, $md$Generic'ler, bir fonksiyonun veya tipin **hangi tiple çalışacağını parametre olarak** almasını sağlar. Böylece tip güvenliğini kaybetmeden yeniden kullanılabilir kod yazılır.

```ts
function ilk<T>(dizi: T[]): T | undefined {
  return dizi[0];
}
const s = ilk(["a", "b"]);   // string | undefined
const n = ilk([1, 2, 3]);    // number | undefined

// Kısıtlama (constraint)
function idIleBul<T extends { id: number }>(liste: T[], id: number): T | undefined {
  return liste.find(x => x.id === id);
}

// Generic tip
type ApiCevabi<T> = { veri: T; hata: string | null };
const cevap: ApiCevabi<Kullanici[]> = { veri: [], hata: null };
```$md$, null, $md$medium$md$, $md$frontend-developer$md$, $md$typescript$md$),
  ($md$any-unknown-ve-never-tipleri-arasindaki-fark-nedir$md$, $md$any, unknown ve never tipleri arasındaki fark nedir?$md$, $md$- **any:** tip kontrolünü tamamen kapatır. Her şey atanabilir ve her işlem yapılabilir. Mümkün olduğunca kaçınılmalıdır.
- **unknown:** "ne olduğunu bilmiyorum" demektir. Her şey atanabilir ama **kullanmadan önce daraltmak** (type narrowing) gerekir. Dış kaynaktan gelen veri için güvenli seçimdir.
- **never:** asla oluşmayacak değerin tipidir. Hep hata fırlatan fonksiyonların dönüş tipi ve **kapsamlı kontrol** (exhaustive check) için kullanılır.

```ts
function isle(veri: unknown) {
  if (typeof veri === "string") return veri.toUpperCase(); // daraltıldı
  // veri.toUpperCase(); // hata: unknown
}

type Sekil = { tur: "daire"; r: number } | { tur: "kare"; a: number };
function alan(s: Sekil) {
  switch (s.tur) {
    case "daire": return Math.PI * s.r ** 2;
    case "kare": return s.a ** 2;
    default: { const kontrol: never = s; return kontrol; } // yeni tür eklenirse derleme hatası
  }
}
```$md$, null, $md$medium$md$, $md$frontend-developer$md$, $md$typescript$md$),
  ($md$utility-type-lar-nelerdir-partial-pick-omit-record-ne-ise-yarar$md$, $md$Utility type'lar nelerdir? Partial, Pick, Omit, Record ne işe yarar?$md$, $md$TypeScript, mevcut tiplerden yeni tipler üreten hazır yardımcılar sunar:

- **`Partial<T>`**: tüm alanları isteğe bağlı yapar (güncelleme formları)
- **`Required<T>`**: tüm alanları zorunlu yapar
- **`Pick<T, K>`**: yalnızca seçilen alanları alır
- **`Omit<T, K>`**: seçilen alanları çıkarır
- **`Record<K, V>`**: anahtarları K, değerleri V olan nesne
- **`Readonly<T>`**, **`ReturnType<F>`**, **`Parameters<F>`**, **`Awaited<T>`**

```ts
interface Kullanici { id: number; ad: string; email: string; sifre: string }

type KullaniciGuncelle = Partial<Omit<Kullanici, "id">>;
type HerkeseAcik = Pick<Kullanici, "id" | "ad">;
type RolIzinleri = Record<"admin" | "editor", string[]>;
```$md$, null, $md$medium$md$, $md$frontend-developer$md$, $md$typescript$md$),
  ($md$type-narrowing-nedir-type-guard-nasil-yazilir$md$, $md$Type narrowing nedir? Type guard nasıl yazılır?$md$, $md$Type narrowing, union bir tipin kod akışına göre daha dar bir tipe indirgenmesidir. TypeScript şu kontrolleri anlar: `typeof`, `instanceof`, `in`, eşitlik kontrolleri ve **discriminated union**'larda ortak alan.

Kendi kontrolünüzü yazmak için **type predicate** (`deger is T`) dönüş tipi kullanılır:

```ts
interface Kedi { tur: "kedi"; miyavla(): void }
interface Kopek { tur: "kopek"; havla(): void }
type Hayvan = Kedi | Kopek;

function kediMi(h: Hayvan): h is Kedi {
  return h.tur === "kedi";
}

function ses(h: Hayvan) {
  if (kediMi(h)) h.miyavla();   // burada h: Kedi
  else h.havla();               // burada h: Kopek
}

// API cevabını doğrulayan guard
function kullaniciMi(x: unknown): x is { id: number; ad: string } {
  return typeof x === "object" && x !== null && "id" in x && "ad" in x;
}
```$md$, null, $md$hard$md$, $md$frontend-developer$md$, $md$typescript$md$),
  ($md$mapped-type-ve-conditional-type-nedir-ornek-verin$md$, $md$Mapped type ve conditional type nedir? Örnek verin.$md$, $md$**Mapped type**, mevcut bir tipin anahtarları üzerinde dolaşarak yeni bir tip üretir. **Conditional type** ise `T extends U ? X : Y` biçiminde tip düzeyinde koşul kurar; `infer` ile tip çıkarımı yapılabilir.

```ts
// Mapped: tüm alanları nullable yap
type Nullable<T> = { [K in keyof T]: T[K] | null };

// Anahtarları yeniden adlandırma (key remapping)
type Getterlar<T> = {
  [K in keyof T as `get${Capitalize<string & K>}`]: () => T[K];
};
// Getterlar<{ ad: string }> → { getAd: () => string }

// Conditional + infer
type DiziElemani<T> = T extends (infer E)[] ? E : never;
type X = DiziElemani<string[]>;            // string

type PromiseSonucu<T> = T extends Promise<infer R> ? R : T;
```

Yerleşik `Partial`, `ReturnType`, `Awaited` gibi utility type'lar bu iki mekanizmayla yazılmıştır.$md$, null, $md$hard$md$, $md$frontend-developer$md$, $md$typescript$md$),
  ($md$typescript-te-enum-ile-union-literal-tip-arasinda-hangisini-tercih-edersiniz$md$, $md$TypeScript'te enum ile union literal tip arasında hangisini tercih edersiniz?$md$, $md$```ts
enum Rol { Admin = "admin", Kullanici = "user" }
type RolTipi = "admin" | "user";
```

- **enum** çalışma zamanında gerçek bir JavaScript nesnesi üretir (paket boyutuna eklenir). Sayısal enum'lar beklenmedik değerlerin atanmasına izin verebilir.
- **Union literal** yalnızca tip düzeyindedir, derlenince tamamen kaybolur; JSON ve API verileriyle doğrudan uyumludur.

Modern projelerde genelde union literal tercih edilir. Değerlerin listesine çalışma zamanında da ihtiyaç varsa `as const` ile ikisi birlikte elde edilir:

```ts
const ROLLER = ["admin", "user"] as const;
type Rol = (typeof ROLLER)[number];   // "admin" | "user"
```$md$, null, $md$easy$md$, $md$frontend-developer$md$, $md$typescript$md$),
  ($md$tsconfig-json-daki-strict-modu-neleri-acar-neden-onemlidir$md$, $md$tsconfig.json'daki strict modu neleri açar, neden önemlidir?$md$, $md$`"strict": true` bir grup sıkı kontrolü birlikte açar. En önemlileri:

- **strictNullChecks:** `null` ve `undefined` her tipe atanamaz; `string | null` gibi açıkça yazılmalı. En çok hatayı yakalayan ayardır.
- **noImplicitAny:** tipi çıkarılamayan değişken ve parametreler sessizce `any` olamaz.
- **strictFunctionTypes:** fonksiyon parametrelerinin tip uyumluluğu daha doğru kontrol edilir.
- **strictPropertyInitialization:** class alanları constructor'da başlatılmalıdır.
- **useUnknownInCatchVariables:** `catch (e)` içindeki `e`, `unknown` olur.

Yeni projelerde strict mod baştan açılmalıdır. Eski bir projeye sonradan açmak çok sayıda hata üretir; genelde dosya dosya geçiş yapılır.$md$, $md$`noUncheckedIndexedAccess` gibi strict'e dahil olmayan ek ayarları bildiğinizi göstermek iyi bir izlenim bırakır.$md$, $md$medium$md$, $md$frontend-developer$md$, $md$typescript$md$),
  ($md$react-te-props-ile-state-arasindaki-fark-nedir$md$, $md$React'te props ile state arasındaki fark nedir?$md$, $md$- **Props:** bileşene **dışarıdan** (ebeveynden) verilen, bileşen içinde **değiştirilemeyen** girdilerdir. Fonksiyon parametreleri gibi düşünülebilir.
- **State:** bileşenin **kendi içinde** tuttuğu, zamanla değişen veridir. Değiştiğinde bileşen yeniden render olur.

```jsx
function Sayac({ baslangic }) {              // prop
  const [sayi, setSayi] = useState(baslangic); // state
  return <button onClick={() => setSayi(s => s + 1)}>{sayi}</button>;
}

<Sayac baslangic={5} />
```

Veri React'te **yukarıdan aşağıya** akar. Bir çocuğun ebeveyndeki state'i değiştirmesi gerekiyorsa ebeveyn ona bir callback prop'u verir.$md$, null, $md$easy$md$, $md$frontend-developer$md$, $md$react$md$),
  ($md$usestate-te-fonksiyonel-guncelleme-setstate-prev-ne-zaman-gerekir$md$, $md$useState'te fonksiyonel güncelleme (setState(prev => ...)) ne zaman gerekir?$md$, $md$State güncellemeleri **asenkron ve toplu (batched)** işlenir. Yeni değer bir önceki değere dayanıyorsa, render anındaki eski değeri kullanmak hatalı sonuç verir.

```jsx
// Yanlış: üçü de aynı "sayi" değerini görür, sonuç +1
setSayi(sayi + 1);
setSayi(sayi + 1);
setSayi(sayi + 1);

// Doğru: her biri bir öncekinin sonucunu alır, sonuç +3
setSayi(s => s + 1);
setSayi(s => s + 1);
setSayi(s => s + 1);
```

Fonksiyonel güncelleme ayrıca `useEffect` veya `setInterval` içinde eski değerin yakalanması (stale closure) sorununu da önler ve bağımlılık dizisini sadeleştirir.$md$, null, $md$medium$md$, $md$frontend-developer$md$, $md$react$md$),
  ($md$useref-ne-ise-yarar-usestate-ten-farki-nedir$md$, $md$useRef ne işe yarar? useState'ten farkı nedir?$md$, $md$`useRef`, render'lar arasında korunan, değiştirildiğinde **yeniden render tetiklemeyen** bir kutu (`{ current }`) döndürür.

Kullanım alanları:

- DOM elemanına erişmek (focus, ölçüm, scroll)
- Render'ı etkilemeyen değerleri saklamak: timer id, önceki değer, abonelik
- Stale closure sorunlarında en güncel değere erişmek

```jsx
function AramaKutusu() {
  const inputRef = useRef(null);
  const timerRef = useRef();

  useEffect(() => inputRef.current.focus(), []);

  const yazildi = (e) => {
    clearTimeout(timerRef.current);
    timerRef.current = setTimeout(() => ara(e.target.value), 300);
  };
  return <input ref={inputRef} onChange={yazildi} />;
}
```

Kural: ekranda gösterilen değer **state**, gösterilmeyen yardımcı değer **ref**'tir.$md$, null, $md$medium$md$, $md$frontend-developer$md$, $md$react$md$),
  ($md$usecontext-nedir-ne-zaman-kullanilir-dezavantaji-nedir$md$, $md$useContext nedir? Ne zaman kullanılır, dezavantajı nedir?$md$, $md$Context, bir değeri bileşen ağacında **prop drilling** yapmadan derinlere iletmeyi sağlar. Tema, oturum açmış kullanıcı, dil gibi uygulama genelindeki veriler için uygundur.

```jsx
const TemaContext = createContext("acik");

function App() {
  const [tema, setTema] = useState("acik");
  return (
    <TemaContext.Provider value={{ tema, setTema }}>
      <Sayfa />
    </TemaContext.Provider>
  );
}

function Buton() {
  const { tema } = useContext(TemaContext);
  return <button className={tema}>Kaydet</button>;
}
```

Dezavantajı: Provider'ın `value`'su değiştiğinde **o context'i kullanan tüm bileşenler** yeniden render olur. Sık değişen verileri (ör. form değerleri) context'e koymak performansı düşürür. Çözüm: context'leri bölmek, `value`'yu `useMemo` ile sabitlemek veya Zustand gibi seçici abonelik sunan bir kütüphane kullanmak.$md$, null, $md$medium$md$, $md$frontend-developer$md$, $md$react$md$),
  ($md$usereducer-nedir-usestate-yerine-ne-zaman-tercih-edilir$md$, $md$useReducer nedir, useState yerine ne zaman tercih edilir?$md$, $md$`useReducer`, state'i `(state, action) => yeniState` biçiminde saf bir fonksiyonla yönetir. Redux'taki desenin bileşen içi hâlidir.

Tercih edilen durumlar:

- Birbirine bağlı birden çok state alanı (form, sihirbaz adımları)
- Bir sonraki state'in karmaşık kurallarla hesaplanması
- State geçişlerini tek yerde toplayıp test etmek

```jsx
function sepetReducer(state, action) {
  switch (action.type) {
    case "ekle":
      return { ...state, urunler: [...state.urunler, action.urun] };
    case "sil":
      return { ...state, urunler: state.urunler.filter(u => u.id !== action.id) };
    case "temizle":
      return { urunler: [] };
    default:
      throw new Error("Bilinmeyen işlem: " + action.type);
  }
}

const [sepet, dispatch] = useReducer(sepetReducer, { urunler: [] });
dispatch({ type: "ekle", urun });
```$md$, null, $md$medium$md$, $md$frontend-developer$md$, $md$react$md$),
  ($md$custom-hook-nedir-bir-ornek-yazin$md$, $md$Custom hook nedir? Bir örnek yazın.$md$, $md$Custom hook, adı `use` ile başlayan ve içinde başka hook'lar kullanan bir fonksiyondur. Bileşenler arasında **durumlu mantığı** (stateful logic) paylaşmanın yoludur; state'in kendisi paylaşılmaz, her kullanımda ayrı kopya oluşur.

```jsx
function useFetch(url) {
  const [veri, setVeri] = useState(null);
  const [hata, setHata] = useState(null);
  const [yukleniyor, setYukleniyor] = useState(true);

  useEffect(() => {
    const kontrol = new AbortController();
    setYukleniyor(true);
    fetch(url, { signal: kontrol.signal })
      .then(r => { if (!r.ok) throw new Error(r.statusText); return r.json(); })
      .then(setVeri)
      .catch(e => { if (e.name !== "AbortError") setHata(e); })
      .finally(() => setYukleniyor(false));
    return () => kontrol.abort();          // url değişirse eski isteği iptal et
  }, [url]);

  return { veri, hata, yukleniyor };
}
```$md$, $md$AbortController ile yarış durumunu (race condition) önlemek, iyi bir custom hook'un işaretidir.$md$, $md$medium$md$, $md$frontend-developer$md$, $md$react$md$),
  ($md$hook-kurallari-rules-of-hooks-nelerdir-neden-vardir$md$, $md$Hook kuralları (Rules of Hooks) nelerdir, neden vardır?$md$, $md$1. Hook'lar yalnızca **bileşenin en üst seviyesinde** çağrılır: if, döngü veya iç içe fonksiyon içinde çağrılmaz.
2. Hook'lar yalnızca **React fonksiyon bileşenlerinden veya custom hook'lardan** çağrılır.

Neden: React, bir bileşenin hook'larını isimle değil **çağrılma sırasıyla** eşleştirir. Bir hook koşula bağlı çağrılırsa sıra kayar ve state yanlış hook'a bağlanır.

```jsx
// Yanlış
if (girisYapti) { const [x, setX] = useState(0); }

// Doğru: hook her zaman çağrılır, koşul içeride
const [x, setX] = useState(0);
if (!girisYapti) return null;
```

`eslint-plugin-react-hooks` bu kuralları ve `useEffect` bağımlılıklarını otomatik kontrol eder.$md$, null, $md$easy$md$, $md$frontend-developer$md$, $md$react$md$),
  ($md$useeffect-ile-uselayouteffect-arasindaki-fark-nedir$md$, $md$useEffect ile useLayoutEffect arasındaki fark nedir?$md$, $md$- **useEffect:** tarayıcı ekranı **çizdikten sonra**, asenkron çalışır. Veri çekme, abonelik, loglama gibi işlerin çoğu için doğru seçimdir.
- **useLayoutEffect:** DOM güncellendikten sonra ama tarayıcı **çizmeden önce**, senkron çalışır. Çizimi bloklar.

`useLayoutEffect` gerektiren durum: DOM'u ölçüp hemen ona göre konum ayarlamak (tooltip, popover). `useEffect` kullanılırsa kullanıcı önce yanlış konumu, sonra düzeltilmiş hâli görür (titreme).

```jsx
useLayoutEffect(() => {
  const { height } = ref.current.getBoundingClientRect();
  setTooltipY(height + 8);
}, []);
```

Varsayılan olarak `useEffect` kullanılmalı; `useLayoutEffect` sadece görsel titreme varsa.$md$, null, $md$medium$md$, $md$frontend-developer$md$, $md$react$md$),
  ($md$stale-closure-problemi-nedir-react-te-nasil-ortaya-cikar$md$, $md$Stale closure problemi nedir? React'te nasıl ortaya çıkar?$md$, $md$Bir fonksiyon, oluşturulduğu render'daki değerleri yakalar. O fonksiyon sonraki render'larda da çalışmaya devam ederse **eski (bayat) değerleri** görür.

```jsx
function Kronometre() {
  const [saniye, setSaniye] = useState(0);

  useEffect(() => {
    const id = setInterval(() => {
      setSaniye(saniye + 1);   // saniye her zaman 0 → ekranda hep 1
    }, 1000);
    return () => clearInterval(id);
  }, []);                       // effect bir kez çalıştı, ilk closure'ı tutuyor
}
```

Çözümler:

- Fonksiyonel güncelleme: `setSaniye(s => s + 1)`
- Değeri bağımlılık dizisine eklemek (effect her değişimde yeniden kurulur)
- En güncel değeri bir `useRef` içinde tutmak$md$, null, $md$hard$md$, $md$frontend-developer$md$, $md$react$md$),
  ($md$react-memo-nedir-ne-zaman-ise-yaramaz$md$, $md$React.memo nedir? Ne zaman işe yaramaz?$md$, $md$`React.memo`, bir bileşeni sarar ve **prop'ları yüzeysel olarak değişmediyse** yeniden render'ı atlar.

```jsx
const UrunKarti = React.memo(function UrunKarti({ urun, onSec }) {
  return <div onClick={() => onSec(urun.id)}>{urun.ad}</div>;
});
```

İşe yaramadığı durumlar:

- Ebeveyn her render'da **yeni nesne, dizi veya fonksiyon** prop'u veriyorsa (`style={{...}}`, `onSec={() => ...}`) karşılaştırma her seferinde "değişti" der. Bunlar `useMemo` / `useCallback` ile sabitlenmelidir.
- Bileşen `children` alıyorsa (JSX her render'da yeni nesnedir).
- Bileşen zaten ucuzsa: karşılaştırmanın maliyeti kazançtan fazla olabilir.

Önce React DevTools Profiler ile gerçekten pahalı render'ı bulmak, sonra memo eklemek gerekir.$md$, null, $md$medium$md$, $md$frontend-developer$md$, $md$react$md$),
  ($md$react-te-kosullu-render-ve-liste-render-i-nasil-yapilir$md$, $md$React'te koşullu render ve liste render'ı nasıl yapılır?$md$, $md$JSX içinde JavaScript ifadeleri kullanılır:

```jsx
function Bildirimler({ liste, yukleniyor }) {
  if (yukleniyor) return <Spinner />;              // erken dönüş

  return (
    <section>
      {liste.length === 0 ? (
        <p>Bildirim yok</p>                         // üçlü operatör
      ) : (
        <ul>
          {liste.map(b => <li key={b.id}>{b.mesaj}</li>)}
        </ul>
      )}
      {liste.some(b => !b.okundu) && <Rozet />}     // && ile
    </section>
  );
}
```

Tuzak: `{sayi && <Rozet />}` ifadesinde `sayi` 0 ise ekrana **0** yazılır. Bunun yerine `{sayi > 0 && ...}` yazılmalıdır.$md$, null, $md$easy$md$, $md$frontend-developer$md$, $md$react$md$),
  ($md$lifting-state-up-nedir-prop-drilling-sorunu-nasil-cozulur$md$, $md$Lifting state up nedir? Prop drilling sorunu nasıl çözülür?$md$, $md$**Lifting state up:** İki kardeş bileşen aynı veriye ihtiyaç duyduğunda state, ikisinin **en yakın ortak ebeveynine** taşınır; ebeveyn değeri ve güncelleme fonksiyonunu prop olarak dağıtır.

```jsx
function Filtreli() {
  const [arama, setArama] = useState("");
  return (
    <>
      <AramaKutusu deger={arama} onDegis={setArama} />
      <Sonuclar arama={arama} />
    </>
  );
}
```

State çok yukarı taşınınca aradaki bileşenler kullanmadıkları prop'ları sadece iletir (**prop drilling**). Çözümler:

- **Bileşen kompozisyonu:** çocuğu `children` olarak geçirip aradaki katmanları atlamak
- **Context:** tema, kullanıcı gibi geniş kapsamlı veriler
- **State yönetim kütüphanesi:** Zustand, Redux Toolkit, Jotai
- **Sunucu state'i** için TanStack Query (önbellek bileşen ağacından bağımsız)$md$, null, $md$medium$md$, $md$frontend-developer$md$, $md$react$md$),
  ($md$controlled-form-yonetimi-ve-form-validasyonu-nasil-yapilir$md$, $md$Controlled form yönetimi ve form validasyonu nasıl yapılır?$md$, $md$Küçük formlarda her alan state'te tutulur ve gönderimde doğrulanır:

```jsx
function KayitFormu() {
  const [form, setForm] = useState({ email: "", sifre: "" });
  const [hatalar, setHatalar] = useState({});

  const degis = e => setForm(f => ({ ...f, [e.target.name]: e.target.value }));

  const gonder = e => {
    e.preventDefault();
    const h = {};
    if (!/^\S+@\S+\.\S+$/.test(form.email)) h.email = "Geçerli bir e-posta girin";
    if (form.sifre.length < 8) h.sifre = "En az 8 karakter";
    setHatalar(h);
    if (Object.keys(h).length === 0) kaydet(form);
  };

  return (
    <form onSubmit={gonder} noValidate>
      <input name="email" value={form.email} onChange={degis} aria-invalid={!!hatalar.email} />
      {hatalar.email && <p role="alert">{hatalar.email}</p>}
      {/* ... */}
    </form>
  );
}
```

Büyük formlarda her tuş vuruşunda tüm formun yeniden render olmasını önlemek için **React Hook Form** (uncontrolled input + ref) ve şema doğrulama için **Zod** yaygın tercihlerdir.$md$, $md$İstemci tarafı doğrulamanın sadece kullanıcı deneyimi için olduğunu, asıl doğrulamanın sunucuda yapılması gerektiğini mutlaka söyleyin.$md$, $md$medium$md$, $md$frontend-developer$md$, $md$react$md$),
  ($md$react-fiber-ve-concurrent-rendering-nedir-usetransition-ne-ise-yarar$md$, $md$React Fiber ve concurrent rendering nedir? useTransition ne işe yarar?$md$, $md$**Fiber**, React 16 ile gelen yeni uzlaştırma (reconciliation) motorudur. Render işini küçük birimlere böler, böylece React işi **duraklatabilir, önceliklendirebilir ve iptal edebilir**.

**Concurrent rendering** (React 18) bu yeteneği kullanır: acil güncellemeler (yazma, tıklama) acil olmayanlardan (büyük liste filtreleme) önce işlenir, arayüz donmaz.

```jsx
function Arama({ urunler }) {
  const [metin, setMetin] = useState("");
  const [filtre, setFiltre] = useState("");
  const [isPending, startTransition] = useTransition();

  const degis = e => {
    setMetin(e.target.value);                     // acil: input hemen güncellenir
    startTransition(() => setFiltre(e.target.value)); // acil değil: kesilebilir
  };

  const sonuc = useMemo(() => urunler.filter(u => u.ad.includes(filtre)), [urunler, filtre]);
  return (
    <>
      <input value={metin} onChange={degis} />
      {isPending && <span>Filtreleniyor…</span>}
      <Liste veri={sonuc} />
    </>
  );
}
```

Benzer amaçla `useDeferredValue`, bir değerin gecikmeli kopyasını üretir.$md$, null, $md$hard$md$, $md$frontend-developer$md$, $md$react$md$),
  ($md$error-boundary-nedir-hangi-hatalari-yakalayamaz$md$, $md$Error Boundary nedir? Hangi hataları yakalayamaz?$md$, $md$Error Boundary, alt ağacındaki **render sırasında** oluşan hataları yakalayıp tüm uygulama çökmek yerine yedek bir arayüz (fallback) gösteren bileşendir. Yalnızca class bileşeni olarak yazılabilir (ya da `react-error-boundary` paketi kullanılır).

```jsx
class HataSiniri extends React.Component {
  state = { hata: null };
  static getDerivedStateFromError(hata) { return { hata }; }
  componentDidCatch(hata, bilgi) { logla(hata, bilgi.componentStack); }
  render() {
    return this.state.hata ? <p>Bir şeyler ters gitti.</p> : this.props.children;
  }
}
```

Yakalayamadıkları:

- Event handler içindeki hatalar (normal `try/catch` kullanılır)
- Asenkron kod (`setTimeout`, Promise callback'leri)
- Sunucu tarafı render hataları
- Error Boundary'nin kendi içindeki hatalar$md$, null, $md$medium$md$, $md$frontend-developer$md$, $md$react$md$),
  ($md$react-lazy-ve-suspense-ile-kod-bolme-code-splitting-nasil-yapilir$md$, $md$React.lazy ve Suspense ile kod bölme (code splitting) nasıl yapılır?$md$, $md$Büyük uygulamalarda tüm kodu tek pakette göndermek ilk yüklemeyi yavaşlatır. `React.lazy`, bir bileşeni **ihtiyaç duyulduğunda** ayrı bir dosyadan yükler; `Suspense` yüklenirken gösterilecek arayüzü belirler.

```jsx
const AdminPaneli = React.lazy(() => import("./AdminPaneli"));
const Grafikler = React.lazy(() => import("./Grafikler"));

function App() {
  return (
    <Suspense fallback={<Spinner />}>
      <Routes>
        <Route path="/admin" element={<AdminPaneli />} />
        <Route path="/rapor" element={<Grafikler />} />
      </Routes>
    </Suspense>
  );
}
```

En verimli bölme noktaları sayfa (route) sınırları ve nadiren açılan ağır bileşenlerdir (editör, grafik, harita). Next.js'te sayfalar otomatik bölünür; bileşen düzeyinde `next/dynamic` kullanılır.$md$, null, $md$medium$md$, $md$frontend-developer$md$, $md$react$md$),
  ($md$redux-zustand-ve-tanstack-query-arasindaki-farklar-nelerdir-hangisini-ne-zaman-s$md$, $md$Redux, Zustand ve TanStack Query arasındaki farklar nelerdir? Hangisini ne zaman seçersiniz?$md$, $md$Önce iki tür state'i ayırmak gerekir:

- **İstemci state'i:** modal açık mı, seçili sekme, sepet, tema
- **Sunucu state'i:** API'den gelen veri; önbelleğe alma, yeniden çekme, bayatlama gibi ihtiyaçları vardır

| Araç | Odak | Ne zaman |
| --- | --- | --- |
| **Redux Toolkit** | Merkezi, öngörülebilir istemci state'i, güçlü devtools | Büyük ekipler, karmaşık iş kuralları, zaman yolculuğu ile hata ayıklama |
| **Zustand** | Minimal, hook tabanlı global store, seçici abonelik | Orta boy uygulamalarda basit global state |
| **TanStack Query** | Sunucu state'i: cache, yeniden deneme, arka planda yenileme, sayfalama | API verisi olan hemen her uygulama |

Yaygın modern kombinasyon: **sunucu verisi için TanStack Query + az miktardaki istemci state'i için Zustand veya Context**. API verisini Redux'ta elle tutmak gereksiz kod üretir.$md$, null, $md$hard$md$, $md$frontend-developer$md$, $md$react$md$),
  ($md$usememo-ve-usecallback-i-her-yerde-kullanmak-neden-dogru-degildir$md$, $md$useMemo ve useCallback'i her yerde kullanmak neden doğru değildir?$md$, $md$Her iki hook da bir maliyetle gelir: her render'da bağımlılık dizisi karşılaştırılır, önceki değer bellekte tutulur ve kod okunması zorlaşır.

Faydalı olduğu durumlar:

- Gerçekten pahalı bir hesaplama (binlerce elemanlı liste sıralama, filtreleme)
- `React.memo` ile sarılmış bir çocuğa geçen nesne/fonksiyon prop'u
- Başka bir hook'un bağımlılık dizisine giren değer (gereksiz effect tetiklenmesini önlemek)

Faydasız olduğu durumlar: basit hesaplamalar, memo'suz çocuklara geçen fonksiyonlar, zaten primitive olan değerler.

React 19 ile gelen **React Compiler**, bu memoizasyonu derleme sırasında otomatik yaparak elle `useMemo` / `useCallback` yazma ihtiyacını büyük ölçüde azaltır.$md$, null, $md$medium$md$, $md$frontend-developer$md$, $md$react$md$),
  ($md$react-19-ve-server-components-hakkinda-ne-biliyorsunuz$md$, $md$React 19 ve Server Components hakkında ne biliyorsunuz?$md$, $md$**React Server Components (RSC)**, yalnızca sunucuda çalışan ve tarayıcıya **JavaScript'i gönderilmeyen** bileşenlerdir. Veritabanına veya dosya sistemine doğrudan erişebilir, `async` olabilirler. Etkileşim gereken parçalar `"use client"` ile işaretlenen istemci bileşenleri olarak kalır.

```jsx
// Sunucu bileşeni: paketi büyütmez, veriye doğrudan erişir
export default async function UrunSayfasi({ id }) {
  const urun = await db.urun.findUnique({ where: { id } });
  return (
    <>
      <h1>{urun.ad}</h1>
      <SepeteEkle id={urun.id} />   {/* "use client" bileşeni */}
    </>
  );
}
```

React 19 ile gelen diğer yenilikler:

- **Actions** ve `useActionState`: form gönderimini, bekleme ve hata durumlarını yönetir
- **`useOptimistic`**: sunucu cevabı gelmeden arayüzü iyimser güncelleme
- **`use()`**: render sırasında Promise veya context okumak
- `ref`'in normal prop olarak geçebilmesi (`forwardRef` gereksizleşir)
- React Compiler ile otomatik memoizasyon$md$, null, $md$hard$md$, $md$frontend-developer$md$, $md$react$md$),
  ($md$react-uygulamasinda-api-den-veri-cekerken-dikkat-edilmesi-gerekenler-nelerdir$md$, $md$React uygulamasında API'den veri çekerken dikkat edilmesi gerekenler nelerdir?$md$, $md$Bir veri çekme işleminin ele alması gereken durumlar:

1. **Yükleniyor, hata ve boş** durumlarının her biri için arayüz
2. **Yarış durumu (race condition):** kullanıcı hızlıca filtre değiştirirse geç dönen eski cevap yenisinin üzerine yazmamalı → `AbortController` ile iptal
3. **Önbellek:** aynı veriyi her bileşen ayrı ayrı çekmemeli
4. **Yeniden deneme** ve bayat verinin arka planda yenilenmesi
5. **Bileşen kaldırıldıktan sonra** state güncellenmemeli
6. **Waterfall'dan kaçınmak:** bağımsız istekler paralel atılmalı

Bunları elle yazmak zor olduğundan gerçek projelerde **TanStack Query** veya **SWR** kullanılır:

```jsx
const { data, isLoading, error } = useQuery({
  queryKey: ["urunler", kategori],
  queryFn: () => fetch(`/api/urunler?k=${kategori}`).then(r => r.json()),
  staleTime: 60_000,
});
```

Next.js App Router'da veri çekmenin önerilen yeri ise sunucu bileşenleridir.$md$, null, $md$medium$md$, $md$frontend-developer$md$, $md$react$md$),
  ($md$next-js-nedir-sade-react-e-gore-ne-kazandirir$md$, $md$Next.js nedir? Sade React'e göre ne kazandırır?$md$, $md$Next.js, React üzerine kurulu, Vercel tarafından geliştirilen bir **full stack framework**'tür. React yalnızca arayüz kütüphanesidir; Next.js bir uygulama için gereken geri kalan parçaları hazır sunar:

- **Dosya tabanlı yönlendirme** (routing)
- **Sunucu tarafı render (SSR), statik üretim (SSG) ve ISR**: SEO ve ilk yükleme hızı
- **Server Components ve Server Actions**: aynı projede backend kodu
- **API Route / Route Handler**'lar
- Otomatik kod bölme, görsel (`next/image`) ve font (`next/font`) optimizasyonu
- Middleware / proxy, önbellekleme ve yeniden doğrulama (revalidation)

Özellikle SEO'nun önemli olduğu içerik siteleri, e-ticaret ve SaaS panelleri için yaygın tercihtir.$md$, null, $md$easy$md$, $md$frontend-developer$md$, $md$nextjs$md$),
  ($md$next-js-app-router-da-server-component-ile-client-component-arasindaki-fark-nedi$md$, $md$Next.js App Router'da Server Component ile Client Component arasındaki fark nedir?$md$, $md$App Router'da bileşenler **varsayılan olarak Server Component**'tir.

| | Server Component | Client Component (`"use client"`) |
| --- | --- | --- |
| Çalıştığı yer | Yalnızca sunucu | Sunucuda ön render + tarayıcıda |
| Tarayıcıya JS gönderir mi? | Hayır | Evet |
| `useState`, `useEffect`, event handler | Kullanamaz | Kullanabilir |
| Veritabanı, gizli anahtar, dosya sistemi | Doğrudan erişebilir | Erişemez |
| `async` bileşen | Olabilir | Olamaz |

Doğru mimari: sayfanın büyük kısmı sunucu bileşeni, etkileşim gereken **küçük yapraklar** istemci bileşeni. `"use client"` sınırı ağaçta ne kadar aşağıda olursa paket o kadar küçük olur.

Sunucu bileşeni bir istemci bileşenine yalnızca **serileştirilebilir** prop geçebilir (fonksiyon geçemez, Server Action hariç).$md$, null, $md$medium$md$, $md$frontend-developer$md$, $md$nextjs$md$),
  ($md$next-js-te-ssr-ssg-ve-isr-nasil-yapilandirilir$md$, $md$Next.js'te SSR, SSG ve ISR nasıl yapılandırılır?$md$, $md$App Router'da render stratejisi sayfanın kullandığı verilere ve ayarlara göre belirlenir:

- **Statik (SSG):** dinamik API kullanmayan sayfalar derleme sırasında üretilir.
- **ISR:** `export const revalidate = 3600` ile sayfa statik sunulur ve en fazla saatte bir arka planda yenilenir. Bir veri değiştiğinde `revalidatePath("/urunler")` veya `revalidateTag` ile anında yenilenir.
- **Dinamik (SSR):** `cookies()`, `headers()`, `searchParams` kullanan veya `export const dynamic = "force-dynamic"` olan sayfalar her istekte sunucuda üretilir.

```tsx
// app/urunler/[slug]/page.tsx
export const revalidate = 3600;

export async function generateStaticParams() {
  const urunler = await getPopulerUrunler();
  return urunler.map(u => ({ slug: u.slug }));  // en popülerleri derlemede üret
}

export default async function Sayfa({ params }: { params: Promise<{ slug: string }> }) {
  const { slug } = await params;
  const urun = await getUrun(slug);
  return <UrunDetay urun={urun} />;
}
```$md$, $md$Bu sitenin kendisi ISR kullanıyor: soru sayfaları önbellekten gelir, bir soru onaylanınca revalidatePath ile anında yenilenir. Bunun gibi gerçek bir örnek anlatmak etkili olur.$md$, $md$medium$md$, $md$frontend-developer$md$, $md$nextjs$md$),
  ($md$server-actions-nedir-nasil-kullanilir$md$, $md$Server Actions nedir? Nasıl kullanılır?$md$, $md$Server Action, `"use server"` ile işaretlenen ve **istemciden çağrılabilen ama sunucuda çalışan** asenkron fonksiyondur. Form gönderimleri ve veri değişiklikleri için ayrı bir API endpoint'i yazma ihtiyacını ortadan kaldırır.

```tsx
// app/yorumlar/actions.ts
"use server";
export async function yorumEkle(formData: FormData) {
  const metin = String(formData.get("metin") ?? "").trim();
  if (metin.length < 3) return { hata: "Yorum çok kısa" };
  await db.yorum.create({ data: { metin } });
  revalidatePath("/yorumlar");
}

// Bileşende
<form action={yorumEkle}>
  <textarea name="metin" />
  <button>Gönder</button>
</form>
```

JavaScript yüklenmeden de çalışır (progressive enhancement). `useActionState` ile bekleme ve hata durumları, `useOptimistic` ile iyimser güncelleme yapılır.$md$, $md$Server Action'ların herkese açık bir HTTP endpoint'i olduğunu, bu yüzden içinde yetki kontrolü ve girdi doğrulaması yapılması gerektiğini vurgulayın.$md$, $md$medium$md$, $md$frontend-developer$md$, $md$nextjs$md$),
  ($md$next-js-te-middleware-proxy-ne-ise-yarar$md$, $md$Next.js'te Middleware (Proxy) ne işe yarar?$md$, $md$Middleware (Next.js 16'da adı **proxy**), bir istek sayfaya veya route'a ulaşmadan **önce** çalışan koddur. İsteği okuyabilir, yönlendirebilir (redirect), yeniden yazabilir (rewrite) veya cevaba başlık/çerez ekleyebilir.

Tipik kullanımlar:

- Giriş yapmamış kullanıcıyı `/giris`'e yönlendirmek
- Oturum çerezlerini yenilemek
- Dil veya bölgeye göre yönlendirme (i18n)
- A/B testi, bot engelleme, güvenlik başlıkları

```ts
// proxy.ts
export function proxy(request: NextRequest) {
  const oturum = request.cookies.get("session");
  if (!oturum && request.nextUrl.pathname.startsWith("/panel")) {
    return NextResponse.redirect(new URL("/giris", request.url));
  }
}
export const config = { matcher: ["/panel/:path*"] };
```

`matcher` ile yalnızca gereken yollarda çalıştırmak performans için önemlidir; her istekte çalışan ağır bir middleware tüm siteyi yavaşlatır.$md$, null, $md$medium$md$, $md$frontend-developer$md$, $md$nextjs$md$),
  ($md$next-image-bileseni-normal-img-etiketine-gore-ne-avantaj-saglar$md$, $md$next/image bileşeni normal img etiketine göre ne avantaj sağlar?$md$, $md$`next/image`:

- Görseli cihazın ekran genişliğine uygun **boyutta** ve **modern formatta** (WebP/AVIF) otomatik üretir
- Varsayılan olarak **lazy loading** yapar; ekranda görünmeyen görseller yüklenmez
- `width`/`height` veya `fill` zorunlu olduğu için yer önceden ayrılır, **layout shift (CLS)** oluşmaz
- `priority` ile ilk ekrandaki büyük görselin (LCP) öncelikli yüklenmesini sağlar
- `placeholder="blur"` ile yüklenirken bulanık önizleme gösterir

```tsx
import Image from "next/image";
<Image src="/kapak.jpg" alt="Ürün kapak fotoğrafı" width={1200} height={630} priority />
```$md$, null, $md$easy$md$, $md$frontend-developer$md$, $md$nextjs$md$),
  ($md$bir-elemani-yatay-ve-dikey-olarak-ortalamanin-yollari-nelerdir$md$, $md$Bir elemanı yatay ve dikey olarak ortalamanın yolları nelerdir?$md$, $md$Modern ve en kısa yollar:

```css
/* Flexbox */
.kapsayici { display: flex; justify-content: center; align-items: center; }

/* Grid */
.kapsayici { display: grid; place-items: center; }

/* Konumlandırılmış eleman */
.kutu {
  position: absolute;
  top: 50%; left: 50%;
  transform: translate(-50%, -50%);
}

/* Yalnızca yatay, blok eleman */
.kutu { width: 400px; margin-inline: auto; }
```

Kapsayıcının bir yüksekliği olmalıdır (ör. `min-height: 100vh`), aksi hâlde dikey ortalama görünmez.$md$, null, $md$easy$md$, $md$frontend-developer$md$, $md$html-css$md$),
  ($md$css-te-display-none-visibility-hidden-ve-opacity-0-arasindaki-fark-nedir$md$, $md$CSS'te display: none, visibility: hidden ve opacity: 0 arasındaki fark nedir?$md$, $md$| Özellik | Yer kaplar mı? | Tıklanabilir mi? | Ekran okuyucu okur mu? |
| --- | --- | --- | --- |
| `display: none` | Hayır, akıştan çıkar | Hayır | Hayır |
| `visibility: hidden` | Evet, boşluk kalır | Hayır | Hayır |
| `opacity: 0` | Evet | **Evet** | Evet |

`opacity` ve `visibility` geçiş (transition) ile animasyon yapılabilir, `display` yapılamaz.

Bir metni görsel olarak gizleyip **ekran okuyuculara bırakmak** için ayrı bir "visually-hidden" sınıfı kullanılır:

```css
.sr-only {
  position: absolute; width: 1px; height: 1px;
  overflow: hidden; clip: rect(0 0 0 0); white-space: nowrap;
}
```$md$, null, $md$medium$md$, $md$frontend-developer$md$, $md$html-css$md$),
  ($md$stacking-context-nedir-z-index-neden-bazen-calismaz$md$, $md$Stacking context nedir? z-index neden bazen çalışmaz?$md$, $md$`z-index` yalnızca **aynı stacking context** içindeki elemanları sıralar. Bir eleman yeni bir stacking context oluşturursa, çocuklarının z-index'i ne kadar büyük olursa olsun o context'in dışına çıkamaz.

Yeni stacking context oluşturan durumlar:

- `position` relative/absolute + `z-index` değeri, ya da `position: fixed / sticky`
- `opacity` 1'den küçük
- `transform`, `filter`, `perspective`, `will-change`
- `isolation: isolate`
- Flex/grid çocuğu + `z-index`

Tipik sorun: bir modalın `z-index: 9999` olmasına rağmen başka bir kutunun altında kalması. Nedeni çoğunlukla modalın, `transform` veya `opacity` uygulanmış bir ebeveynin içinde olmasıdır. Çözüm: modalı `body` seviyesine taşımak (React'te **portal**).

`z-index` yalnızca konumlandırılmış elemanlarda ve flex/grid çocuklarında çalışır; `position: static` bir elemanda etkisizdir.$md$, null, $md$medium$md$, $md$frontend-developer$md$, $md$html-css$md$),
  ($md$rem-em-vh-ve-px-birimleri-arasindaki-fark-nedir$md$, $md$rem, em, %, vh ve px birimleri arasındaki fark nedir?$md$, $md$- **px:** sabit piksel (cihaz piksel oranına göre ölçeklenir)
- **em:** elemanın **kendi** font boyutuna göredir (font-size'da kullanılırsa ebeveyninkine). İç içe kullanımda katlanarak büyür.
- **rem:** **kök** (`html`) font boyutuna göredir. Tahmin edilebilir olduğu için tipografi ve boşluklarda tercih edilir.
- **%:** ebeveynin ilgili ölçüsüne göredir
- **vh / vw:** görünüm alanının (viewport) yüksekliğinin / genişliğinin %1'i. Mobilde adres çubuğu sorunu için `dvh` (dynamic viewport) kullanılır.

Kullanıcının tarayıcıda yazı boyutunu büyütmesine saygı duymak için font boyutlarında `rem` kullanmak erişilebilirlik açısından önemlidir.$md$, null, $md$easy$md$, $md$frontend-developer$md$, $md$html-css$md$),
  ($md$mobile-first-tasarim-ve-media-query-ler-nasil-kullanilir$md$, $md$Mobile-first tasarım ve media query'ler nasıl kullanılır?$md$, $md$**Mobile-first**, temel stillerin en küçük ekran için yazılması, daha büyük ekranlar için `min-width` media query'leriyle eklemeler yapılmasıdır. Mobil cihaz gereksiz stil yüklemez ve CSS daha sade kalır.

```css
.kartlar { display: grid; gap: 16px; grid-template-columns: 1fr; }

@media (min-width: 640px) {
  .kartlar { grid-template-columns: repeat(2, 1fr); }
}
@media (min-width: 1024px) {
  .kartlar { grid-template-columns: repeat(3, 1fr); }
}

/* Çoğu zaman media query'siz de mümkün */
.kartlar { grid-template-columns: repeat(auto-fill, minmax(260px, 1fr)); }
```

Modern CSS'te **container query** (`@container`) ile bileşenler ekran yerine kendi kapsayıcılarının genişliğine göre de uyarlanabilir.$md$, null, $md$medium$md$, $md$frontend-developer$md$, $md$html-css$md$),
  ($md$css-grid-de-fr-birimi-auto-fill-ve-auto-fit-nedir$md$, $md$CSS Grid'de fr birimi, auto-fill ve auto-fit nedir?$md$, $md$- **fr:** kalan boş alanın bir payı. `1fr 2fr` ikinci sütuna iki kat alan verir.
- **repeat(auto-fill, minmax(200px, 1fr)):** sığabildiği kadar sütun oluşturur; eleman az olsa bile **boş sütunlar** yerini korur.
- **repeat(auto-fit, minmax(200px, 1fr)):** aynısını yapar ama boş sütunları **daraltır**, mevcut elemanlar genişleyip satırı doldurur.

```css
.galeri {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
  gap: 16px;
}

.sayfa {
  display: grid;
  grid-template-areas:
    "ust ust"
    "yan icerik";
  grid-template-columns: 240px 1fr;
}
```$md$, null, $md$medium$md$, $md$frontend-developer$md$, $md$html-css$md$),
  ($md$pseudo-class-ile-pseudo-element-arasindaki-fark-nedir$md$, $md$Pseudo-class ile pseudo-element arasındaki fark nedir?$md$, $md$- **Pseudo-class** (`:`): elemanın bir **durumunu** seçer: `:hover`, `:focus-visible`, `:nth-child(2n)`, `:disabled`, `:checked`, `:has()`
- **Pseudo-element** (`::`): elemanın sanal bir **parçasını** oluşturur veya seçer: `::before`, `::after`, `::placeholder`, `::selection`, `::first-line`

```css
a:hover { text-decoration: underline; }
li:nth-child(odd) { background: #f6f8f7; }
.kart:has(img) { padding-top: 0; }           /* "ebeveyn seçici" */

.zorunlu::after { content: " *"; color: crimson; }
```

`::before` ve `::after` çalışması için `content` özelliği gerekir (boş bile olsa: `content: ""`).$md$, null, $md$medium$md$, $md$frontend-developer$md$, $md$html-css$md$),
  ($md$css-degiskenleri-custom-properties-nedir-sass-degiskenlerinden-farki-nedir$md$, $md$CSS değişkenleri (custom properties) nedir? Sass değişkenlerinden farkı nedir?$md$, $md$CSS değişkenleri `--ad: değer` ile tanımlanır, `var(--ad)` ile kullanılır.

```css
:root { --vurgu: #0e6f63; --bosluk: 16px; }
.btn { background: var(--vurgu); padding: var(--bosluk); }

.koyu-tema { --vurgu: #4fc3b0; }   /* bu alt ağaçta değer değişir */
```

Sass değişkenleri **derleme zamanında** sabit değere dönüşür ve tarayıcıda yoktur. CSS değişkenleri ise **çalışma zamanında** yaşar:

- Cascade ve kalıtıma uyar, bir alt ağaçta yeniden tanımlanabilir
- JavaScript ile değiştirilebilir: `el.style.setProperty("--vurgu", renk)`
- Media query içinde değiştirilerek tema (açık/koyu) yapılabilir

Tasarım sistemlerinde renk ve boşluk token'ları için standart yöntemdir.$md$, null, $md$easy$md$, $md$frontend-developer$md$, $md$html-css$md$),
  ($md$bem-css-modules-ve-tailwind-css-yaklasimlarini-karsilastirin$md$, $md$BEM, CSS Modules ve Tailwind CSS yaklaşımlarını karşılaştırın.$md$, $md$Hepsi büyük projelerde CSS'in global olmasından kaynaklanan çakışma sorununu çözmeye çalışır.

| Yaklaşım | Nasıl çalışır | Artı | Eksi |
| --- | --- | --- | --- |
| **BEM** | `.kart__baslik--aktif` isimlendirme kuralı | Araç gerektirmez, okunabilir | Disiplin ister, isimler uzar |
| **CSS Modules** | Sınıf adları derlemede benzersizleştirilir (`Kart_baslik_x8f2`) | Gerçek kapsam, sade CSS | Dinamik stil için ek iş |
| **Tailwind** | Yardımcı (utility) sınıflar: `p-4 text-sm font-semibold` | Hızlı geliştirme, tutarlı tasarım token'ları, kullanılmayan CSS atılır | HTML kalabalıklaşır, öğrenme eğrisi |
| **CSS-in-JS** (styled-components) | Stil JavaScript'te yazılır | Prop'a göre dinamik stil | Çalışma zamanı maliyeti, RSC ile uyumsuzluk |

Bugün Next.js projelerinde Tailwind ve CSS Modules en yaygın tercihlerdir.$md$, null, $md$hard$md$, $md$frontend-developer$md$, $md$html-css$md$),
  ($md$reflow-layout-ve-repaint-nedir-performans-icin-neden-onemlidir$md$, $md$Reflow (layout) ve repaint nedir? Performans için neden önemlidir?$md$, $md$Tarayıcı bir sayfayı şu adımlarla çizer: **Style → Layout (reflow) → Paint → Composite**.

- **Reflow:** elemanların boyut ve konumlarının yeniden hesaplanması. En pahalı adımdır ve çoğu zaman tüm sayfayı etkiler. Tetikleyenler: `width`, `height`, `top`, `font-size` değişimi, DOM ekleme.
- **Repaint:** yerleşim değişmeden piksellerin yeniden boyanması: `color`, `background`, `box-shadow`.
- **Composite:** yalnızca GPU katmanlarının birleştirilmesi: `transform`, `opacity`. En ucuz adımdır.

Pratik kurallar:

- Animasyonlarda yalnızca `transform` ve `opacity` kullanın
- Okuma ve yazmayı karıştırmayın (layout thrashing):

```js
// Kötü: her turda zorunlu reflow
kutular.forEach(k => { k.style.width = k.offsetWidth + 10 + "px"; });

// İyi: önce hepsini oku, sonra hepsini yaz
const genislikler = kutular.map(k => k.offsetWidth);
kutular.forEach((k, i) => { k.style.width = genislikler[i] + 10 + "px"; });
```$md$, null, $md$medium$md$, $md$frontend-developer$md$, $md$html-css$md$),
  ($md$tarayicinin-kritik-render-yolu-critical-rendering-path-nedir$md$, $md$Tarayıcının kritik render yolu (critical rendering path) nedir?$md$, $md$Tarayıcının HTML'i ekranda piksele dönüştürme adımlarıdır:

1. **HTML → DOM** ağacı oluşturulur
2. **CSS → CSSOM** oluşturulur (CSS render'ı bloklar)
3. DOM + CSSOM birleşerek **Render Tree** oluşur (görünmeyen elemanlar hariç)
4. **Layout:** her elemanın boyut ve konumu hesaplanır
5. **Paint** ve **Composite:** pikseller boyanır, katmanlar birleştirilir

Hızlandırmak için:

- Kritik CSS'i satır içi vermek, geri kalanını geç yüklemek
- Script'leri `defer` veya `async` ile yüklemek (parser'ı bloklamaz)
- İlk ekrandaki büyük görseli `preload` / `fetchpriority="high"` ile önceliklendirmek
- Gereksiz web fontlarından kaçınmak, `font-display: swap` kullanmak$md$, null, $md$medium$md$, $md$frontend-developer$md$, $md$tarayici-ve-web-api$md$),
  ($md$script-etiketinde-async-ile-defer-arasindaki-fark-nedir$md$, $md$script etiketinde async ile defer arasındaki fark nedir?$md$, $md$- **Normal `<script>`:** HTML ayrıştırmayı durdurur, script'i indirir ve çalıştırır, sonra devam eder.
- **`async`:** script paralel indirilir, **iner inmez** çalışır (ayrıştırmayı o an keser). Çalışma sırası garanti değildir. Bağımsız script'ler (analitik, reklam) için uygundur.
- **`defer`:** script paralel indirilir, HTML **tamamen ayrıştırıldıktan sonra**, `DOMContentLoaded`'dan önce ve **yazıldığı sırayla** çalışır. DOM'a erişen uygulama kodu için doğru seçimdir.

```html
<script src="analitik.js" async></script>
<script src="kutuphane.js" defer></script>
<script src="uygulama.js" defer></script>   <!-- kutuphane.js'ten sonra çalışır -->
```

`type="module"` script'ler varsayılan olarak `defer` gibi davranır.$md$, null, $md$easy$md$, $md$frontend-developer$md$, $md$tarayici-ve-web-api$md$),
  ($md$localstorage-sessionstorage-cookie-ve-indexeddb-arasindaki-farklar-nelerdir$md$, $md$localStorage, sessionStorage, cookie ve IndexedDB arasındaki farklar nelerdir?$md$, $md$| | localStorage | sessionStorage | Cookie | IndexedDB |
| --- | --- | --- | --- | --- |
| Kapasite | ~5 MB | ~5 MB | ~4 KB | Yüzlerce MB |
| Ömür | Silinene kadar | Sekme kapanınca | Belirlenen süre | Silinene kadar |
| Sunucuya gider mi? | Hayır | Hayır | **Her istekte** | Hayır |
| API | Senkron, yalnızca string | Senkron, string | `document.cookie` | Asenkron, nesne ve dosya |

Güvenlik notu: **oturum token'larını localStorage'da tutmak riskli**dir; bir XSS açığında JavaScript tarafından okunabilir. Oturum için `HttpOnly`, `Secure`, `SameSite` işaretli çerezler tercih edilir.$md$, null, $md$medium$md$, $md$frontend-developer$md$, $md$tarayici-ve-web-api$md$),
  ($md$tarayici-onbellegi-nasil-calisir-cache-control-basliklari-nelerdir$md$, $md$Tarayıcı önbelleği nasıl çalışır? Cache-Control başlıkları nelerdir?$md$, $md$Sunucu, cevabın ne kadar süre ve nasıl önbelleğe alınabileceğini `Cache-Control` başlığıyla söyler:

- `max-age=31536000, immutable`: bir yıl boyunca sunucuya hiç sorma. Adında içerik hash'i olan dosyalar için (`app.3f9a1c.js`).
- `no-cache`: önbelleğe al ama her kullanımdan önce sunucuya **doğrulat** (ETag / Last-Modified ile; değişmediyse 304 döner).
- `no-store`: hiç saklama (hassas veriler)
- `public` / `private`: CDN gibi paylaşılan önbellekler saklayabilir mi
- `stale-while-revalidate=60`: bayat kopyayı hemen sun, arka planda yenile

Yaygın strateji: HTML için `no-cache` (her zaman güncel), hash'li JS/CSS/görseller için uzun `max-age` + `immutable`.$md$, null, $md$medium$md$, $md$frontend-developer$md$, $md$tarayici-ve-web-api$md$),
  ($md$intersectionobserver-ne-ise-yarar-ornek-kullanim-verin$md$, $md$IntersectionObserver ne işe yarar? Örnek kullanım verin.$md$, $md$`IntersectionObserver`, bir elemanın görünüm alanına (veya başka bir kapsayıcıya) girip çıkmasını **scroll event'i dinlemeden ve performanslı** şekilde bildirir.

Kullanım alanları: lazy loading, sonsuz kaydırma (infinite scroll), görünürlük analitiği, ekrana girince animasyon.

```js
const gozlemci = new IntersectionObserver((girdiler) => {
  for (const g of girdiler) {
    if (g.isIntersecting) {
      sonrakiSayfayiYukle();
    }
  }
}, { rootMargin: "200px" });   // 200px önceden tetikle

gozlemci.observe(document.querySelector("#liste-sonu"));
```

Scroll event'i her piksel kayışta ana thread'de çalışırken, IntersectionObserver hesaplamayı tarayıcıya bırakır.$md$, null, $md$medium$md$, $md$frontend-developer$md$, $md$tarayici-ve-web-api$md$),
  ($md$web-worker-nedir-service-worker-dan-farki-nedir$md$, $md$Web Worker nedir? Service Worker'dan farkı nedir?$md$, $md$JavaScript tarayıcıda tek bir ana thread'de çalışır; ağır hesaplamalar arayüzü dondurur.

- **Web Worker:** ağır hesaplamayı (görsel işleme, büyük JSON ayrıştırma, şifreleme) **ayrı bir thread'de** çalıştırır. DOM'a erişemez, ana thread ile `postMessage` üzerinden haberleşir. Sayfa kapanınca biter.
- **Service Worker:** sayfa ile ağ arasında duran bir **proxy**'dir. İstekleri yakalayıp önbellekten cevap verebilir; çevrimdışı çalışma, push bildirimleri ve arka plan senkronizasyonu sağlar. Sayfadan bağımsız yaşar. PWA'ların temelidir.

```js
// Web Worker
const worker = new Worker(new URL("./hesapla.js", import.meta.url));
worker.postMessage(buyukVeri);
worker.onmessage = (e) => goster(e.data);
```

Service Worker yalnızca HTTPS üzerinde çalışır.$md$, null, $md$hard$md$, $md$frontend-developer$md$, $md$tarayici-ve-web-api$md$),
  ($md$bir-url-yi-tarayiciya-yazip-enter-a-bastiginizda-neler-olur$md$, $md$Bir URL'yi tarayıcıya yazıp Enter'a bastığınızda neler olur?$md$, $md$Klasik bir mülakat sorusudur, adımları sırayla anlatmak beklenir:

1. **URL ayrıştırma:** protokol, alan adı, yol. HSTS listesindeyse doğrudan HTTPS.
2. **DNS çözümleme:** tarayıcı, işletim sistemi ve çözümleyici önbellekleri, gerekirse kök → TLD → yetkili sunucu.
3. **TCP bağlantısı** (üçlü el sıkışma) ve **TLS el sıkışması**; HTTP/3'te QUIC ile ikisi birleşir.
4. **HTTP isteği** gönderilir; sunucu (CDN, load balancer, uygulama) cevap döner.
5. **HTML ayrıştırma:** DOM oluşur; CSS, JS, görsel gibi alt kaynaklar için yeni istekler atılır.
6. **CSSOM, render tree, layout, paint, composite**
7. JavaScript çalışır, sayfa etkileşimli olur.

Mülakat seviyesine göre bir adımda derinleşmeniz istenebilir (DNS, TLS ya da render).$md$, $md$Tüm adımları yüzeysel saymak yerine, kendi alanınızla ilgili adımda (frontend için render) derinleşmek daha iyi izlenim bırakır.$md$, $md$medium$md$, $md$frontend-developer$md$, $md$tarayici-ve-web-api$md$),
  ($md$core-web-vitals-nedir-lcp-inp-ve-cls-neyi-olcer$md$, $md$Core Web Vitals nedir? LCP, INP ve CLS neyi ölçer?$md$, $md$Core Web Vitals, Google'ın kullanıcı deneyimini ölçen ve **arama sıralamasında** kullandığı üç metriktir:

| Metrik | Neyi ölçer | İyi değer |
| --- | --- | --- |
| **LCP** (Largest Contentful Paint) | En büyük içeriğin (genelde kapak görseli veya başlık) görünme süresi | ≤ 2,5 sn |
| **INP** (Interaction to Next Paint) | Kullanıcı etkileşimine (tıklama, yazma) arayüzün tepki süresi | ≤ 200 ms |
| **CLS** (Cumulative Layout Shift) | Sayfa yüklenirken içeriğin beklenmedik kayması | ≤ 0,1 |

İyileştirmeler:

- **LCP:** LCP görselini `priority` / `fetchpriority="high"` ile yüklemek, sunucu cevap süresini düşürmek, render'ı bloklayan kaynakları azaltmak
- **INP:** uzun JavaScript görevlerini bölmek, gereksiz render'ları azaltmak, ağır işi Web Worker'a taşımak
- **CLS:** görsellere `width`/`height` vermek, reklam ve embed'lere yer ayırmak, font yüklenirken kaymayı önlemek

INP, Mart 2024'te FID'in yerini almıştır.$md$, null, $md$medium$md$, $md$frontend-developer$md$, $md$web-performansi$md$),
  ($md$bir-web-sayfasinin-yukleme-performansini-nasil-iyilestirirsiniz$md$, $md$Bir web sayfasının yükleme performansını nasıl iyileştirirsiniz?$md$, $md$Önce **ölçmek** gerekir: Lighthouse, PageSpeed Insights (gerçek kullanıcı verisi), DevTools Performance ve Network sekmeleri.

Sonra en etkili adımlar:

- **Daha az JavaScript:** kod bölme, tree shaking, ağır kütüphanelerin hafif alternatifleri, sunucu bileşenleri
- **Görseller:** WebP/AVIF, doğru boyut (`srcset`), lazy loading, CDN
- **Önbellek:** hash'li statik dosyalara uzun `Cache-Control`, CDN
- **Sıkıştırma:** Brotli / gzip
- **Kritik yol:** render'ı bloklayan CSS/JS'i azaltmak, `defer`, kritik kaynaklar için `preload` / `preconnect`
- **Fontlar:** alt küme (subset), `font-display: swap`, kendi sunucunda barındırma
- **Sunucu:** SSR/SSG/ISR ile hazır HTML, düşük TTFB

Her değişiklikten sonra metrikleri yeniden ölçmek, tahminle optimizasyon yapmamak önemlidir.$md$, null, $md$medium$md$, $md$frontend-developer$md$, $md$web-performansi$md$),
  ($md$cok-uzun-bir-listeyi-on-binlerce-satir-performansli-nasil-gosterirsiniz$md$, $md$Çok uzun bir listeyi (on binlerce satır) performanslı nasıl gösterirsiniz?$md$, $md$Binlerce DOM düğümü oluşturmak hem render'ı hem kaydırmayı yavaşlatır. Çözümler:

1. **Sanallaştırma (virtualization / windowing):** yalnızca ekranda görünen satırlar (ve birkaç tampon satır) DOM'a eklenir; kaydırdıkça aynı düğümler yeniden kullanılır. Kütüphaneler: TanStack Virtual, react-window.
2. **Sayfalama** veya **sonsuz kaydırma:** veri parça parça yüklenir.
3. **Sunucu tarafında filtreleme ve sıralama:** istemciye tüm veri gönderilmez.
4. CSS ile tarayıcıya yardım: `content-visibility: auto` ekran dışı bölümlerin render'ını atlar.

```jsx
const sanal = useVirtualizer({
  count: satirlar.length,
  getScrollElement: () => kapRef.current,
  estimateSize: () => 40,
});
// sanal.getVirtualItems() ile yalnızca görünen ~20 satır çizilir
```

Ek olarak satır bileşeni `React.memo` ile sarılmalı ve `key` olarak kararlı id kullanılmalıdır.$md$, null, $md$hard$md$, $md$frontend-developer$md$, $md$web-performansi$md$),
  ($md$bundle-boyutunu-nasil-analiz-eder-ve-kucultursunuz$md$, $md$Bundle boyutunu nasıl analiz eder ve küçültürsünüz?$md$, $md$Analiz:

- `@next/bundle-analyzer`, `webpack-bundle-analyzer` veya `vite-bundle-visualizer` ile hangi paketin ne kadar yer kapladığını görsel olarak incelemek
- bundlephobia.com ile bir paketi eklemeden önce boyutunu kontrol etmek

Küçültme:

- **Dinamik import** ile ağır ve nadir kullanılan modülleri ayrı parçaya almak
- **Tree shaking**'e uygun içe aktarma: `import { debounce } from "lodash-es"` (tüm lodash yerine)
- Ağır paketleri hafif alternatiflerle değiştirmek: moment → date-fns / dayjs
- Polyfill'leri yalnızca gereken tarayıcılara göndermek
- Kullanılmayan bağımlılıkları kaldırmak
- React Server Components ile sunucuda kalabilecek kodu tarayıcıya hiç göndermemek$md$, null, $md$medium$md$, $md$frontend-developer$md$, $md$web-performansi$md$),
  ($md$web-erisilebilirligi-a11y-nedir-neden-onemlidir$md$, $md$Web erişilebilirliği (a11y) nedir, neden önemlidir?$md$, $md$Erişilebilirlik, görme, işitme, motor veya bilişsel engeli olan kişilerin de bir siteyi kullanabilmesidir. Ekran okuyucu, yalnızca klavye, büyütülmüş yazı veya ses komutu kullananları kapsar.

Önemi:

- Dünya nüfusunun yaklaşık %15'i bir tür engelle yaşıyor
- Birçok ülkede yasal zorunluluk; uluslararası standart **WCAG 2.2**
- Erişilebilir site genelde SEO açısından da daha iyidir (anlamlı HTML, alt metinler)

Temel kurallar:

- Anlamlı (semantik) HTML: `button`, `nav`, `main`, başlık sırası
- Tüm görsellerde anlamlı `alt` metni (dekoratifse `alt=""`)
- Her işlev klavyeyle yapılabilmeli, odak görünür olmalı
- Yeterli renk kontrastı (normal metin için en az 4.5:1)
- Form alanlarının `label`'ı olmalı, hatalar metinle açıklanmalı$md$, null, $md$easy$md$, $md$frontend-developer$md$, $md$erisilebilirlik$md$),
  ($md$aria-nedir-ne-zaman-kullanilmali-ne-zaman-kullanilmamali$md$, $md$ARIA nedir? Ne zaman kullanılmalı, ne zaman kullanılmamalı?$md$, $md$ARIA (Accessible Rich Internet Applications), HTML'in yetmediği durumlarda ekran okuyuculara ek anlam veren `role` ve `aria-*` niteliklerdir.

**ARIA'nın birinci kuralı: mümkünse kullanmayın.** Yerel HTML elemanı zaten doğru anlamı ve klavye davranışını sağlar.

```html
<!-- Kötü -->
<div role="button" tabindex="0" onclick="kaydet()">Kaydet</div>

<!-- İyi: Enter/Space ve odak kendiliğinden çalışır -->
<button onclick="kaydet()">Kaydet</button>
```

ARIA'nın gerçekten gerekli olduğu durumlar:

- `aria-expanded`, `aria-controls`: açılır menü ve akordeon durumu
- `aria-live="polite"` / `role="alert"`: dinamik bildirimleri okutmak
- `aria-label`: yalnızca ikon içeren butonlar
- `aria-current="page"`: aktif menü öğesi
- Sekme, combobox gibi karmaşık bileşenlerde WAI-ARIA desenleri

Yanlış ARIA, hiç ARIA olmamasından daha kötüdür.$md$, null, $md$medium$md$, $md$frontend-developer$md$, $md$erisilebilirlik$md$),
  ($md$bir-modal-dialog-bilesenini-erisilebilir-yapmak-icin-neler-gerekir$md$, $md$Bir modal (dialog) bileşenini erişilebilir yapmak için neler gerekir?$md$, $md$1. **Rol ve isim:** `role="dialog"`, `aria-modal="true"`, `aria-labelledby` ile başlığa bağlantı
2. **Odak yönetimi:** açılınca odak modalın içindeki ilk anlamlı elemana gider; kapanınca modalı açan butona geri döner
3. **Odak tuzağı (focus trap):** Tab tuşu modalın dışına çıkmamalı
4. **Escape** ile kapanma
5. **Arka plan:** sayfanın geri kalanı etkileşime kapalı olmalı (`inert` niteliği)
6. Kaydırmanın arka planda engellenmesi

Yerel `<dialog>` elemanı ve `showModal()` bunların çoğunu (odak tuzağı, Escape, arka planı devre dışı bırakma) kendiliğinden sağlar:

```html
<dialog id="onay" aria-labelledby="onay-baslik">
  <h2 id="onay-baslik">Silmek istediğinize emin misiniz?</h2>
  <button value="iptal">İptal</button>
  <button value="sil">Sil</button>
</dialog>
<script>document.getElementById("onay").showModal();</script>
```$md$, null, $md$medium$md$, $md$frontend-developer$md$, $md$erisilebilirlik$md$),
  ($md$unit-integration-ve-end-to-end-e2e-test-arasindaki-fark-nedir$md$, $md$Unit, integration ve end-to-end (E2E) test arasındaki fark nedir?$md$, $md$| Tür | Neyi test eder | Hız | Araçlar (frontend) |
| --- | --- | --- | --- |
| **Unit** | Tek bir fonksiyon veya bileşen, bağımlılıkları taklit edilerek (mock) | Çok hızlı | Vitest, Jest |
| **Integration** | Birkaç parçanın birlikte çalışması (form + doğrulama + API çağrısı) | Orta | Testing Library, MSW |
| **E2E** | Gerçek tarayıcıda baştan sona kullanıcı senaryosu | Yavaş | Playwright, Cypress |

**Test piramidi:** çok sayıda unit, daha az integration, az sayıda kritik E2E testi. Frontend'de bazı ekipler "testing trophy" yaklaşımıyla integration testlerine ağırlık verir, çünkü bunlar kullanıcı davranışına en yakın ve en iyi maliyet/fayda oranına sahip testlerdir.$md$, null, $md$medium$md$, $md$frontend-developer$md$, $md$test$md$),
  ($md$react-testing-library-nin-felsefesi-nedir-ornek-bir-test-yazin$md$, $md$React Testing Library'nin felsefesi nedir? Örnek bir test yazın.$md$, $md$Felsefe: **"Testleriniz yazılımın kullanıldığı şekle ne kadar benzerse, size o kadar güven verir."** Bileşenin iç state'ini veya implementasyon detaylarını değil, kullanıcının gördüğünü ve yaptığını test edin.

Elemanlar kullanıcının bulduğu şekilde aranır: önce `getByRole`, sonra `getByLabelText`, `getByText`. `data-testid` son çaredir.

```jsx
import { render, screen } from "@testing-library/react";
import userEvent from "@testing-library/user-event";

test("geçersiz e-postada hata mesajı gösterir", async () => {
  const kullanici = userEvent.setup();
  render(<KayitFormu />);

  await kullanici.type(screen.getByLabelText(/e-posta/i), "yanlis-adres");
  await kullanici.click(screen.getByRole("button", { name: /kayıt ol/i }));

  expect(screen.getByRole("alert")).toHaveTextContent("Geçerli bir e-posta girin");
});
```

Bu test, bileşen içeride `useState` yerine React Hook Form'a geçse bile bozulmaz.$md$, $md$API çağrılarını taklit etmek için fetch'i elle mock'lamak yerine MSW (Mock Service Worker) kullanıldığını bilmek artı puandır.$md$, $md$medium$md$, $md$frontend-developer$md$, $md$test$md$),
  ($md$testlerde-mock-stub-ve-spy-arasindaki-fark-nedir-ne-zaman-mock-kullanmamalisiniz$md$, $md$Testlerde mock, stub ve spy arasındaki fark nedir? Ne zaman mock kullanmamalısınız?$md$, $md$Hepsi "test dublörü" (test double) türleridir:

- **Stub:** sabit bir cevap döndüren sahte bağımlılık. "API çağrılınca şu veriyi dön."
- **Mock:** nasıl çağrıldığı **doğrulanan** sahte nesne. "Bu fonksiyon tam olarak bir kez, şu parametreyle çağrıldı mı?"
- **Spy:** gerçek fonksiyonu çalıştırmaya devam ederken çağrıları kaydeder.

```js
import { vi, expect, test } from "vitest";

test("kayıt sonrası e-posta gönderilir", async () => {
  const eposta = { gonder: vi.fn().mockResolvedValue(true) };   // mock
  await kullaniciKaydet({ ad: "Ayşe" }, eposta);
  expect(eposta.gonder).toHaveBeenCalledTimes(1);
});

const spy = vi.spyOn(console, "error");                           // spy
```

Aşırı mock kullanmak testleri **implementasyona bağımlı** ve kırılgan yapar: kod doğru çalışsa bile iç yapı değişince test bozulur. Kendi modüllerinizi değil, yalnızca sınırları (ağ, zaman, rastgelelik, dosya sistemi) taklit etmek iyi bir kuraldır.$md$, null, $md$medium$md$, $md$frontend-developer$md$, $md$test$md$),
  ($md$playwright-ile-e2e-testlerinde-flaky-kararsiz-testleri-nasil-onlersiniz$md$, $md$Playwright ile E2E testlerinde flaky (kararsız) testleri nasıl önlersiniz?$md$, $md$Flaky test, kod değişmeden bazen geçip bazen kalan testtir. En yaygın nedenler ve çözümleri:

- **Sabit beklemeler:** `waitForTimeout(2000)` yerine Playwright'ın **otomatik bekleyen** locator'larını ve `expect` kontrollerini kullanın.
- **Kırılgan seçiciler:** CSS sınıfı yerine kullanıcıya görünen rol ve metin: `getByRole("button", { name: "Kaydet" })`
- **Paylaşılan durum:** her test kendi verisini oluşturmalı; testler birbirine ve çalışma sırasına bağımlı olmamalı.
- **Dış servisler:** ağ isteklerini `page.route` ile taklit etmek
- **Zaman ve animasyon:** saat taklidi, animasyonları kapatmak

```ts
import { test, expect } from "@playwright/test";

test("soru ekleme formu", async ({ page }) => {
  await page.goto("/soru-ekle");
  await page.getByLabel("Soru").fill("Closure nedir?");
  await page.getByRole("button", { name: "Gönder" }).click();
  await expect(page.getByRole("status")).toHaveText(/onaya gönderildi/);
});
```

CI'da `retries` ve **trace viewer** ile başarısız testin adım adım kaydını incelemek, kökü bulmayı kolaylaştırır; ama retry asıl sorunu gizlememelidir.$md$, null, $md$hard$md$, $md$frontend-developer$md$, $md$test$md$),
  ($md$sql-injection-nedir-ve-nasil-onlenir$md$, $md$SQL injection nedir ve nasıl önlenir?$md$, $md$**SQL injection**, kullanıcı girdisinin doğrudan SQL metnine eklenmesiyle saldırganın sorgunun yapısını değiştirebilmesidir.

```js
// YANLIŞ: string birleştirme
const sql = `SELECT * FROM users WHERE email = '${email}'`;
// email = "' OR '1'='1" girilirse tüm kullanıcılar döner
```

Girdi, sorgunun bir parçası değil **veri** olarak gönderilmelidir:

```js
// DOĞRU: parametreli sorgu (prepared statement)
const { rows } = await pool.query(
  "SELECT * FROM users WHERE email = $1",
  [email]
);
```

### Savunma katmanları

- **Parametreli sorgu / prepared statement:** asıl çözüm budur. Veritabanı sürücüsü değeri sorgudan ayrı gönderir.
- **ORM / query builder:** (Prisma, Sequelize, SQLAlchemy) varsayılan olarak parametre kullanır; ancak `raw` sorgularda yine dikkat gerekir.
- **En az yetki:** uygulamanın DB kullanıcısı `DROP` veya başka şemalara erişim yetkisine sahip olmamalı.
- **Beyaz liste:** tablo/kolon adı veya `ORDER BY` alanı gibi parametrelenemeyen kısımlar izin verilen değerler listesinden seçilmeli.
- Girdi doğrulama ve hata mesajlarında sorgu detayı göstermemek ek katmandır, tek başına yeterli değildir.

"Tırnakları escape ederim" cevabı zayıftır; mülakatta parametreli sorguyu öne çıkarın.$md$, $md$Kolon adı ve ORDER BY gibi parametrelenemeyen alanlar için beyaz liste kullanacağınızı söylemek, konuyu gerçekten bildiğinizi gösterir.$md$, $md$easy$md$, $md$full-stack-developer$md$, $md$web-guvenligi$md$),
  ($md$parolalar-veritabaninda-nasil-saklanmalidir-bcrypt-ve-argon2-neden-tercih-edilir$md$, $md$Parolalar veritabanında nasıl saklanmalıdır? bcrypt ve Argon2 neden tercih edilir?$md$, $md$Parolalar **asla** düz metin veya geri çözülebilir şifreleme ile saklanmaz. Tek yönlü, **yavaş** ve **salt'lı** bir hash fonksiyonu kullanılır.

### Neden MD5 / SHA-256 yetmez?

Bu fonksiyonlar hız için tasarlanmıştır. Bir GPU saniyede milyarlarca SHA-256 hesaplayabilir; sızan bir veritabanında kaba kuvvet ve sözlük saldırısı çok hızlı olur.

### Doğru yaklaşım

- **Salt:** her kullanıcıya özel rastgele değer. Aynı parolalar farklı hash üretir, rainbow table işe yaramaz. bcrypt ve Argon2 salt'ı hash'in içinde saklar.
- **Maliyet (work factor):** hash'i kasıtlı olarak yavaşlatır (ör. ~100–300 ms). Donanım geliştikçe artırılabilir.
- **Argon2id:** güncel öneri; CPU yanında **bellek** maliyeti de olduğundan GPU/ASIC saldırılarına daha dayanıklı. bcrypt hâlâ güvenli ve yaygın.

```js
import bcrypt from "bcrypt";

const hash = await bcrypt.hash(password, 12); // cost = 12
// kayıt: users.password_hash = hash

const ok = await bcrypt.compare(girilenParola, user.password_hash);
```

### Ek noktalar

- Karşılaştırma kütüphanenin `compare` fonksiyonuyla yapılır (sabit zamanlı).
- İsteğe bağlı **pepper**: uygulama sırrı olarak ayrı saklanan ek gizli değer.
- Giriş denemelerine rate limit ve hesap kilitleme eklenir.
- bcrypt girdiyi 72 byte ile sınırlar; çok uzun parolalarda bu bilinmelidir.$md$, null, $md$medium$md$, $md$full-stack-developer$md$, $md$web-guvenligi$md$),
  ($md$owasp-top-10-nedir-en-onemli-maddelerini-ozetleyin$md$, $md$OWASP Top 10 nedir? En önemli maddelerini özetleyin.$md$, $md$**OWASP Top 10**, web uygulamalarındaki en kritik güvenlik risklerinin periyodik olarak güncellenen listesidir. Ezber sıra değil, kategorileri ve örneklerini bilmek önemlidir.

| Kategori | Örnek | Önlem |
| --- | --- | --- |
| Broken Access Control | `/api/orders/124` ile başkasının siparişini görmek (IDOR) | Her istekte sunucuda sahiplik/rol kontrolü |
| Cryptographic Failures | Parolanın MD5 ile saklanması, HTTP üzerinden veri | TLS, güçlü hash, hassas veriyi şifreleme |
| Injection | SQL, NoSQL, komut injection, XSS | Parametreli sorgu, çıktı encode |
| Insecure Design | Rate limit olmayan şifre sıfırlama | Tehdit modelleme, güvenli tasarım |
| Security Misconfiguration | Açık debug modu, varsayılan şifreler | Sıkılaştırma, güvenlik başlıkları |
| Vulnerable Components | Açığı olan eski npm paketi | `npm audit`, Dependabot, güncelleme |
| Authentication Failures | Brute force'a açık giriş, zayıf oturum | MFA, rate limit, güvenli session |
| Integrity Failures | İmzasız güncelleme, güvensiz deserialization | İmza doğrulama, güvenilir CI/CD |
| Logging and Monitoring Failures | Saldırının fark edilmemesi | Merkezi log, alarm |
| SSRF | Sunucunun kullanıcı verdiği URL'ye istek atması | URL beyaz listesi, iç ağ erişimini kısıtlama |

Listenin başında yer alan **Broken Access Control**, pratikte en sık karşılaşılan sorundur: frontend'de butonu gizlemek yetkilendirme değildir, kontrol her zaman sunucuda yapılmalıdır.$md$, $md$Liste sürümleri arasında sıra değişir; sıra numarası ezberlemek yerine her kategori için kendi projenizden bir örnek ve önlem anlatın.$md$, $md$medium$md$, $md$full-stack-developer$md$, $md$web-guvenligi$md$),
  ($md$content-security-policy-csp-nedir-ve-nasil-yapilandirilir$md$, $md$Content Security Policy (CSP) nedir ve nasıl yapılandırılır?$md$, $md$**CSP**, tarayıcıya sayfanın hangi kaynaklardan script, stil, görsel vb. yükleyebileceğini söyleyen bir HTTP yanıt başlığıdır. XSS'e karşı **ikinci savunma hattıdır**: saldırgan bir script enjekte etse bile tarayıcı onu çalıştırmaz.

```http
Content-Security-Policy:
  default-src 'self';
  script-src 'self' 'nonce-r4nd0m123';
  style-src 'self';
  img-src 'self' data: https://cdn.example.com;
  connect-src 'self' https://api.example.com;
  frame-ancestors 'none';
  object-src 'none';
  base-uri 'self'
```

### Önemli direktifler

- `default-src`: diğerleri tanımlı değilse varsayılan.
- `script-src`: en kritik olanı. `'unsafe-inline'` ve `'unsafe-eval'` kullanmak CSP'nin faydasını büyük ölçüde yok eder.
- `connect-src`: `fetch`/WebSocket hedefleri.
- `frame-ancestors`: sayfanın iframe içine alınmasını engeller (clickjacking).

### Nonce ve strict-dynamic

Inline script gerekiyorsa her yanıtta rastgele bir **nonce** üretilir ve yalnızca o nonce'u taşıyan script çalışır:

```html
<script nonce="r4nd0m123">initApp();</script>
```

`'strict-dynamic'` ile güvenilen script'in yüklediği script'lere de izin verilir; uzun domain listeleri yerine önerilen modern yaklaşımdır.

### Kademeli geçiş

Mevcut uygulamada önce `Content-Security-Policy-Report-Only` ile ihlaller toplanır (`report-to`), kırılan yerler düzeltilir, sonra zorunlu moda geçilir.$md$, $md$CSP'nin XSS'in yerine geçmediğini, çıktı encode etmenin hâlâ birinci savunma olduğunu vurgulayın.$md$, $md$hard$md$, $md$full-stack-developer$md$, $md$web-guvenligi$md$),
  ($md$guvenli-cookie-ayarlari-nelerdir-session-hijacking-nasil-onlenir$md$, $md$Güvenli cookie ayarları nelerdir? Session hijacking nasıl önlenir?$md$, $md$**Session hijacking**, saldırganın kullanıcının oturum kimliğini (session ID / token) ele geçirip onun yerine istek atmasıdır. Kimlik genelde cookie'de taşındığı için cookie ayarları kritiktir.

```http
Set-Cookie: sid=abc123; HttpOnly; Secure; SameSite=Lax; Path=/; Max-Age=3600
```

| Bayrak | Ne yapar? | Neye karşı korur? |
| --- | --- | --- |
| `HttpOnly` | JavaScript `document.cookie` ile okuyamaz | XSS ile token çalınması |
| `Secure` | Yalnızca HTTPS üzerinden gönderilir | Ağ dinleme (MITM) |
| `SameSite=Lax/Strict` | Siteler arası isteklerde cookie gönderimini kısıtlar | CSRF |
| `Max-Age / Expires` | Ömrü sınırlar | Uzun süre geçerli çalıntı oturum |
| `__Host-` öneki | Secure, Path=/ ve Domain'siz olmayı zorunlu kılar | Alt alan adından cookie ezme |

### Diğer önlemler

- **Girişten sonra session ID yenileme:** session fixation saldırısını önler.
- Kısa ömürlü oturum + kullanıcı hareketsizliğinde zaman aşımı.
- Çıkışta sunucu tarafında oturumu gerçekten geçersiz kılma.
- Şifre değişince tüm oturumları sonlandırma.
- Session ID tahmin edilemez olmalı (kriptografik rastgele, en az 128 bit).
- Şüpheli değişikliklerde (ülke, cihaz) yeniden doğrulama istemek.

Token'ı `localStorage`'da tutmak XSS durumunda doğrudan okunabilmesi anlamına gelir; HttpOnly cookie bu açıdan daha güvenlidir.$md$, null, $md$medium$md$, $md$full-stack-developer$md$, $md$web-guvenligi$md$),
  ($md$authentication-ile-authorization-arasindaki-fark-nedir$md$, $md$Authentication ile authorization arasındaki fark nedir?$md$, $md$- **Authentication (kimlik doğrulama):** "Sen kimsin?" sorusunun cevabı. Kullanıcı adı/parola, OAuth ile Google girişi, MFA.
- **Authorization (yetkilendirme):** "Bunu yapmaya iznin var mı?" Kimliği bilinen kullanıcının hangi kaynağa, hangi işlemle erişebileceği.

Sıra her zaman önce kimlik doğrulama, sonra yetkilendirmedir. HTTP'de karşılıkları: kimlik yoksa/geçersizse **401**, kimlik var ama yetki yoksa **403**.

### Yaygın yetkilendirme modelleri

- **RBAC (rol tabanlı):** `admin`, `editor`, `viewer` gibi roller ve izinleri.
- **ABAC (öznitelik tabanlı):** "kullanıcı yalnızca kendi departmanının belgelerini düzenleyebilir" gibi kurallar.
- **Sahiplik kontrolü:** kaynak kullanıcının mı?

```js
app.delete("/api/posts/:id", requireAuth, async (req, res) => {
  const post = await Post.findById(req.params.id);
  if (!post) return res.sendStatus(404);
  // authorization: sahibi veya admin mi?
  if (post.authorId !== req.user.id && req.user.role !== "admin") {
    return res.sendStatus(403);
  }
  await post.deleteOne();
  res.sendStatus(204);
});
```

En sık yapılan hata, yalnızca giriş yapılmış olmayı kontrol edip kaynağın sahipliğini kontrol etmemektir (IDOR).$md$, null, $md$easy$md$, $md$full-stack-developer$md$, $md$web-guvenligi$md$),
  ($md$websocket-server-sent-events-sse-ve-polling-arasindaki-farklar-nelerdir$md$, $md$WebSocket, Server-Sent Events (SSE) ve polling arasındaki farklar nelerdir?$md$, $md$Sunucudan istemciye gerçek zamanlıya yakın veri iletmenin üç yaygın yolu:

| Yöntem | Yön | Bağlantı | Uygun senaryo |
| --- | --- | --- | --- |
| Short polling | İstemci sorar | Her seferinde yeni HTTP isteği | Seyrek güncellenen veri, basitlik |
| Long polling | İstemci sorar, sunucu veri olana kadar bekletir | İstek başına bir bağlantı | WebSocket kullanılamayan ortamlar |
| SSE | Tek yön: sunucudan istemciye | Kalıcı HTTP bağlantısı, metin akışı | Bildirim, canlı skor, LLM token akışı |
| WebSocket | Çift yön | Kalıcı TCP bağlantısı, kendi protokolü | Sohbet, oyun, ortak düzenleme |

```js
// SSE: tarayıcı yeniden bağlanmayı kendisi yapar
const es = new EventSource("/api/events");
es.onmessage = (e) => console.log(JSON.parse(e.data));

// WebSocket
const ws = new WebSocket("wss://example.com/ws");
ws.onmessage = (e) => console.log(e.data);
ws.send(JSON.stringify({ type: "typing" }));
```

### Seçim kriterleri

- Yalnızca sunucu push ediyorsa **SSE** daha basittir: düz HTTP, otomatik yeniden bağlanma, `Last-Event-ID` ile kaldığı yerden devam.
- İstemci de sık mesaj gönderiyorsa **WebSocket**.
- WebSocket kalıcı bağlantı olduğu için yatay ölçeklemede **sticky session** veya sunucular arası pub/sub (Redis) gerekir.
- Gerçek zaman gereksinimi zayıfsa polling en az altyapı gerektiren çözümdür.$md$, $md$Yalnızca sunucudan istemciye akış varsa SSE önermek, her şeye WebSocket demekten daha olgun bir cevap olarak görülür.$md$, $md$medium$md$, $md$full-stack-developer$md$, $md$web-mimarisi$md$),
  ($md$backend-for-frontend-bff-deseni-nedir-ne-zaman-kullanilir$md$, $md$Backend for Frontend (BFF) deseni nedir, ne zaman kullanılır?$md$, $md$**BFF**, her istemci türü (web, mobil, admin paneli) için ayrı, o istemcinin ihtiyacına göre şekillenmiş ince bir backend katmanı oluşturmaktır. Bu katman arka plandaki mikroservisleri çağırır, veriyi birleştirir ve istemciye uygun formatta döner.

```text
Web App    -> Web BFF    -+
                          +-> Kullanıcı Servisi
Mobil App  -> Mobil BFF  -+-> Sipariş Servisi
                          +-> Ödeme Servisi
```

### Faydaları

- **Daha az istek:** istemci 5 servise ayrı istek atmak yerine BFF'ye tek istek atar.
- **İstemciye özel veri:** mobil için daha küçük yanıt, web için daha zengin.
- **Güvenlik:** token'lar sunucuda tutulup tarayıcıya yalnızca HttpOnly session cookie verilebilir. Bu, SPA'larda önerilen bir OAuth yaklaşımıdır.
- Frontend ekibi kendi BFF'sini sahiplenip bağımsız hareket edebilir.

### Dezavantajları

- Kod tekrarı riski: ortak mantık BFF'lere dağılabilir.
- Ek bir deploy edilen ve izlenen bileşen, ek ağ adımı.

### Ne zaman?

Birden fazla istemci türü ve birden fazla backend servisi olduğunda mantıklıdır. Tek bir web uygulaması ve monolit backend varsa genellikle gereksiz karmaşıklıktır. Next.js Route Handler'ları veya GraphQL gateway pratikte BFF rolü üstlenebilir.$md$, null, $md$medium$md$, $md$full-stack-developer$md$, $md$web-mimarisi$md$),
  ($md$buyuk-dosya-yukleme-akisini-nasil-tasarlarsiniz-presigned-url-nedir$md$, $md$Büyük dosya yükleme akışını nasıl tasarlarsınız? Presigned URL nedir?$md$, $md$Dosyayı uygulama sunucusunun üzerinden geçirmek bant genişliği, bellek ve zaman aşımı sorunları yaratır. Yaygın çözüm, istemcinin dosyayı **doğrudan nesne depolamaya** (S3, GCS) yüklemesidir.

**Presigned URL**, backend'in kısa süreli ve belirli bir işlem (ör. tek bir anahtara PUT) için imzaladığı URL'dir. İstemci depolama kimlik bilgilerine sahip olmadan yükleme yapabilir.

### Akış

1. İstemci backend'e dosya adı, boyut ve tür bildirir: `POST /api/uploads`.
2. Backend yetki, boyut ve MIME türünü kontrol eder, rastgele bir anahtar üretir (`uploads/u42/uuid.pdf`), veritabanına `pending` kayıt açar ve presigned URL döner.
3. İstemci dosyayı bu URL'ye doğrudan `PUT` eder; ilerleme çubuğu gösterilebilir.
4. Yükleme bitince istemci backend'e haber verir veya depolama servisi bir olay (S3 event) tetikler.
5. Backend dosyayı doğrular (gerçek boyut, tür, virüs taraması), küçük resim gibi işlemleri kuyruğa atar ve kaydı `ready` yapar.

```js
import { PutObjectCommand } from "@aws-sdk/client-s3";
import { getSignedUrl } from "@aws-sdk/s3-request-presigner";

const key = `uploads/${user.id}/${crypto.randomUUID()}`;
const url = await getSignedUrl(
  s3,
  new PutObjectCommand({ Bucket: "app-files", Key: key, ContentType: type }),
  { expiresIn: 300 }
);
```

### Dikkat edilecekler

- Çok büyük dosyalarda **multipart upload**: parçalar paralel yüklenir, kopan parça yeniden denenir.
- Kullanıcının verdiği dosya adı anahtar olarak kullanılmaz (path traversal, çakışma).
- Bucket private olmalı; indirme de kısa ömürlü presigned GET URL veya CDN imzalı URL ile yapılmalı.
- Tamamlanmayan `pending` kayıtlar ve yetim dosyalar için temizlik işi (lifecycle kuralı).$md$, $md$Yüklemenin ardından sunucu tarafında dosyayı yeniden doğrulamanız gerektiğini söyleyin; istemcinin bildirdiği MIME türüne güvenilmez.$md$, $md$hard$md$, $md$full-stack-developer$md$, $md$web-mimarisi$md$),
  ($md$bir-kullanici-girisinin-uctan-uca-akisini-frontend-den-veritabanina-anlatin$md$, $md$Bir kullanıcı girişinin uçtan uca akışını (frontend'den veritabanına) anlatın.$md$, $md$Cookie tabanlı oturum kullanan tipik bir web uygulaması için:

1. **Form:** kullanıcı e-posta ve parolayı girer. Frontend temel doğrulama yapar (boş alan, format), ama asıl doğrulama sunucudadır.
2. **İstek:** `POST /api/auth/login` HTTPS üzerinden JSON ile gönderilir.
3. **Rate limit:** IP ve hesap bazında deneme sayısı kontrol edilir.
4. **Kullanıcı bulma:** e-postaya göre kullanıcı çekilir. Kullanıcı yoksa da parola hatası ile **aynı mesaj** döner ("E-posta veya parola hatalı"), böylece hesap varlığı sızdırılmaz.
5. **Parola doğrulama:** `bcrypt.compare` ile hash karşılaştırılır.
6. **MFA (varsa):** ikinci adım istenir.
7. **Oturum oluşturma:** rastgele session ID üretilir, Redis/DB'ye `{userId, expiresAt}` yazılır. Eski session ID varsa yenilenir.
8. **Yanıt:** `Set-Cookie: sid=...; HttpOnly; Secure; SameSite=Lax` ve kullanıcı bilgisi döner.
9. **Frontend:** kullanıcı state'i güncellenir (context/store), korumalı sayfaya yönlendirilir.
10. **Sonraki istekler:** tarayıcı cookie'yi otomatik gönderir; middleware oturumu doğrular ve `req.user` ekler.
11. **Çıkış:** sunucuda oturum silinir, cookie temizlenir.

```js
app.post("/api/auth/login", loginLimiter, async (req, res) => {
  const user = await db.user.findUnique({ where: { email: req.body.email } });
  const ok = user && (await bcrypt.compare(req.body.password, user.passwordHash));
  if (!ok) return res.status(401).json({ error: "E-posta veya parola hatalı" });

  req.session.regenerate(() => {
    req.session.userId = user.id;
    res.json({ id: user.id, name: user.name });
  });
});
```

Token (JWT) tabanlı yaklaşımda 7. adımda kısa ömürlü access token ve HttpOnly cookie'de refresh token üretilir; access token süresi dolunca frontend sessizce yeniler.$md$, null, $md$medium$md$, $md$full-stack-developer$md$, $md$web-mimarisi$md$),
  ($md$mvc-mimarisi-nedir-modern-web-uygulamalarinda-nasil-karsilik-bulur$md$, $md$MVC mimarisi nedir? Modern web uygulamalarında nasıl karşılık bulur?$md$, $md$**MVC (Model-View-Controller)**, uygulamayı üç sorumluluğa ayıran bir mimari desendir:

- **Model:** veri ve iş kuralları. Veritabanı erişimi, doğrulama.
- **View:** kullanıcıya gösterilen arayüz. Veriyi sunar, iş mantığı içermez.
- **Controller:** isteği karşılar, modeli çağırır, sonucu uygun view'a veya yanıta dönüştürür.

```text
İstek -> Router -> Controller -> Model (DB)
                       |
                       v
                View / JSON yanıt
```

```js
// Express'te basit bir controller
export async function show(req, res) {
  const product = await Product.findById(req.params.id); // Model
  if (!product) return res.status(404).render("404");
  res.render("products/show", { product });             // View
}
```

### Modern karşılıkları

- Rails, Laravel, Django (MTV), ASP.NET MVC klasik sunucu taraflı MVC'dir.
- SPA + API mimarisinde backend genelde **View'siz** çalışır: controller JSON döner, view rolünü React/Vue üstlenir.
- Büyüyen projelerde "fat controller" sorununu önlemek için iş mantığı **service** katmanına taşınır: Controller -> Service -> Repository.

Faydası sorumlulukların ayrılması, test edilebilirlik ve ekip içinde paralel çalışabilmektir.$md$, null, $md$easy$md$, $md$full-stack-developer$md$, $md$web-mimarisi$md$),
  ($md$monorepo-nedir-avantajlari-dezavantajlari-ve-araclari-nelerdir$md$, $md$Monorepo nedir? Avantajları, dezavantajları ve araçları nelerdir?$md$, $md$**Monorepo**, birden fazla projenin (frontend, backend, ortak kütüphaneler) tek bir Git deposunda tutulmasıdır. Monolit ile karıştırılmamalı: uygulamalar yine bağımsız deploy edilebilir.

```text
repo/
  apps/
    web/        (Next.js)
    api/        (Node.js)
    mobile/
  packages/
    ui/         (ortak bileşenler)
    types/      (paylaşılan TypeScript tipleri)
    config/     (eslint, tsconfig)
```

### Avantajlar

- **Atomik değişiklik:** API sözleşmesi ve onu kullanan frontend tek PR'da değişir.
- **Kod paylaşımı:** ortak tipler ve UI kütüphanesi paket yayınlamadan kullanılır.
- Tek araç seti, tek CI yapılandırması, tutarlı bağımlılık sürümleri.

### Dezavantajlar

- Depo büyüdükçe CI süresi ve `git clone` yavaşlar.
- Sahiplik sınırları bulanıklaşabilir (CODEOWNERS ile yönetilir).
- Erişim kontrolü depo seviyesinde zordur.

### Araçlar

| Araç | Rolü |
| --- | --- |
| pnpm / npm / yarn workspaces | Paketleri birbirine bağlama |
| Turborepo | Görev orkestrasyonu, önbellek |
| Nx | Bağımlılık grafiği, etkilenen projeler, kod üretimi |
| Bazel | Çok dilli, çok büyük depolar |

Ölçeklenmenin anahtarı **etkilenen projeleri** bulup yalnızca onları build/test etmek ve **uzak önbellek** (remote cache) ile aynı işi tekrar yapmamaktır.$md$, null, $md$hard$md$, $md$full-stack-developer$md$, $md$web-mimarisi$md$),
  ($md$whatsapp-benzeri-bir-sohbet-uygulamasi-tasarlayin$md$, $md$WhatsApp benzeri bir sohbet uygulaması tasarlayın.$md$, $md$### 1. Gereksinimler

- Birebir ve grup mesajlaşma, çevrim içi durumu, okundu bilgisi, çevrim dışı kullanıcıya sonradan iletim.
- Düşük gecikme, mesaj kaybı olmaması, sıralama.

### 2. Bileşenler

- **Gateway / Chat sunucuları:** istemcilerle kalıcı **WebSocket** bağlantısı tutar.
- **Oturum servisi:** hangi kullanıcının hangi chat sunucusuna bağlı olduğunu tutar (Redis).
- **Mesaj servisi:** mesajı kalıcı olarak yazar ve iletimi tetikler.
- **Mesaj deposu:** yazma yoğun, `conversation_id` ile bölümlenmiş (Cassandra, ScyllaDB, DynamoDB).
- **Pub/Sub veya kuyruk:** chat sunucuları arası iletim (Redis Pub/Sub, Kafka).
- **Push bildirim servisi:** çevrim dışı kullanıcılar için APNs/FCM.
- **Medya:** dosyalar nesne depolamaya presigned URL ile, mesajda yalnızca referans.

### 3. Mesaj akışı

1. A, mesajı istemci tarafı `client_msg_id` ile kendi sunucusuna gönderir.
2. Mesaj servisi kaydeder, sıra numarası verir, A'ya **ack** döner (tek tik).
3. B'nin bağlı olduğu sunucu bulunur, mesaj pub/sub üzerinden iletilir.
4. B çevrim dışıysa push bildirimi gider; bağlandığında son okunan sıra numarasından sonraki mesajları çeker.
5. B'nin cihazı aldığında ve okuduğunda durum güncellemeleri A'ya iletilir.

### 4. Kritik noktalar

- **Sıralama:** konuşma bazında artan sıra numarası; global saat güvenilir değildir.
- **Tekrar gönderim:** `client_msg_id` ile idempotent yazma, çift mesaj oluşmaz.
- **Grup mesajı:** küçük gruplarda her üyeye fan-out; çok büyük kanallarda okurken çekme (fan-out on read).
- **Ölçek:** bağlantı sayısı darboğazdır; chat sunucuları yatay ölçeklenir, yük dengeleyici bağlantıları dağıtır.
- Uçtan uca şifreleme isteniyorsa sunucu yalnızca şifreli içeriği taşır.$md$, $md$Sistem tasarımında doğrudan çizime atlamayın; önce gereksinimleri ve ölçeği (günlük aktif kullanıcı, mesaj/saniye) netleştirmek için soru sorun.$md$, $md$hard$md$, $md$full-stack-developer$md$, $md$sistem-tasarimi$md$),
  ($md$bir-api-icin-rate-limiter-nasil-tasarlanir-hangi-algoritmalar-kullanilir$md$, $md$Bir API için rate limiter nasıl tasarlanır? Hangi algoritmalar kullanılır?$md$, $md$**Rate limiter**, bir istemcinin belirli sürede yapabileceği istek sayısını sınırlar: kötüye kullanımı, brute force'u ve aşırı yükü önler. Limit aşıldığında `429 Too Many Requests` ve `Retry-After` başlığı döner.

### Algoritmalar

| Algoritma | Mantık | Artı / Eksi |
| --- | --- | --- |
| Fixed window | Her dakika için sayaç | Basit; pencere sınırında 2 kat patlama olabilir |
| Sliding window log | Her isteğin zaman damgası saklanır | Kesin; bellek yoğun |
| Sliding window counter | İki pencerenin ağırlıklı ortalaması | İyi denge, yaygın |
| Token bucket | Kovaya sabit hızla token eklenir, istek token harcar | Kısa patlamalara izin verir; çok yaygın |
| Leaky bucket | İstekler kuyruktan sabit hızla çıkar | Çıkışı düzleştirir |

### Dağıtık uygulama

Birden fazla sunucu olduğunda sayaç ortak bir yerde, genelde **Redis**'te tutulur:

```js
// Fixed window: kullanıcı başına dakikada 100 istek
async function allow(userId) {
  const key = `rl:${userId}:${Math.floor(Date.now() / 60000)}`;
  const count = await redis.incr(key);
  if (count === 1) await redis.expire(key, 60);
  return count <= 100;
}
```

Token bucket gibi çok adımlı mantıkta yarış durumunu önlemek için işlem **Lua script** ile atomik yapılır.

### Tasarım kararları

- Anahtar: kullanıcı ID, API key veya IP (girişsiz istekler için).
- Nerede: API gateway (Nginx, Kong, Cloudflare) veya uygulama middleware'i.
- Redis erişilemezse: fail-open (izin ver) mi fail-closed mu, kararı açıkça verilmeli.
- Yanıtta `X-RateLimit-Remaining` gibi başlıklarla istemciye bilgi verilir.$md$, null, $md$medium$md$, $md$full-stack-developer$md$, $md$sistem-tasarimi$md$),
  ($md$bir-bildirim-notification-sistemi-nasil-tasarlanir$md$, $md$Bir bildirim (notification) sistemi nasıl tasarlanır?$md$, $md$### Gereksinimler

- Kanallar: uygulama içi, e-posta, SMS, mobil push.
- Kullanıcı tercihleri (hangi kanaldan, hangi tür bildirim), sessiz saatler.
- Yüksek hacim, yeniden deneme, aynı bildirimin iki kez gitmemesi.

### Mimari

```text
Servisler -> Notification API -> Kuyruk -> Kanal worker'ları -> Sağlayıcılar
 (sipariş,      (doğrulama,      (Kafka/    (email, sms,        (SES, Twilio,
  yorum...)      tercih, şablon)  SQS)       push, in-app)       FCM, APNs)
```

1. Olay üreten servis `{userId, type, data, idempotencyKey}` gönderir.
2. Notification servisi tercihleri ve sessiz saatleri kontrol eder, şablonu doldurur, kanal başına iş üretir.
3. Her kanal ayrı kuyruk ve worker'a sahiptir; SMS sağlayıcısının yavaşlaması e-postayı etkilemez.
4. Worker sağlayıcıyı çağırır; hata olursa **üstel geri çekilme (exponential backoff)** ile yeniden dener, kalıcı hatalar **dead-letter queue**'ya gider.
5. Durum (`queued`, `sent`, `delivered`, `failed`) veritabanına yazılır.

### Kritik noktalar

- **Idempotency:** kuyruklar genelde "en az bir kez" teslim eder; `idempotencyKey` ile tekrarlar elenir.
- **Uygulama içi bildirim:** veritabanına yazılır, kullanıcı çevrim içiyse WebSocket/SSE ile anında itilir, okunmamış sayısı cache'lenir.
- **Önceliklendirme:** şifre sıfırlama kodu ile pazarlama e-postası aynı kuyrukta beklememeli.
- **Toplama (batching):** "5 kişi gönderini beğendi" gibi birleştirme spam'i azaltır.
- Sağlayıcı kotaları için kanal bazında rate limit.$md$, null, $md$medium$md$, $md$full-stack-developer$md$, $md$sistem-tasarimi$md$),
  ($md$cdn-nedir-nasil-calisir-ve-hangi-durumlarda-kullanilir$md$, $md$CDN nedir, nasıl çalışır ve hangi durumlarda kullanılır?$md$, $md$**CDN (Content Delivery Network)**, içeriği dünyanın farklı bölgelerindeki **edge** sunucularda önbelleğe alarak kullanıcıya en yakın noktadan sunan dağıtık sunucu ağıdır. Cloudflare, CloudFront, Akamai, Fastly örnekleridir.

### Çalışma şekli

1. Alan adı DNS ile CDN'e yönlendirilir; kullanıcı coğrafi olarak yakın edge'e ulaşır.
2. Edge'de içerik varsa (**cache hit**) doğrudan döner.
3. Yoksa (**cache miss**) **origin** sunucudan çeker, önbelleğe alır ve döner.
4. Önbellek süresi origin'in gönderdiği cache başlıklarına veya CDN kurallarına göre belirlenir.

### Faydaları

- **Düşük gecikme:** fiziksel mesafe kısalır.
- **Origin yükü azalır:** isteklerin büyük kısmı edge'de karşılanır.
- **Dayanıklılık:** trafik patlamalarını ve DDoS saldırılarını absorbe eder.
- TLS sonlandırma, sıkıştırma, görsel optimizasyonu gibi ek özellikler.

### Ne konur?

- Statik dosyalar: JS, CSS, görsel, font, video. Dosya adına hash eklenerek (`app.3f9a1c.js`) uzun süre önbelleklenir.
- Herkese aynı olan HTML sayfaları ve bazı API yanıtları.
- Kişiye özel veriler genelde önbelleğe alınmaz.

### Invalidation

İçerik değiştiğinde ya dosya adı değiştirilir (en sağlam yöntem) ya da CDN üzerinden **purge** yapılır.$md$, null, $md$easy$md$, $md$full-stack-developer$md$, $md$sistem-tasarimi$md$),
  ($md$google-docs-benzeri-gercek-zamanli-ortak-duzenleme-yuksek-seviyede-nasil-tasarla$md$, $md$Google Docs benzeri gerçek zamanlı ortak düzenleme yüksek seviyede nasıl tasarlanır?$md$, $md$Temel zorluk: birden fazla kullanıcı aynı belgeyi aynı anda düzenlediğinde, her istemci düzenlemeyi önce **yerelde** uygular (gecikmesiz his) ve sonunda herkesin aynı belgeye ulaşması (**convergence**) gerekir.

### İki ana yaklaşım

| | OT (Operational Transformation) | CRDT |
| --- | --- | --- |
| Fikir | Eşzamanlı işlemler birbirine göre dönüştürülür | Veri yapısı, birleştirme her sırada aynı sonucu verecek şekilde tasarlanır |
| Sunucu | Genelde merkezi sunucu sırayı belirler | Merkezi sunucu şart değil, P2P ve çevrim dışı uygun |
| Örnek | Google Docs | Figma'nın modeli, Yjs, Automerge |
| Zorluk | Dönüşüm fonksiyonlarının doğruluğu | Bellek ve meta veri maliyeti |

Örnek çakışma: belge `abc`. A 0. konuma `X` ekler, B 2. konumdaki `c`'yi siler. OT, B'nin işlemini A'nınkinden sonra uygularken silme konumunu 3'e kaydırır.

### Mimari

- İstemci ile **WebSocket** bağlantısı; işlemler küçük delta'lar olarak gönderilir.
- Belge başına bir **oturum sunucusu** (belge ID'ye göre consistent hashing ile atanır) işlemleri sıralar ve diğer katılımcılara yayar.
- İşlemler bir **log** olarak kalıcı yazılır; periyodik **snapshot** alınır, yeni gelen istemci snapshot + sonraki işlemleri yükler.
- **Presence:** imleç konumları ve kim çevrim içi; kalıcı olması gerekmez, ayrı ve hafif bir kanaldan gider.
- Çevrim dışı düzenleme: işlemler yerelde biriktirilir, bağlanınca gönderilir (CRDT'de doğal).
- Sürüm geçmişi log'dan üretilir.

Mülakatta OT veya CRDT'nin matematiğini derinlemesine anlatmanız beklenmez; sorunu, iki yaklaşımın farkını ve bileşenleri net anlatmanız yeterlidir.$md$, null, $md$hard$md$, $md$full-stack-developer$md$, $md$sistem-tasarimi$md$),
  ($md$gitflow-ile-trunk-based-development-arasindaki-fark-nedir$md$, $md$GitFlow ile trunk-based development arasındaki fark nedir?$md$, $md$### GitFlow

Uzun ömürlü `main` ve `develop` dalları ile `feature/*`, `release/*`, `hotfix/*` dalları kullanır.

- Feature dalları `develop`'a birleşir; sürüm zamanı `release` dalı açılır, test edilip `main`'e alınır ve etiketlenir.
- **Uygun olduğu yer:** planlı sürümler, aynı anda birden fazla sürümü destekleme (masaüstü yazılım, mobil uygulama, kütüphane).
- **Dezavantaj:** uzun yaşayan dallar büyük merge conflict'lere ve geç entegrasyona yol açar.

### Trunk-based development

Herkes küçük değişikliklerle **sık sık** (günde en az bir kez) `main`'e entegre olur. Dallar varsa da çok kısa ömürlüdür (saatler, en fazla 1–2 gün).

- Bitmemiş özellikler **feature flag** arkasında gizlenir.
- Güçlü otomatik test ve CI şarttır; `main` her zaman deploy edilebilir olmalıdır.
- **Uygun olduğu yer:** sürekli deploy (CD) yapan web servisleri.

| | GitFlow | Trunk-based |
| --- | --- | --- |
| Dal ömrü | Uzun | Çok kısa |
| Entegrasyon sıklığı | Seyrek | Sürekli |
| Sürüm | Planlı, release dalı ile | Sürekli, main'den |
| Gereksinim | Süreç disiplini | Güçlü CI, feature flag |

Arada popüler bir seçenek **GitHub Flow**'dur: `main` + kısa ömürlü feature dalı + pull request + merge sonrası deploy.$md$, $md$Hangi stratejiyi seçtiğinizi ekibin deploy sıklığına ve ürün türüne bağlayarak gerekçelendirin; tek doğru cevap yoktur.$md$, $md$medium$md$, $md$full-stack-developer$md$, $md$git$md$),
  ($md$merge-conflict-nedir-ve-nasil-cozulur$md$, $md$Merge conflict nedir ve nasıl çözülür?$md$, $md$**Merge conflict**, iki dalda aynı dosyanın aynı satırları farklı şekilde değiştirildiğinde (veya biri silip diğeri değiştirdiğinde) Git'in hangisini alacağına otomatik karar verememesidir.

```bash
git merge feature/odeme
# CONFLICT (content): Merge conflict in src/cart.js
git status   # çakışan dosyaları gösterir
```

Dosyada işaretler görünür:

```text
<<<<<<< HEAD
const vergi = 0.18;
=======
const vergi = 0.20;
>>>>>>> feature/odeme
```

### Çözüm adımları

1. Çakışan dosyaları açın, iki tarafın **amacını** anlayın. Çoğu zaman doğru cevap ikisini birleştirmektir, birini seçmek değil.
2. İşaretleri kaldırıp doğru kodu bırakın.
3. Testleri çalıştırın; derlenen kod doğru kod demek değildir.
4. `git add src/cart.js` ile çözüldü olarak işaretleyin.
5. `git commit` (merge) veya rebase sırasındaysa `git rebase --continue`.

İşler karışırsa `git merge --abort` veya `git rebase --abort` ile başa dönülür.

### Çakışmaları azaltmak

- Küçük ve kısa ömürlü dallar, `main`'i düzenli olarak dala çekmek.
- Formatlayıcı (Prettier) kullanmak: biçim farkları gereksiz çakışma yaratmaz.
- Büyük refactor'ları ekiple koordine etmek.$md$, null, $md$easy$md$, $md$full-stack-developer$md$, $md$git$md$),
  ($md$git-cherry-pick-ve-git-stash-ne-ise-yarar-hangi-durumlarda-kullanilir$md$, $md$git cherry-pick ve git stash ne işe yarar? Hangi durumlarda kullanılır?$md$, $md$### git cherry-pick

Başka bir daldaki **belirli bir commit'i** mevcut dala kopyalar (yeni hash ile yeni commit oluşturur).

```bash
git checkout release/2.3
git cherry-pick a1b2c3d          # tek commit
git cherry-pick a1b2c3d^..f6e5d4c # aralık
git cherry-pick -x a1b2c3d        # mesaja kaynak commit notu ekler
```

Tipik kullanım: `main`'de yapılan bir hata düzeltmesini tüm dalı birleştirmeden eski sürüm dalına almak (backport). Dikkat: aynı değişiklik iki farklı commit olarak var olur; sık kullanım dallar arası takibi zorlaştırır.

### git stash

Commit'lenmemiş değişiklikleri geçici olarak bir yığına kaldırıp çalışma dizinini temizler.

```bash
git stash push -m "yarim form"  # kaydet
git stash -u                     # takip edilmeyen dosyaları da dahil et
git stash list                   # stash@{0}: On main: yarim form
git stash pop                    # uygula ve listeden sil
git stash apply stash@{1}        # uygula, listede tut
git stash drop stash@{1}
```

Tipik kullanım: yarım iş varken acil bir hata için dal değiştirmek, ya da `git pull` öncesi yerel değişiklikleri kenara almak.

Stash uzun süreli saklama yeri değildir; unutulur ve kaybolur. Uzun sürecek işler için WIP commit'li bir dal daha güvenlidir.$md$, null, $md$medium$md$, $md$full-stack-developer$md$, $md$git$md$),
  ($md$interactive-rebase-ile-commit-leri-nasil-duzenler-ve-squash-edersiniz$md$, $md$Interactive rebase ile commit'leri nasıl düzenler ve squash edersiniz?$md$, $md$`git rebase -i`, bir dizi commit'i yeniden yazmanızı sağlar: sıralamak, birleştirmek, mesaj değiştirmek, silmek. PR'ı göndermeden önce dağınık commit geçmişini temizlemek için kullanılır.

```bash
git rebase -i HEAD~4
# veya dalın ayrıldığı noktadan itibaren:
git rebase -i main
```

Açılan editörde:

```text
pick 1a2b3c Sepet sayfası eklendi
pick 4d5e6f typo
pick 7g8h9i Testler eklendi
pick 0j1k2l review düzeltmeleri
```

Komutlar değiştirilir:

```text
pick   1a2b3c Sepet sayfası eklendi
fixup  4d5e6f typo
pick   7g8h9i Testler eklendi
fixup  0j1k2l review düzeltmeleri
```

| Komut | Etkisi |
| --- | --- |
| `pick` | Commit'i olduğu gibi kullan |
| `reword` | Mesajı değiştir |
| `edit` | Commit'te dur, içeriği değiştir |
| `squash` | Öncekiyle birleştir, mesajları birleştir |
| `fixup` | Öncekiyle birleştir, bu mesajı at |
| `drop` | Commit'i sil |

### Kullanışlı ipuçları

- `git commit --fixup=<hash>` ve ardından `git rebase -i --autosquash main` düzeltme commit'lerini otomatik yerleştirir.
- Bir şey ters giderse `git rebase --abort`; tamamlandıktan sonra bile `git reflog` ile eski duruma dönülebilir.

### Altın kural

Rebase commit hash'lerini değiştirir. **Başkalarının kullandığı paylaşılan dalları** (`main`) yeniden yazmayın. Kendi feature dalınızı rebase ettikten sonra `git push --force-with-lease` kullanın; düz `--force`'tan farkı, uzakta sizin görmediğiniz yeni commit varsa push'u reddetmesidir.$md$, $md$--force yerine --force-with-lease kullandığınızı ve reflog ile kurtarmayı bilmeniz, git'e hakimiyetin net bir göstergesidir.$md$, $md$hard$md$, $md$full-stack-developer$md$, $md$git$md$),
  ($md$iyi-bir-code-review-nasil-yapilir-gitignore-a-neler-eklenmelidir$md$, $md$İyi bir code review nasıl yapılır? .gitignore'a neler eklenmelidir?$md$, $md$### Code review'da neye bakılır?

1. **Doğruluk:** kod gereksinimi karşılıyor mu, uç durumlar (boş liste, null, eşzamanlılık) düşünülmüş mü?
2. **Güvenlik:** yetki kontrolü, girdi doğrulama, sırların koda girmemesi.
3. **Test:** yeni davranış test edilmiş mi, testler anlamlı mı?
4. **Okunabilirlik ve tasarım:** isimlendirme, gereksiz karmaşıklık, tekrar.
5. **Performans:** N+1 sorgu, gereksiz döngü veya render.

### İyi review kültürü

- PR'lar **küçük** olmalı (birkaç yüz satır); büyük PR'lar yüzeysel incelenir.
- Açıklamada neyin, neden değiştiği ve nasıl test edileceği yazılmalı.
- Yorumlar kişiye değil koda yönelik ve gerekçeli olmalı: "Bu null gelebilir mi? Gelirse X olur" gibi.
- Zorunlu düzeltme ile öneriyi ayırın (ör. `nit:` öneki).
- Biçim tartışmaları insanlara değil **linter/formatter**'a bırakılmalı.

### .gitignore'a neler eklenir?

```text
# Bağımlılıklar ve build çıktıları
node_modules/
dist/
build/
.next/
__pycache__/

# Ortam ve sırlar
.env
.env.local
*.pem

# Editör / işletim sistemi
.vscode/
.idea/
.DS_Store

# Log ve geçici dosyalar
*.log
coverage/
```

Kilit dosyaları (`package-lock.json`, `pnpm-lock.yaml`) **eklenmez**, commit'lenir. `.gitignore` zaten takip edilen dosyayı etkilemez; yanlışlıkla commit'lenen dosya için `git rm --cached dosya` gerekir. Commit'lenmiş bir sır geçmişte kalır, mutlaka **iptal edilip yenilenmelidir**.$md$, null, $md$easy$md$, $md$full-stack-developer$md$, $md$git$md$),
  ($md$unity-de-monobehaviour-yasam-dongusu-nasil-isler-awake-onenable-ve-start-arasind$md$, $md$Unity'de MonoBehaviour yaşam döngüsü nasıl işler? Awake, OnEnable ve Start arasındaki fark nedir?$md$, $md$Bir MonoBehaviour sahneye yüklendiğinde metotlar şu sırayla çağrılır:

1. **Awake:** Nesne yüklenir yüklenmez, script devre dışı olsa bile (GameObject aktifse) **bir kez** çağrılır. Kendi referanslarını kurmak için kullanılır.
2. **OnEnable:** Bileşen her etkinleştiğinde çağrılır. Event aboneliği için idealdir.
3. **Start:** İlk `Update`'ten hemen önce, yalnızca bileşen etkinse **bir kez** çağrılır. Başka nesnelere bağımlı başlatma işleri burada yapılır.
4. **FixedUpdate / Update / LateUpdate:** Her kare (FixedUpdate sabit fizik adımında).
5. **OnDisable / OnDestroy:** Kapanış ve temizlik.

```csharp
public class Player : MonoBehaviour
{
    Rigidbody rb;
    void Awake()     { rb = GetComponent<Rigidbody>(); }      // kendi bileşenlerim
    void OnEnable()  { GameEvents.OnDamage += TakeDamage; }    // abone ol
    void Start()     { transform.position = SpawnPoint.Instance.Position; } // diğer nesneler hazır
    void OnDisable() { GameEvents.OnDamage -= TakeDamage; }    // aboneliği bırak
    void TakeDamage(int amount) { /* ... */ }
}
```

Temel kural: **Awake'te kendini, Start'ta başkalarını** başlat. Farklı nesnelerin Awake'leri arasındaki sıra garanti değildir; gerekirse **Script Execution Order** ayarı kullanılır.

`LateUpdate` tüm `Update`'lerden sonra çalıştığı için kamera takibi gibi işler için uygundur.$md$, $md$OnEnable'da abone olup OnDisable'da aboneliği bırakmayı mutlaka söyleyin; object pooling ile birlikte kullanıldığında bunun neden önemli olduğunu açıklamak artı puan getirir.$md$, $md$easy$md$, $md$game-developer$md$, $md$unity-csharp$md$),
  ($md$unity-de-coroutine-ile-async-await-arasindaki-fark-nedir-hangisini-ne-zaman-kull$md$, $md$Unity'de coroutine ile async/await arasındaki fark nedir? Hangisini ne zaman kullanırsınız?$md$, $md$**Coroutine**, `IEnumerator` döndüren ve `yield` ile kareler arasında duraklatılabilen bir metottur. Ayrı bir thread değildir; ana thread'de, Unity'nin oyun döngüsü tarafından her kare devam ettirilir.

```csharp
IEnumerator FadeOut(CanvasGroup g)
{
    while (g.alpha > 0f)
    {
        g.alpha -= Time.deltaTime;
        yield return null;              // bir sonraki kareyi bekle
    }
}
StartCoroutine(FadeOut(group));
```

**async/await** C#'ın standart asenkron modelidir. Unity 2023.1+ sürümlerinde `Awaitable` tipi, öncesinde UniTask gibi kütüphaneler kullanılır.

```csharp
async Awaitable LoadLevelAsync()
{
    await Awaitable.WaitForSecondsAsync(1f);
    await SceneManager.LoadSceneAsync("Level2");
}
```

| Özellik | Coroutine | async/await |
| --- | --- | --- |
| Yaşam süresi | GameObject yok edilince veya devre dışı kalınca durur | Kendiliğinden durmaz, iptal için CancellationToken gerekir |
| Değer döndürme | Doğrudan döndüremez | `Task<T>` / `Awaitable<T>` ile döndürür |
| Hata yönetimi | try/catch yield ile sınırlı | Normal try/catch çalışır |
| Bellek | Her `StartCoroutine` küçük allocation yapar | UniTask/Awaitable ile neredeyse sıfır |

**Ne zaman hangisi:** Basit, nesneye bağlı zamanlamalar (animasyon, bekleme, efekt) için coroutine pratiktir. Ağ istekleri, dosya işlemleri, değer döndüren karmaşık akışlar için async/await daha okunur ve test edilebilirdir. async kullanırken nesne yok edildiğinde işlemi iptal etmeyi (`destroyCancellationToken`) unutmamak gerekir.$md$, null, $md$medium$md$, $md$game-developer$md$, $md$unity-csharp$md$),
  ($md$scriptableobject-nedir-ve-hangi-problemleri-cozer$md$, $md$ScriptableObject nedir ve hangi problemleri çözer?$md$, $md$**ScriptableObject**, bir GameObject'e bağlı olmadan proje içinde **asset olarak** saklanan veri kapsayıcısıdır. MonoBehaviour gibi sahnede yaşamaz, `Update` almaz.

```csharp
[CreateAssetMenu(menuName = "Game/Weapon")]
public class WeaponData : ScriptableObject
{
    public string weaponName;
    public int damage;
    public float fireRate;
    public GameObject projectilePrefab;
}

public class Gun : MonoBehaviour
{
    [SerializeField] WeaponData data;
    void Fire() { /* data.damage kullan */ }
}
```

### Çözdüğü problemler

- **Veri tekrarı:** 100 düşman aynı istatistiği kullanıyorsa, her prefab'da kopya tutmak yerine tek bir asset'e referans verilir. Bellek tasarrufu sağlar.
- **Tasarımcı dostu:** Oyun tasarımcıları kod değiştirmeden Inspector'dan denge ayarı yapar.
- **Sahneler arası veri:** Sahne değişse de asset bellekte kalır.
- **Bağımlılık azaltma:** Event kanalları (ScriptableObject tabanlı event'ler) ile sistemler birbirini doğrudan tanımadan haberleşir.

### Dikkat edilmesi gerekenler

- Editörde Play modunda ScriptableObject'te yapılan değişiklikler **kalıcıdır**, oyundan çıkınca geri dönmez.
- Build'de ise değişiklikler diske yazılmaz; bu yüzden **kayıt sistemi için uygun değildir**. Çalışma zamanı durumunu ayrı tutmak gerekir.$md$, null, $md$medium$md$, $md$game-developer$md$, $md$unity-csharp$md$),
  ($md$prefab-nedir-prefab-variant-ve-nested-prefab-ne-ise-yarar$md$, $md$Prefab nedir? Prefab variant ve nested prefab ne işe yarar?$md$, $md$**Prefab**, yapılandırılmış bir GameObject'in (bileşenleri, değerleri, çocuk nesneleriyle birlikte) yeniden kullanılabilir şablonudur. Sahnedeki her kopyası (instance) prefab'a bağlıdır; prefab değişince tüm kopyalar güncellenir.

```csharp
[SerializeField] GameObject enemyPrefab;

void Spawn(Vector3 pos)
{
    GameObject e = Instantiate(enemyPrefab, pos, Quaternion.identity);
}
```

- **Override:** Bir instance üzerinde değer değiştirilirse sadece o kopya farklılaşır; diğer alanlar prefab'a bağlı kalır.
- **Nested prefab:** Bir prefab başka prefab'ları içerebilir (ör. bir araç prefab'ı içinde tekerlek prefab'ı). Tekerlek güncellenince tüm araçlar etkilenir.
- **Prefab variant:** Bir ana prefab'tan türeyen ve sadece farklılıklarını tutan prefab'tır. Ör. `Enemy` temelinden `FastEnemy` ve `TankEnemy` türetmek. Kalıtıma benzer.

Sık `Instantiate` / `Destroy` çağrısı GC ve performans maliyeti yaratır; mermi, efekt gibi sık oluşan nesneler için **object pooling** (Unity'de `ObjectPool<T>`) tercih edilir.$md$, null, $md$easy$md$, $md$game-developer$md$, $md$unity-csharp$md$),
  ($md$csharp-ta-struct-ile-class-arasindaki-fark-nedir-value-type-ve-reference-type-oy$md$, $md$C#'ta struct ile class arasındaki fark nedir? Value type ve reference type oyunda neden önemlidir?$md$, $md$| Özellik | struct (value type) | class (reference type) |
| --- | --- | --- |
| Saklandığı yer | Değişken nerede ise orada (stack, dizi içinde, başka nesne içinde) | Heap üzerinde, değişken sadece referans tutar |
| Atama | Değerin tamamı kopyalanır | Sadece referans kopyalanır |
| GC | Kendi başına GC yükü oluşturmaz | GC tarafından toplanır |
| Kalıtım | Yok (interface uygulayabilir) | Var |
| null | Olamaz (`Nullable<T>` hariç) | Olabilir |

Unity'de `Vector3`, `Quaternion`, `Color` struct'tır. Bu yüzden şu kod çalışmaz:

```csharp
transform.position.x = 5f;   // derleme hatası: kopyanın alanı değiştirilemez

Vector3 p = transform.position;  // kopya al
p.x = 5f;
transform.position = p;          // geri ata
```

### Oyunda neden önemli

- Her kare oluşturulan küçük veriler (vektör, hasar bilgisi) struct olursa **heap allocation ve GC spike** oluşmaz.
- Struct dizileri bellekte ardışık durur, **cache dostudur**; DOTS/ECS bu yüzden struct tabanlıdır.

### Dikkat

- Büyük struct'lar (16-32 byte üstü) her geçişte kopyalandığı için yavaşlayabilir; `in` / `ref` parametreleriyle geçilebilir.
- Struct'ı `object` veya interface olarak kullanmak **boxing** yaratır ve heap allocation'a yol açar.
- Değiştirilebilir (mutable) struct'lar kopya semantiği yüzünden sinsi hatalara yol açar; mümkünse `readonly struct` kullanın.$md$, $md$transform.position.x = 5 örneği bu sorunun klasik pratiğidir; neden hata verdiğini value type kopyalamasıyla açıklayabilirseniz konuyu anladığınızı gösterirsiniz.$md$, $md$medium$md$, $md$game-developer$md$, $md$unity-csharp$md$),
  ($md$unity-de-garbage-collection-neden-frame-dususune-yol-acar-update-icinde-allocati$md$, $md$Unity'de garbage collection neden frame düşüşüne yol açar? Update içinde allocation'dan nasıl kaçınırsınız?$md$, $md$Unity'nin GC'si (Boehm, incremental mod destekli) heap dolduğunda çalışır ve toplama süresince ana thread'i durdurabilir. Her kare küçük allocation'lar yapılırsa GC periyodik olarak tetiklenir ve **ani takılmalar (GC spike)** oluşur. 60 FPS'te bir karenin bütçesi yalnızca ~16.6 ms'dir.

### Sık görülen allocation kaynakları ve çözümleri

```csharp
// KÖTÜ: her kare allocation
void Update()
{
    scoreText.text = "Skor: " + score;            // string birleştirme
    var enemies = FindObjectsOfType<Enemy>();     // yeni dizi
    var hits = Physics.RaycastAll(ray);           // yeni dizi
    var near = list.Where(e => e.hp > 0).ToList(); // LINQ + closure
}

// İYİ
readonly RaycastHit[] hitBuffer = new RaycastHit[16];
int lastScore = -1;

void Update()
{
    if (score != lastScore) { scoreText.SetText("Skor: {0}", score); lastScore = score; } // TMP, değişince güncelle
    int count = Physics.RaycastNonAlloc(ray, hitBuffer);   // önceden ayrılmış buffer
    for (int i = 0; i < count; i++) { /* ... */ }
}
```

- **String:** Her değişiklikte değil, sadece değer değiştiğinde güncelleyin; `StringBuilder` veya TextMeshPro'nun `SetText` metodunu kullanın.
- **Koleksiyonlar:** Listeleri alan olarak tutup `Clear()` ile yeniden kullanın.
- **Physics:** `RaycastNonAlloc`, `OverlapSphereNonAlloc` gibi NonAlloc sürümleri.
- **LINQ ve lambda:** Sıcak yolda (hot path) kullanmayın; dış değişken yakalayan lambda her seferinde closure oluşturur.
- **Boxing:** Struct'ı `object` olarak geçmek, enum'u Dictionary key yapmak (eski runtime'larda) allocation yaratır.
- **Instantiate/Destroy:** Object pooling kullanın.
- **`GetComponent` / `gameObject.tag`:** `tag` string döndürür; `CompareTag` kullanın.
- `yield return new WaitForSeconds(1)` her seferinde yeni nesne oluşturur; önbelleğe alın.

### Ölçmek

**Profiler**'da `GC.Alloc` sütununu ve **Deep Profile** ile kaynağı bulun. Hedef, oynanış sırasında kare başına **0 B** allocation'dır. Ek olarak Player Settings'te **Incremental GC** açılarak duraklamalar birden fazla kareye yayılabilir.$md$, $md$Somut örnek verin: 'Profiler'da GC.Alloc'u gördüm, string birleştirmeyi kaldırdım, spike'lar kayboldu' gibi bir deneyim anlatmak teorik bilgiden daha etkilidir.$md$, $md$hard$md$, $md$game-developer$md$, $md$unity-csharp$md$),
  ($md$csharp-delegate-event-ve-unityevent-arasindaki-farklar-nelerdir$md$, $md$C# delegate, event ve UnityEvent arasındaki farklar nelerdir?$md$, $md$**Delegate**, bir metoda referans tutan tiptir. **event**, delegate üzerine kurulu ve dışarıdan sadece `+=` / `-=` yapılmasına izin veren bir erişim kısıtlamasıdır. **UnityEvent** ise Inspector'dan bağlanabilen, serileştirilebilir bir event sistemidir.

```csharp
public class Health : MonoBehaviour
{
    // C# event: kod ile abone olunur
    public event Action<int> OnDamaged;

    // UnityEvent: Inspector'dan da bağlanabilir
    public UnityEvent onDied;

    int hp = 100;
    public void TakeDamage(int amount)
    {
        hp -= amount;
        OnDamaged?.Invoke(hp);
        if (hp <= 0) onDied.Invoke();
    }
}

// Abone
void OnEnable()  { health.OnDamaged += UpdateHealthBar; }
void OnDisable() { health.OnDamaged -= UpdateHealthBar; }
```

| Özellik | C# event | UnityEvent |
| --- | --- | --- |
| Bağlama | Sadece kod | Kod ve Inspector |
| Performans | Daha hızlı | Daha yavaş, reflection/serileştirme maliyeti |
| Kimin tetiklediği | Sadece sahip sınıf | Public ise herkes |
| Tasarımcı erişimi | Yok | Var |

### Neden event kullanılır

- **Gevşek bağlılık (decoupling):** `Health`, UI'ı veya ses sistemini tanımak zorunda kalmaz; sadece "hasar aldım" der.
- Observer pattern'in dil seviyesindeki karşılığıdır.

### Yaygın hata

Aboneliği bırakmamak **memory leak** ve yok edilmiş nesne üzerinde `MissingReferenceException` hatalarına yol açar. Statik event'lerde bu risk daha büyüktür, çünkü statik referans nesnenin GC tarafından toplanmasını engeller.$md$, null, $md$medium$md$, $md$game-developer$md$, $md$unity-csharp$md$),
  ($md$rigidbody-physics-layer-lar-ve-raycast-nasil-calisir-fixedupdate-neden-onemlidir$md$, $md$Rigidbody, physics layer'lar ve raycast nasıl çalışır? FixedUpdate neden önemlidir?$md$, $md$**Rigidbody**, bir nesneyi fizik motorunun (PhysX) kontrolüne verir: yerçekimi, kuvvet, çarpışma tepkisi. Fizik **sabit zaman adımında** (varsayılan 0.02 sn) hesaplanır; bu yüzden fizik kodu `FixedUpdate` içinde yazılır.

```csharp
Rigidbody rb;
Vector3 input;

void Awake()  => rb = GetComponent<Rigidbody>();
void Update() => input = new Vector3(Input.GetAxis("Horizontal"), 0, Input.GetAxis("Vertical")); // input'u Update'te oku
void FixedUpdate() => rb.AddForce(input * 10f);  // fiziği FixedUpdate'te uygula
```

- Rigidbody'li nesneyi `transform.position` ile taşımak fiziği bozar; `rb.MovePosition` veya kuvvet/hız kullanılır.
- **Kinematic** Rigidbody fizikten etkilenmez ama diğer nesneleri iter (hareketli platform).
- Görsel titremeyi önlemek için Rigidbody'de **Interpolate** açılır.

### Layer'lar ve collision matrix

Her GameObject bir **layer**'a sahiptir. Project Settings > Physics'teki **Layer Collision Matrix** ile hangi layer'ların birbiriyle çarpışacağı belirlenir (ör. oyuncu mermileri oyuncuya çarpmasın). Bu hem mantık hem performans kazancı sağlar.

### Raycast

Bir noktadan belirli yönde ışın gönderip ilk çarptığı collider'ı bulur. Görüş hattı, ateş etme, yere değme kontrolü için kullanılır.

```csharp
int mask = LayerMask.GetMask("Ground", "Enemy");

if (Physics.Raycast(transform.position, Vector3.down, out RaycastHit hit, 1.1f, mask))
{
    isGrounded = true;
    Debug.Log(hit.collider.name + " " + hit.distance);
}
```

`LayerMask` bir **bit maskesidir**; raycast'i sadece ilgili layer'larla sınırlamak hem yanlış sonuçları hem maliyeti azaltır. Birden fazla sonuç için `RaycastNonAlloc` tercih edilir.$md$, null, $md$medium$md$, $md$game-developer$md$, $md$unity-csharp$md$),
  ($md$getcomponent-cagrilarini-neden-onbellege-almalisiniz$md$, $md$GetComponent çağrılarını neden önbelleğe almalısınız?$md$, $md$`GetComponent<T>()`, GameObject üzerindeki bileşen listesinde arama yapar. Tek seferlik maliyeti küçüktür ama `Update` içinde her kare, yüzlerce nesnede çağrıldığında gereksiz CPU yükü oluşturur. Ayrıca `Camera.main` (eski sürümlerde) ve `Find` metotları çok daha pahalıdır.

```csharp
// KÖTÜ
void Update()
{
    GetComponent<Rigidbody>().AddForce(Vector3.up);
    GameObject.Find("Player").transform.position = Vector3.zero;
}

// İYİ
[SerializeField] Transform player;   // Inspector'dan ata
Rigidbody rb;

void Awake() { rb = GetComponent<Rigidbody>(); }

void Update() { rb.AddForce(Vector3.up); }
```

Diğer iyi pratikler:

- Referansları mümkünse `[SerializeField]` ile Inspector'dan atayın; bu en hızlı ve en okunur yoldur.
- Var olmayabilecek bileşenler için `TryGetComponent(out T comp)` kullanın; null kontrolüyle birlikte daha temizdir ve editörde allocation yapmaz.
- `[RequireComponent(typeof(Rigidbody))]` ile bağımlılığı garanti altına alın.
- `GameObject.Find` ve `FindObjectOfType` çağrılarını sadece başlatma sırasında, mümkünse hiç kullanmayın.$md$, null, $md$easy$md$, $md$game-developer$md$, $md$unity-csharp$md$),
  ($md$bir-karakter-veya-dusman-ai-i-icin-finite-state-machine-fsm-nasil-tasarlanir$md$, $md$Bir karakter veya düşman AI'ı için finite state machine (FSM) nasıl tasarlanır?$md$, $md$**FSM**, bir varlığın aynı anda yalnızca bir durumda (state) bulunduğu ve belirli koşullarla durumlar arasında geçiş yaptığı modeldir. Ör. düşman: `Patrol → Chase → Attack → Flee`.

Basit `switch` ile başlanabilir, ancak durum sayısı arttıkça **State pattern** daha sürdürülebilirdir:

```csharp
public interface IState
{
    void Enter();
    void Tick();
    void Exit();
}

public class StateMachine
{
    IState current;
    public void ChangeState(IState next)
    {
        current?.Exit();
        current = next;
        current.Enter();
    }
    public void Tick() => current?.Tick();
}

public class ChaseState : IState
{
    readonly Enemy enemy;
    public ChaseState(Enemy e) => enemy = e;
    public void Enter() => enemy.Agent.speed = 6f;
    public void Tick()
    {
        enemy.Agent.SetDestination(enemy.Target.position);
        if (enemy.DistanceToTarget < 2f) enemy.Fsm.ChangeState(enemy.AttackState);
        else if (enemy.DistanceToTarget > 20f) enemy.Fsm.ChangeState(enemy.PatrolState);
    }
    public void Exit() { }
}
```

### Avantajları

- Her durumun mantığı ayrı sınıftadır, `Enter`/`Exit` ile animasyon ve ses tetikleme kolaylaşır.
- Hata ayıklama kolaydır: "şu an hangi durumdayım" tek alan.

### Sınırları ve alternatifler

- Durum sayısı arttıkça geçişler patlar (her durum diğerlerini bilir). **Hierarchical FSM** ortak davranışları üst duruma taşır.
- Karmaşık AI için **Behavior Tree** (modüler, yeniden kullanılabilir) veya **GOAP / Utility AI** (hedef ve puan tabanlı karar) tercih edilir.
- Unity'nin **Animator**'ü de bir FSM'dir; ama oyun mantığını animator'e gömmek yerine mantık FSM'i kodda tutmak genellikle daha temizdir.$md$, $md$FSM ile Behavior Tree arasındaki takası sorabilirler: FSM küçük ve öngörülebilir AI için, Behavior Tree ise büyüyen ve yeniden kullanılabilir davranışlar için daha uygundur.$md$, $md$medium$md$, $md$game-developer$md$, $md$oyun-programlama$md$),
  ($md$a-pathfinding-algoritmasi-nasil-calisir-heuristic-secimi-neyi-etkiler$md$, $md$A* pathfinding algoritması nasıl çalışır? Heuristic seçimi neyi etkiler?$md$, $md$**A***, bir başlangıçtan hedefe en kısa yolu bulan, Dijkstra'nın **heuristic** ile yönlendirilmiş hâlidir. Her düğüm için:

- **g(n):** başlangıçtan bu düğüme gerçek maliyet
- **h(n):** bu düğümden hedefe tahmini maliyet (heuristic)
- **f(n) = g(n) + h(n):** öncelik değeri

Algoritma her adımda **open set**'teki en düşük `f` değerli düğümü seçer.

```csharp
List<Node> FindPath(Node start, Node goal)
{
    var open = new PriorityQueue<Node, float>();
    var cameFrom = new Dictionary<Node, Node>();
    var g = new Dictionary<Node, float> { [start] = 0 };
    open.Enqueue(start, Heuristic(start, goal));

    while (open.Count > 0)
    {
        Node current = open.Dequeue();
        if (current == goal) return Reconstruct(cameFrom, current);

        foreach (Node n in current.Neighbors)
        {
            if (!n.Walkable) continue;
            float tentative = g[current] + Cost(current, n);
            if (!g.TryGetValue(n, out float old) || tentative < old)
            {
                cameFrom[n] = current;
                g[n] = tentative;
                open.Enqueue(n, tentative + Heuristic(n, goal));
            }
        }
    }
    return null; // yol yok
}
```

### Heuristic seçimi

| Heuristic | Kullanım |
| --- | --- |
| Manhattan (dx + dy) | 4 yönlü grid |
| Octile / Chebyshev | 8 yönlü grid |
| Öklid mesafesi | Serbest yönlü hareket, navmesh |

- Heuristic **admissible** ise (gerçek maliyeti asla abartmıyorsa) A* **en kısa yolu garanti eder**.
- `h = 0` olursa A* Dijkstra'ya dönüşür: doğru ama yavaş.
- Heuristic abartılırsa (weighted A*) daha az düğüm gezilir, daha hızlı olur ama yol optimal olmayabilir. Oyunlarda bu takas sık yapılır.

### Pratik notlar

- Oyunlarda çoğunlukla grid yerine **NavMesh** (Unity'de `NavMeshAgent`) üzerinde çalışılır.
- Çok sayıda ajan için yol hesaplamayı birkaç kareye yaymak, sonuçları önbelleğe almak veya **flow field** kullanmak gerekir.
- Bulunan yol köşeli olabilir; **path smoothing** (string pulling) uygulanır.$md$, null, $md$hard$md$, $md$game-developer$md$, $md$oyun-programlama$md$),
  ($md$input-yonetiminde-command-pattern-nasil-kullanilir-tus-atama-ve-undo-nasil-sagla$md$, $md$Input yönetiminde Command pattern nasıl kullanılır? Tuş atama ve undo nasıl sağlanır?$md$, $md$**Command pattern**, bir eylemi nesneye dönüştürür. Input kodu "Space tuşuna basıldı, zıpla" demek yerine "Space'e bağlı komutu çalıştır" der. Böylece girdi ile oyun mantığı birbirinden ayrılır.

```csharp
public interface ICommand
{
    void Execute(Unit unit);
    void Undo(Unit unit);
}

public class MoveCommand : ICommand
{
    readonly Vector2Int dir;
    public MoveCommand(Vector2Int d) => dir = d;
    public void Execute(Unit u) => u.Move(dir);
    public void Undo(Unit u)    => u.Move(-dir);
}

public class InputHandler
{
    readonly Dictionary<KeyCode, ICommand> bindings = new();
    readonly Stack<ICommand> history = new();

    public void Bind(KeyCode key, ICommand cmd) => bindings[key] = cmd;  // tuş atama

    public void Handle(Unit unit)
    {
        foreach (var (key, cmd) in bindings)
            if (Input.GetKeyDown(key)) { cmd.Execute(unit); history.Push(cmd); }

        if (Input.GetKeyDown(KeyCode.Z) && history.Count > 0)
            history.Pop().Undo(unit);
    }
}
```

### Sağladıkları

- **Tuş atama (rebinding):** Sadece sözlükteki eşleşme değişir.
- **Undo/redo:** Strateji ve bulmaca oyunlarında komut geçmişi tutulur.
- **Replay ve test:** Komut dizisi kaydedilip yeniden oynatılabilir.
- **AI ve oyuncu ortaklığı:** AI da aynı komutları üreterek aynı `Unit`'i kontrol edebilir.
- **Ağ:** Multiplayer'da sunucuya ham tuş değil komut gönderilir.

Unity'nin yeni **Input System** paketi de benzer bir soyutlama sunar: tuşlar **Action**'lara bağlanır ve kod sadece `jump.performed` gibi aksiyonlarla ilgilenir. Bu sayede klavye, gamepad ve dokunmatik girdi aynı kodla desteklenir.$md$, null, $md$medium$md$, $md$game-developer$md$, $md$oyun-programlama$md$),
  ($md$bir-oyunda-kayit-save-sistemi-nasil-tasarlanir-serilestirmede-nelere-dikkat-edil$md$, $md$Bir oyunda kayıt (save) sistemi nasıl tasarlanır? Serileştirmede nelere dikkat edilir?$md$, $md$Temel ilke: **sahnedeki nesneleri değil, oyun durumunu (state) kaydetmek.** Kaydedilecek veriler sade veri sınıflarında toplanır, yüklemede bu veriden dünya yeniden kurulur.

```csharp
[System.Serializable]
public class SaveData
{
    public int version = 2;
    public float[] playerPosition;   // Vector3 yerine düz dizi
    public int health;
    public List<string> collectedItemIds = new();
}

public static class SaveSystem
{
    static string PathFor(int slot) => Path.Combine(Application.persistentDataPath, $"save{slot}.json");

    public static void Save(SaveData data, int slot)
    {
        string json = JsonUtility.ToJson(data);
        string tmp = PathFor(slot) + ".tmp";
        File.WriteAllText(tmp, json);
        File.Copy(tmp, PathFor(slot), overwrite: true);   // yarım yazılmış kayda karşı
        File.Delete(tmp);
    }

    public static SaveData Load(int slot)
    {
        string p = PathFor(slot);
        return File.Exists(p) ? JsonUtility.FromJson<SaveData>(File.ReadAllText(p)) : new SaveData();
    }
}
```

### Dikkat edilecekler

- **Benzersiz kimlikler:** Toplanan eşyalar, açılan kapılar gibi sahne nesnelerine kalıcı ID verilir (isim veya sahnedeki sıra güvenilir değildir).
- **Versiyonlama:** Oyun güncellenince eski kayıtlar bozulmamalı; `version` alanı ve migration kodu tutulur.
- **Format seçimi:** JSON okunabilir ve debug dostudur; binary format (MessagePack, protobuf) daha küçük ve hızlıdır. .NET'in `BinaryFormatter`'ı güvenlik açıkları nedeniyle **kullanılmamalıdır**.
- **Atomik yazma:** Yazma sırasında oyun çökerse kayıt bozulmasın diye önce geçici dosyaya yazılır.
- **Hile koruması:** Tek oyunculu oyunlarda checksum yeterlidir; rekabetçi oyunlarda gerçek veri sunucuda tutulur.
- **Unity'ye özgü:** `JsonUtility` Dictionary ve property desteklemez; gerekirse Newtonsoft.Json kullanılır. `PlayerPrefs` sadece ayarlar için uygundur, oyun kaydı için değil.
- Konsol ve mobil platformlarda kayıt API'leri ve depolama kısıtları farklıdır.$md$, null, $md$medium$md$, $md$game-developer$md$, $md$oyun-programlama$md$),
  ($md$multiplayer-oyunlarda-server-authority-client-side-prediction-ve-lag-compensatio$md$, $md$Multiplayer oyunlarda server authority, client-side prediction ve lag compensation nasıl çalışır?$md$, $md$### Server authority

Rekabetçi oyunlarda **sunucu tek doğruluk kaynağıdır (authoritative server)**. İstemciler sadece girdilerini (input) gönderir; sunucu simülasyonu çalıştırır ve sonuçları yayınlar. Böylece istemci "canım 1000" veya "duvarın içinden geçtim" diyemez; hile büyük ölçüde engellenir.

Bedeli **gecikmedir**: 100 ms ping ile oyuncu tuşa bastıktan sonra hareketi 100 ms sonra görür. Bunu gizlemek için şu teknikler kullanılır:

### Client-side prediction ve reconciliation

1. İstemci girdiyi sıra numarasıyla sunucuya gönderir ve **aynı anda kendi karakterini yerelde simüle eder**.
2. Gönderilen girdiler bir tamponda saklanır.
3. Sunucudan "girdi #42 sonrası konumun X" mesajı gelince istemci durumunu buna ayarlar ve #43'ten sonraki onaylanmamış girdileri **yeniden uygular**.
4. Fark küçükse yumuşatılarak düzeltilir; büyükse geri sarılır (rubber banding).

Bunun çalışması için simülasyonun **deterministik** ve sabit tick'li olması gerekir.

### Entity interpolation

Diğer oyuncular tahmin edilmez; sunucudan gelen geçmiş snapshot'lar arasında **interpolasyon** yapılarak ~100 ms geriden ama akıcı gösterilir.

### Lag compensation

Oyuncu, ekranında gördüğü (yani geçmişteki) düşmana ateş eder. Sunucu vuruşu kontrol ederken:

- Her oyuncunun son ~1 saniyelik konum geçmişini tutar.
- Ateş edenin gecikmesi + interpolasyon gecikmesi kadar **dünyayı geri sarar**.
- Raycast'i o anki konumlara göre yapar, sonra dünyayı geri alır.

Sonuç: "Ben vurdum" hissi korunur. Yan etkisi, kurbanın "duvarın arkasına girmiştim ama öldüm" yaşamasıdır; bu yüzden geri sarma süresine üst sınır konur.

### Diğer temel kavramlar

- **Tick rate:** Sunucunun saniyede simülasyon adımı (ör. 64 tick).
- **UDP vs TCP:** Oyun durumu genellikle UDP üzerinden gönderilir, güvenilirlik gerektiren mesajlar için kendi reliable katmanı kurulur.
- **Delta compression ve interest management:** Sadece değişenleri ve oyuncunun ilgisini çeken nesneleri göndermek.$md$, $md$Bir akışı adım adım anlatın: 'İstemci girdiyi gönderir ve yerelde tahmin eder, sunucu doğrular, istemci uzlaştırır.' Mülakatçılar ezber terimden çok bu akışı görmek ister.$md$, $md$hard$md$, $md$game-developer$md$, $md$oyun-programlama$md$),
  ($md$vektor-normalize-etmek-ne-demektir-capraz-harekette-neden-gereklidir$md$, $md$Vektör normalize etmek ne demektir? Çapraz harekette neden gereklidir?$md$, $md$Bir vektörü **normalize etmek**, yönünü koruyup uzunluğunu (magnitude) 1 yapmaktır: her bileşen vektörün uzunluğuna bölünür. Sonuç **birim vektördür** ve sadece yönü temsil eder.

```csharp
Vector3 v = new Vector3(3, 0, 4);
float length = v.magnitude;      // sqrt(9 + 16) = 5
Vector3 dir = v.normalized;      // (0.6, 0, 0.8), uzunluk 1
```

### Çapraz hareket problemi

W ve D tuşlarına aynı anda basılınca girdi `(1, 0, 1)` olur. Bu vektörün uzunluğu `√2 ≈ 1.41`'dir; yani karakter çapraz giderken **%41 daha hızlı** hareket eder.

```csharp
Vector3 input = new Vector3(Input.GetAxisRaw("Horizontal"), 0, Input.GetAxisRaw("Vertical"));

// Basit çözüm
Vector3 move = input.normalized * speed;

// Analog çubukta yavaş yürümeyi koruyan çözüm
Vector3 move2 = Vector3.ClampMagnitude(input, 1f) * speed;
```

`normalized` analog çubuktaki yarım basışı da 1'e çıkarır; bu yüzden gamepad desteği varsa `ClampMagnitude` daha doğrudur.

### Diğer kullanım alanları

- Bir nesneden diğerine yön: `(target - transform.position).normalized`
- Dot product ile açı kontrolü yaparken iki vektör de normalize olmalıdır.
- Sıfır vektör normalize edilemez (sıfıra bölme); Unity bu durumda `Vector3.zero` döndürür.
- Sadece mesafe karşılaştırması yapılacaksa karekök maliyetinden kaçmak için `sqrMagnitude` kullanılır.$md$, null, $md$easy$md$, $md$game-developer$md$, $md$oyun-matematigi$md$),
  ($md$lerp-ve-slerp-nedir-lerp-u-update-icinde-yanlis-kullanmak-neden-sorun-yaratir$md$, $md$Lerp ve Slerp nedir? Lerp'ü Update içinde yanlış kullanmak neden sorun yaratır?$md$, $md$**Lerp (Linear Interpolation)**, iki değer arasında `t` oranında doğrusal ara değer üretir:

`Lerp(a, b, t) = a + (b - a) * t`  (t = 0 → a, t = 1 → b)

**Slerp (Spherical Linear Interpolation)**, iki yön veya rotasyon arasında **küre yüzeyi boyunca** sabit açısal hızla ara değer üretir. Rotasyonlar için `Quaternion.Slerp` kullanılır; Lerp rotasyonlarda ara noktalarda hız değişimine ve kısalmış vektörlere yol açar.

```csharp
// Doğru kullanım: sabit sürede A'dan B'ye
IEnumerator MoveOverTime(Vector3 from, Vector3 to, float duration)
{
    float elapsed = 0f;
    while (elapsed < duration)
    {
        elapsed += Time.deltaTime;
        float t = Mathf.Clamp01(elapsed / duration);
        transform.position = Vector3.Lerp(from, to, t);
        yield return null;
    }
}
```

### Yaygın yanlış kullanım

```csharp
void Update()
{
    transform.position = Vector3.Lerp(transform.position, target, 0.1f);
}
```

Bu kod her kare kalan mesafenin %10'unu gider. Sorunları:

- **Frame rate bağımlıdır:** 144 FPS'te 30 FPS'ten çok daha hızlı yaklaşır.
- Hedefe **asla tam ulaşmaz** (asimptotik).

Bu "yumuşak takip" efekti isteniyorsa frame rate bağımsız hâli kullanılmalıdır:

```csharp
float k = 1f - Mathf.Exp(-sharpness * Time.deltaTime);
transform.position = Vector3.Lerp(transform.position, target, k);
```

Alternatif olarak `Vector3.SmoothDamp` veya sabit hız için `Vector3.MoveTowards` tercih edilir.$md$, null, $md$medium$md$, $md$game-developer$md$, $md$oyun-matematigi$md$),
  ($md$quaternion-ile-euler-acilari-arasindaki-fark-nedir-gimbal-lock-nedir$md$, $md$Quaternion ile Euler açıları arasındaki fark nedir? Gimbal lock nedir?$md$, $md$**Euler açıları**, rotasyonu üç eksen etrafındaki ardışık dönüşler olarak tutar (Unity'de Inspector'daki X, Y, Z). İnsan için okunabilir ama iki ciddi sorunu vardır:

### Gimbal lock

Eksenler sırayla uygulandığı için, ortadaki eksen 90 derece dönünce diğer iki eksen **aynı düzleme hizalanır**. Bu durumda bir serbestlik derecesi kaybedilir: iki farklı açıyı değiştirmek aynı dönüşü üretir ve bazı yönlere doğrudan dönmek imkânsız hâle gelir. Ör. uçak burnunu tam yukarı (pitch 90) kaldırınca yaw ve roll aynı etkiyi verir.

### Interpolasyon sorunu

Euler değerleri arasında Lerp yapmak tuhaf yollar çizer ve 350'den 10 dereceye geçerken uzun yolu dolaşabilir.

### Quaternion

Quaternion, rotasyonu **bir eksen ve o eksen etrafındaki açı** olarak 4 bileşenle (x, y, z, w) temsil eder. Bileşenler doğrudan açı değildir, elle düzenlenmez.

| Özellik | Euler | Quaternion |
| --- | --- | --- |
| Okunabilirlik | Yüksek | Düşük |
| Gimbal lock | Var | Yok |
| Yumuşak interpolasyon | Zor | `Slerp` ile kolay |
| Rotasyon birleştirme | Karmaşık | Çarpma ile (`q1 * q2`) |
| Bellek | 3 float | 4 float |

```csharp
// Hedefe doğru bak
Quaternion look = Quaternion.LookRotation(target.position - transform.position);
transform.rotation = Quaternion.Slerp(transform.rotation, look, 5f * Time.deltaTime);

// Rotasyonları birleştir: sıra önemlidir, çarpma değişmeli değildir
transform.rotation = transform.rotation * Quaternion.Euler(0, 90, 0); // yerel Y etrafında
transform.rotation = Quaternion.AngleAxis(45, Vector3.up) * transform.rotation; // dünya Y etrafında

// Quaternion ile vektör döndürme
Vector3 rotated = Quaternion.Euler(0, 30, 0) * Vector3.forward;
```

Pratik kural: Tasarımcı girişi ve gösterim için Euler, çalışma zamanındaki hesaplamalar için Quaternion kullanılır. `transform.eulerAngles` okunan değer her zaman yazılanla aynı olmayabilir (aynı rotasyonun birden fazla Euler karşılığı vardır), bu yüzden okuyup artırarak döndürmek hatalara yol açar.$md$, null, $md$hard$md$, $md$game-developer$md$, $md$oyun-matematigi$md$),
  ($md$transform-matrisleri-nedir-local-space-ile-world-space-arasinda-nasil-donusum-ya$md$, $md$Transform matrisleri nedir? Local space ile world space arasında nasıl dönüşüm yapılır?$md$, $md$Bir nesnenin konumu, rotasyonu ve ölçeği 4x4'lük bir **transform matrisi** ile ifade edilir. Bu matris **TRS** (Translation × Rotation × Scale) çarpımıdır. Homojen koordinatlar (4. bileşen w) sayesinde öteleme de matris çarpımıyla yapılabilir: nokta için w = 1, yön için w = 0 (yönler ötelemeden etkilenmez).

### Uzaylar

- **Local (object) space:** Nesnenin kendi orijinine ve eksenlerine göre koordinatlar.
- **World space:** Sahnenin global koordinatları.
- Hiyerarşide çocuk nesnenin dünya matrisi: `World = ParentWorld × ChildLocal`.
- Render'da devamı: World → **View** (kamera uzayı) → **Projection** (clip space). Bu zincire **MVP matrisi** denir.

### Unity'de dönüşümler

```csharp
// Nokta: konum, rotasyon ve ölçek uygulanır
Vector3 worldPos = transform.TransformPoint(new Vector3(0, 1, 2));
Vector3 localPos = transform.InverseTransformPoint(enemy.position);

// Yön: sadece rotasyon (ölçek ve konum yok)
Vector3 worldDir = transform.TransformDirection(Vector3.forward); // = transform.forward

// Vektör: rotasyon + ölçek, konum yok
Vector3 worldVec = transform.TransformVector(Vector3.right);

// Matris ile
Matrix4x4 m = transform.localToWorldMatrix;
Vector3 p = m.MultiplyPoint3x4(localPoint);
```

### Pratik örnekler

- **Düşman önümde mi, sağımda mı?** `InverseTransformPoint(enemy.position)` sonucunda `z > 0` önde, `x > 0` sağda demektir.
- **Silah namlusundan mermi:** Namlunun yerel ucundaki noktayı dünya konumuna çevirmek.
- **Matris çarpım sırası önemlidir:** Önce ölçek, sonra rotasyon, sonra öteleme uygulanır; sıra değişirse sonuç değişir.
- Ters matris (inverse) dünya uzayından yerele geri dönmeyi sağlar; ölçeksiz ortogonal rotasyonlarda tersi transpozuna eşittir ve ucuzdur.$md$, null, $md$medium$md$, $md$game-developer$md$, $md$oyun-matematigi$md$),
  ($md$aabb-ve-sphere-carpisma-testleri-matematiksel-olarak-nasil-yapilir-hangisi-ne-za$md$, $md$AABB ve sphere çarpışma testleri matematiksel olarak nasıl yapılır? Hangisi ne zaman tercih edilir?$md$, $md$### Sphere - Sphere

İki kürenin merkezleri arasındaki mesafe yarıçaplar toplamından küçükse çarpışırlar. Karekökten kaçınmak için kareler karşılaştırılır:

```csharp
bool SphereVsSphere(Vector3 c1, float r1, Vector3 c2, float r2)
{
    float r = r1 + r2;
    return (c1 - c2).sqrMagnitude <= r * r;
}
```

### AABB - AABB

**AABB (Axis-Aligned Bounding Box)**, kenarları dünya eksenlerine paralel kutudur; `min` ve `max` köşeleriyle tanımlanır. İki AABB **her üç eksende de** örtüşüyorsa çarpışır (Separating Axis Theorem'in en basit hâli):

```csharp
bool AabbVsAabb(Vector3 aMin, Vector3 aMax, Vector3 bMin, Vector3 bMax)
{
    return aMin.x <= bMax.x && aMax.x >= bMin.x
        && aMin.y <= bMax.y && aMax.y >= bMin.y
        && aMin.z <= bMax.z && aMax.z >= bMin.z;
}
```

### Sphere - AABB

Kutu üzerinde küre merkezine en yakın nokta, merkezi kutu sınırlarına **clamp** ederek bulunur; o noktanın merkeze uzaklığı yarıçapla karşılaştırılır:

```csharp
bool SphereVsAabb(Vector3 c, float r, Vector3 min, Vector3 max)
{
    Vector3 closest = Vector3.Max(min, Vector3.Min(c, max));
    return (closest - c).sqrMagnitude <= r * r;
}
```

### Karşılaştırma

| Özellik | Sphere | AABB |
| --- | --- | --- |
| Test maliyeti | Çok düşük | Çok düşük |
| Rotasyon | Etkilenmez | Nesne dönünce yeniden hesaplanmalı |
| Uzun/ince nesneler | Kötü uyum, çok boşluk | Daha iyi uyum |
| Tipik kullanım | Karakter, mermi, patlama yarıçapı | Duvar, kutu, uzaysal bölümleme |

Fizik motorları bu testleri **broad phase**'de kullanır: önce ucuz AABB testleriyle (BVH, sweep and prune) olası çiftler bulunur, sonra **narrow phase**'de pahalı ve hassas testler (OBB, GJK, mesh) yapılır. Döndürülmüş kutular için **OBB** ve SAT ile 15 eksene kadar test gerekir.$md$, null, $md$medium$md$, $md$game-developer$md$, $md$oyun-matematigi$md$),
  ($md$rendering-pipeline-nasil-isler-vertex-shader-ile-fragment-shader-arasindaki-fark$md$, $md$Rendering pipeline nasıl işler? Vertex shader ile fragment shader arasındaki fark nedir?$md$, $md$GPU'da bir mesh'in ekrana çizilmesi kabaca şu aşamalardan geçer:

1. **Input assembly:** Vertex ve index buffer'lardan üçgenler oluşturulur.
2. **Vertex shader:** Her **vertex** için bir kez çalışır. Vertex'i object space'ten clip space'e dönüştürür (MVP matrisi), normal, UV gibi verileri sonraki aşamaya aktarır.
3. **Rasterization:** Üçgenler ekran piksellerine karşılık gelen **fragment**'lara bölünür; vertex verileri üçgen boyunca interpolasyonla dağıtılır. Back-face culling ve clipping burada yapılır.
4. **Fragment (pixel) shader:** Her fragment için çalışır. Doku örnekleme, ışıklandırma hesabı yaparak son rengi üretir.
5. **Output merger:** Depth test, stencil test ve blending (saydamlık) uygulanıp sonuç frame buffer'a yazılır.

```hlsl
struct appdata { float4 vertex : POSITION; float2 uv : TEXCOORD0; };
struct v2f     { float4 pos : SV_POSITION; float2 uv : TEXCOORD0; };

sampler2D _MainTex;
float4 _Color;

v2f vert (appdata v)
{
    v2f o;
    o.pos = UnityObjectToClipPos(v.vertex);   // MVP dönüşümü
    o.uv = v.uv;
    return o;
}

float4 frag (v2f i) : SV_Target
{
    return tex2D(_MainTex, i.uv) * _Color;    // piksel rengi
}
```

| Özellik | Vertex shader | Fragment shader |
| --- | --- | --- |
| Kaç kez çalışır | Vertex başına | Piksel (fragment) başına |
| Temel görevi | Konum dönüşümü, deformasyon | Renk, doku, ışık |
| Tipik efektler | Dalgalanan su, rüzgârda çimen, skinning | Toon shading, dissolve, normal map |

Fragment sayısı genellikle vertex sayısından çok fazladır; bu yüzden pahalı hesapları mümkünse vertex shader'a taşımak ve **overdraw**'u (aynı pikselin defalarca çizilmesi) azaltmak önemli optimizasyonlardır. Pipeline'da ayrıca opsiyonel geometry ve tessellation aşamaları ile genel amaçlı compute shader'lar bulunur.$md$, null, $md$medium$md$, $md$game-developer$md$, $md$grafik-render$md$),
  ($md$draw-call-nedir-batching-teknikleri-ile-draw-call-sayisi-nasil-azaltilir$md$, $md$Draw call nedir? Batching teknikleri ile draw call sayısı nasıl azaltılır?$md$, $md$**Draw call**, CPU'nun GPU'ya "bu mesh'i bu materyalle çiz" komutunu göndermesidir. Asıl maliyet çoğu zaman çizimin kendisi değil, her çağrıdan önce yapılan **state değişimleridir** (shader, doku, buffer bağlama). Çok sayıda draw call **CPU-bound** darboğaz yaratır, özellikle mobilde.

Unity'de bu sayı **Frame Debugger** ve Stats penceresindeki **Batches / SetPass calls** değerlerinden izlenir.

### Azaltma teknikleri

- **Static batching:** Hareket etmeyen ve aynı materyali kullanan nesneler build sırasında tek büyük mesh'te birleştirilir. Hızlıdır ama ek bellek kullanır.
- **Dynamic batching:** Küçük (az vertex'li) hareketli mesh'ler her kare CPU'da birleştirilir. CPU maliyeti nedeniyle modern projelerde faydası sınırlıdır.
- **GPU Instancing:** Aynı mesh ve materyalin çok sayıda kopyası (ağaç, çimen, asker) tek çağrıyla, kopya başına farklı matris/renk verisiyle çizilir.
- **SRP Batcher (URP/HDRP):** Draw call sayısını değil, çağrılar arasındaki **materyal verisi yükleme maliyetini** azaltır; aynı shader varyantını kullanan nesneler hızlı çizilir.
- **Texture atlas:** Farklı dokuları tek dokuda toplayarak nesnelerin aynı materyali paylaşmasını sağlar. UI'da **Sprite Atlas** batching için kritiktir.
- **Mesh birleştirme:** Elle veya araçla birden fazla mesh'i tek mesh'e çevirmek.
- **Materyal sayısını azaltmak:** Her farklı materyal ayrı batch demektir; `renderer.material` erişimi materyalin kopyasını oluşturup batching'i bozar, paylaşılan değişiklik için `sharedMaterial` veya `MaterialPropertyBlock` kullanılır.

### Batching'i bozan durumlar

- Farklı materyal veya doku
- Farklı lightmap indeksleri
- Saydam nesnelerin sıralama gereksinimi
- Negatif ölçek (bazı batching türlerinde)

Optimizasyona başlamadan önce darboğazın CPU mu GPU mu olduğu Profiler ile belirlenmelidir; GPU fill-rate'e takılıyorsanız draw call azaltmak işe yaramaz.$md$, $md$renderer.material ile sharedMaterial farkını ve MaterialPropertyBlock'u bilmek pratik deneyim göstergesidir; bu detayı mutlaka söyleyin.$md$, $md$medium$md$, $md$game-developer$md$, $md$grafik-render$md$),
  ($md$lod-frustum-culling-ve-occlusion-culling-nedir$md$, $md$LOD, frustum culling ve occlusion culling nedir?$md$, $md$Üçü de **çizilmesi gerekmeyeni çizmemek** veya **daha ucuz çizmek** için kullanılan tekniklerdir.

### Frustum culling

Kameranın görüş hacmi (frustum: near/far düzlemleri ve dört yan düzlemle sınırlı kesik piramit) dışında kalan nesneler çizilmez. Genellikle nesnelerin bounding box'ı frustum düzlemleriyle test edilir. Unity bunu **otomatik** yapar.

### Occlusion culling

Kamera görüş alanında olsa bile **başka nesnelerin arkasında kalan** (ör. duvarın arkasındaki oda) nesneler çizilmez. Unity'de görünürlük verisi editörde önceden hesaplanır (**bake**); statik nesneler occluder/occludee olarak işaretlenir. Şehir, iç mekân gibi kapalı sahnelerde büyük kazanç sağlar, açık arazide faydası azdır. Bake verisi bellek ve CPU maliyeti getirir.

### LOD (Level of Detail)

Nesne kameradan uzaklaştıkça daha düşük poligonlu modeller kullanılır. Unity'de **LOD Group** bileşeni ekranda kapladığı alana göre geçiş yapar:

| Seviye | Ekran oranı | Örnek üçgen sayısı |
| --- | --- | --- |
| LOD0 | %60 üstü | 20.000 |
| LOD1 | %30 - %60 | 8.000 |
| LOD2 | %10 - %30 | 2.000 |
| Culled | %10 altı | Çizilmez |

- Geçişlerde "pop" efekti olmaması için **cross-fade** veya dithering kullanılır.
- Çok uzaktaki nesneler için **impostor/billboard** (düz bir kartta ön render'lanmış görüntü) kullanılabilir.

Ek olarak kameranın **far clip plane** değerini gereksiz büyük tutmamak ve sis ile uzak mesafeyi gizlemek de yaygın pratiktir.$md$, null, $md$easy$md$, $md$game-developer$md$, $md$grafik-render$md$),
  ($md$forward-ve-deferred-rendering-arasindaki-fark-nedir-hangisi-ne-zaman-tercih-edil$md$, $md$Forward ve deferred rendering arasındaki fark nedir? Hangisi ne zaman tercih edilir?$md$, $md$### Forward rendering

Her nesne çizilirken onu etkileyen **tüm ışıklar** aynı anda shader'da hesaplanır. Klasik maliyet yaklaşık **nesne sayısı × ışık sayısı**dır. Unity'nin built-in pipeline'ında ek ışıklar ek pass'lere yol açar; URP'de ise ışıklar tek pass'te, nesne başına sınırlı sayıda hesaplanır.

### Deferred rendering

İki aşamada çalışır:

1. **Geometry pass:** Tüm nesneler bir kez çizilir; ışık hesaplanmaz. Her pikselin albedo, normal, derinlik, metalik/pürüzlülük gibi bilgileri birden fazla render target'tan oluşan **G-Buffer**'a yazılır.
2. **Lighting pass:** Her ışık, sadece etkilediği ekran pikselleri için G-Buffer'ı okuyarak ışık hesabı yapar.

Maliyet yaklaşık **ekran pikseli × piksel başına ışık** olur; nesne sayısından bağımsızdır.

| Özellik | Forward | Deferred |
| --- | --- | --- |
| Çok sayıda dinamik ışık | Pahalı | Ucuz |
| Bellek ve bant genişliği | Düşük | Yüksek (G-Buffer) |
| MSAA | Doğrudan desteklenir | Pratikte desteklenmez, TAA/FXAA gerekir |
| Saydam nesneler | Doğal | Ayrı forward pass ile çizilir |
| Materyal çeşitliliği | Serbest | G-Buffer formatıyla sınırlı |
| Mobil / VR | Uygun | Genellikle uygun değil |

### Ne zaman hangisi

- **Forward:** Mobil, VR (MSAA ve bant genişliği önemli), az ışıklı sahneler, stilize grafikler, çok sayıda saydam nesne.
- **Deferred:** PC/konsolda çok sayıda dinamik ışık (gece şehri, patlamalar), SSAO ve screen space reflection gibi G-Buffer'dan faydalanan efektler.

### Hibrit yaklaşımlar

- **Forward+ (tiled/clustered forward):** Ekran tile'lara veya 3B cluster'lara bölünür, her tile'ı etkileyen ışık listesi compute shader ile çıkarılır. Forward'ın esnekliği ve MSAA desteğiyle çok sayıda ışığı birleştirir. Unity URP'de **Forward+** seçeneği vardır.
- Modern motorların çoğu deferred ana pass + forward saydamlık pass kombinasyonu kullanır.$md$, $md$Sadece tabloyu ezberlemeyin; G-Buffer'ın bant genişliği maliyetinin mobilde neden sorun olduğunu (tile-based GPU'lar) açıklayabilmek fark yaratır.$md$, $md$hard$md$, $md$game-developer$md$, $md$grafik-render$md$),
  ($md$arp-nedir-ve-bir-cihaz-ayni-agdaki-baska-bir-cihazin-mac-adresini-nasil-ogrenir$md$, $md$ARP nedir ve bir cihaz aynı ağdaki başka bir cihazın MAC adresini nasıl öğrenir?$md$, $md$**ARP (Address Resolution Protocol)**, bilinen bir IPv4 adresine karşılık gelen MAC adresini bulmak için kullanılır. Ethernet çerçevesi gönderebilmek için hedef MAC adresi gerekir; IP adresi tek başına yetmez.

### Akış

1. Host önce kendi **ARP tablosuna (cache)** bakar.
2. Kayıt yoksa **ARP Request** yayınlar: hedef MAC `ff:ff:ff:ff:ff:ff` (broadcast), içerik "192.168.1.20 kimde? 192.168.1.10'a söyle".
3. Yalnızca o IP'nin sahibi **ARP Reply** ile cevap verir; bu yanıt **unicast**'tir.
4. Gönderen eşleşmeyi cache'e yazar (Linux'ta tipik olarak birkaç dakika, Cisco'da varsayılan 4 saat).

Hedef **farklı bir subnet**'teyse host, hedefin değil **default gateway**'in MAC adresini ARP ile çözer.

```bash
ip neigh show          # Linux ARP tablosu
arp -a                 # Windows / macOS
show ip arp            # Cisco IOS
```

### İlgili kavramlar

- **Gratuitous ARP:** Bir cihazın kendi IP'si için ARP yayınlaması; IP çakışması tespiti ve HSRP/VRRP failover'ında MAC tablolarını güncellemek için kullanılır.
- **ARP spoofing:** Saldırganın sahte ARP reply ile kendini gateway gibi göstermesi (MITM). Önlem: switch'te **Dynamic ARP Inspection (DAI)** + DHCP snooping.
- IPv6'da ARP yoktur; yerine **NDP (Neighbor Discovery)** ICMPv6 mesajlarıyla aynı işi yapar.$md$, $md$ARP'nin Layer 2 ile Layer 3 arasında çalıştığını ve farklı subnet'teki hedef için gateway MAC'inin çözüldüğünü söylemek, mülakatçının aradığı kritik ayrıntıdır.$md$, $md$easy$md$, $md$network-engineer$md$, $md$ag-temelleri$md$),
  ($md$dhcp-nin-dora-sureci-nasil-isler$md$, $md$DHCP'nin DORA süreci nasıl işler?$md$, $md$DHCP, istemcilere IP adresi, subnet mask, default gateway, DNS gibi ayarları otomatik dağıtır. UDP üzerinde çalışır: **sunucu 67**, **istemci 68** numaralı port.

| Adım | Mesaj | Yön | Hedef |
| --- | --- | --- | --- |
| D | **Discover** | İstemci → ağ | Broadcast (255.255.255.255) |
| O | **Offer** | Sunucu → istemci | Önerilen IP ve ayarlar |
| R | **Request** | İstemci → ağ | Broadcast; seçilen teklifi duyurur |
| A | **Acknowledge** | Sunucu → istemci | Kira (lease) onaylanır |

Request mesajının broadcast olmasının sebebi: birden fazla sunucu teklif verdiyse, seçilmeyenlerin de bunu öğrenip teklif ettikleri adresi havuza geri koymasıdır.

### Lease yenileme

- Sürenin **%50**'sinde (T1) istemci, aynı sunucuya unicast Request ile yenileme ister.
- **%87.5**'te (T2) cevap alamadıysa herhangi bir sunucuya broadcast Request gönderir.

### DHCP Relay

Broadcast router'ı geçmez. Sunucu başka subnet'teyse router arayüzüne relay tanımlanır:

```text
interface Vlan10
 ip address 10.10.10.1 255.255.255.0
 ip helper-address 10.0.0.5
```

Ayrıca sahte DHCP sunucularına karşı switch'lerde **DHCP snooping** açılır; yalnızca trusted portlardan Offer/Ack geçer.$md$, null, $md$easy$md$, $md$network-engineer$md$, $md$ag-temelleri$md$),
  ($md$nat-ve-pat-arasindaki-fark-nedir-static-nat-dynamic-nat-ve-pat-ne-zaman-kullanil$md$, $md$NAT ve PAT arasındaki fark nedir? Static NAT, dynamic NAT ve PAT ne zaman kullanılır?$md$, $md$**NAT (Network Address Translation)** paketlerin IP adreslerini router/firewall üzerinden geçerken değiştirir. Temel amaç, private adreslerin internete çıkabilmesi ve IPv4 adres kıtlığını yönetmektir.

| Tür | Eşleme | Kullanım |
| --- | --- | --- |
| **Static NAT** | 1 private ↔ 1 public, kalıcı | İçerideki bir sunucuyu dışarıya açmak |
| **Dynamic NAT** | Private → public havuzdan geçici 1:1 | Havuz kadar eşzamanlı kullanıcı; nadiren kullanılır |
| **PAT (NAT overload)** | Çok private → tek public IP, port ile ayrıştırılır | Ev ve ofis internet çıkışı |

PAT, her oturumu `iç IP:iç port ↔ dış IP:dış port` şeklinde **translation tablosunda** tutar; teorik olarak tek IP ile ~65 bin eşzamanlı akış yönetilebilir.

### Cisco örneği (PAT)

```text
interface Gi0/0
 ip nat outside
interface Gi0/1
 ip nat inside
access-list 1 permit 192.168.1.0 0.0.0.255
ip nat inside source list 1 interface Gi0/0 overload
!
! Static NAT ile port yönlendirme
ip nat inside source static tcp 192.168.1.10 443 203.0.113.5 443
```

```text
show ip nat translations
```

### Dezavantajlar

- Uçtan uca bağlantıyı bozar; dışarıdan içeriye bağlantı başlatmak zorlaşır.
- IPsec (AH), SIP, FTP aktif mod gibi IP/port bilgisini payload'da taşıyan protokollerde **ALG** veya **NAT-T** gerekir.
- IPv6 ile NAT ihtiyacı büyük ölçüde ortadan kalkar.$md$, $md$Terimlere dikkat: inside local (cihazın private IP'si), inside global (dışarıda görünen public IP). Cisco mülakatlarında bu dört terim sık sorulur.$md$, $md$medium$md$, $md$network-engineer$md$, $md$ag-temelleri$md$),
  ($md$ipv4-ile-ipv6-arasindaki-temel-farklar-nelerdir$md$, $md$IPv4 ile IPv6 arasındaki temel farklar nelerdir?$md$, $md$| Özellik | IPv4 | IPv6 |
| --- | --- | --- |
| Adres uzunluğu | 32 bit (~4.3 milyar) | 128 bit |
| Yazım | `192.168.1.1` | `2001:db8::1` (hex, `::` ile sıfır kısaltma) |
| Header | Değişken (20-60 byte), checksum var | Sabit 40 byte, checksum yok, extension header'lar |
| Fragmentation | Router'lar da yapabilir | Yalnızca kaynak yapar (Path MTU Discovery) |
| Adres çözümleme | ARP | NDP (ICMPv6) |
| Broadcast | Var | **Yok**; multicast ve anycast kullanılır |
| Otomatik yapılandırma | DHCP | SLAAC ve/veya DHCPv6 |
| Minimum MTU | 68 byte | 1280 byte |
| NAT | Yaygın | Genelde gereksiz |

### IPv6 adres türleri

- **Global Unicast:** `2000::/3`, internette yönlendirilebilir.
- **Link-Local:** `fe80::/10`, her arayüzde otomatik oluşur, router'ı geçmez. Routing protokolleri komşuluk için bunu kullanır.
- **Unique Local:** `fc00::/7` (pratikte `fd00::/8`), IPv4 private adreslerin karşılığı.
- **Multicast:** `ff00::/8`, örn. `ff02::1` tüm node'lar.

### Geçiş yöntemleri

- **Dual stack:** Cihaz iki protokolü birden çalıştırır, en yaygın yöntem.
- **Tunneling:** IPv6'yı IPv4 üzerinden taşımak (6in4, GRE).
- **NAT64/DNS64:** Yalnızca IPv6 olan istemcinin IPv4 sunuculara erişmesi.

Bir LAN subnet'i IPv6'da standart olarak **/64**'tür; SLAAC bunu gerektirir.$md$, null, $md$medium$md$, $md$network-engineer$md$, $md$ag-temelleri$md$),
  ($md$private-ip-adres-araliklari-nelerdir-ve-neden-kullanilir$md$, $md$Private IP adres aralıkları nelerdir ve neden kullanılır?$md$, $md$**RFC 1918** ile tanımlanan private aralıklar internette yönlendirilmez; her kurum kendi içinde serbestçe kullanabilir. İnternete çıkış için NAT/PAT gerekir.

| Sınıf | Aralık | CIDR | Adres sayısı |
| --- | --- | --- | --- |
| A | 10.0.0.0 – 10.255.255.255 | `10.0.0.0/8` | ~16.7 milyon |
| B | 172.16.0.0 – 172.31.255.255 | `172.16.0.0/12` | ~1 milyon |
| C | 192.168.0.0 – 192.168.255.255 | `192.168.0.0/16` | 65.536 |

### Bilinmesi gereken diğer özel aralıklar

- `127.0.0.0/8`: Loopback (`127.0.0.1` localhost).
- `169.254.0.0/16`: **APIPA / link-local**. Host DHCP'den adres alamadığında kendine bu aralıktan atar; sorun giderirken önemli bir işarettir.
- `100.64.0.0/10`: **CGNAT** (RFC 6598), operatörlerin abonelere verdiği paylaşımlı adresler.
- `0.0.0.0/8`: "Bu ağ"; `0.0.0.0/0` default route anlamına gelir.
- `224.0.0.0/4`: Multicast.
- `192.0.2.0/24`, `198.51.100.0/24`, `203.0.113.0/24`: Dokümantasyon örnekleri.

### Neden kullanılır?

- IPv4 adres kıtlığı: binlerce cihaz tek public IP arkasında çalışır.
- Güvenlik katkısı: içerideki cihazlar doğrudan adreslenemez (ama NAT bir güvenlik mekanizması değildir, firewall yerine geçmez).
- Adres planlamada esneklik: ISP değişse de iç adresleme aynı kalır.$md$, $md$Kullanıcı 169.254.x.x adresi alıyorsa ilk şüphe DHCP sunucusuna erişilememesidir; VLAN, kablo veya relay ayarını kontrol edin.$md$, $md$easy$md$, $md$network-engineer$md$, $md$ag-temelleri$md$),
  ($md$mtu-nedir-ip-fragmentation-nasil-calisir-ve-path-mtu-discovery-neden-sorun-cikar$md$, $md$MTU nedir? IP fragmentation nasıl çalışır ve Path MTU Discovery neden sorun çıkarabilir?$md$, $md$**MTU (Maximum Transmission Unit)**, bir linkin taşıyabileceği en büyük L3 paket boyutudur. Ethernet'te varsayılan **1500 byte**'tır. TCP için **MSS** = MTU − 40 (IP 20 + TCP 20) = **1460 byte**.

### IPv4 fragmentation

Paket, çıkış arayüzünün MTU'sundan büyükse router onu parçalara böler. Header'daki alanlar:

- **Identification:** Aynı paketin parçalarını eşleştirir.
- **Flags:** `DF` (Don't Fragment), `MF` (More Fragments).
- **Fragment Offset:** 8 byte birimleriyle parçanın yeri.

Birleştirme (reassembly) yalnızca **hedef host**'ta yapılır. Fragmentation CPU yükü getirir; tek parça kaybolursa tüm paket yeniden gönderilir.

### Path MTU Discovery (PMTUD)

Kaynak `DF=1` ile gönderir. Yoldaki router paketi geçiremezse düşürür ve **ICMP Type 3 Code 4 (Fragmentation Needed)** ile izin verilen MTU'yu bildirir. IPv6'da router hiç fragment etmez; **ICMPv6 Packet Too Big** gönderir.

### Klasik sorun: PMTUD black hole

Bir firewall tüm ICMP'yi engellerse kaynak uyarıyı hiç almaz. Sonuç: TCP el sıkışması başarılı olur, küçük istekler çalışır ama büyük yanıtlar (web sayfası, dosya) **takılır**. Bu, VPN, GRE ve PPPoE (1492) gibi overhead ekleyen yollarda çok yaygındır.

### Çözümler

```text
! Cisco: tünel arayüzünde TCP MSS'i düşür
interface Tunnel0
 ip mtu 1400
 ip tcp adjust-mss 1360
```

```bash
# Yol MTU'sunu test et (Linux): 1472 + 28 = 1500
ping -M do -s 1472 8.8.8.8
```

- ICMP Type 3 Code 4'ü firewall'da izinli bırakın.
- Datacenter'da **jumbo frame** (9000) kullanılıyorsa uçtan uca tüm cihazlarda aynı olmalıdır.$md$, $md$'Ping çalışıyor ama site açılmıyor, özellikle VPN üzerinden' senaryosu sorulursa ilk cevabınız MTU/MSS olmalı.$md$, $md$hard$md$, $md$network-engineer$md$, $md$ag-temelleri$md$),
  ($md$icmp-nedir-ping-ve-traceroute-arka-planda-nasil-calisir$md$, $md$ICMP nedir? ping ve traceroute arka planda nasıl çalışır?$md$, $md$**ICMP**, IP katmanında hata bildirme ve tanı amaçlı kullanılan bir protokoldür (IP protocol number **1**). Port kavramı yoktur; mesajlar **type/code** ile ayrılır.

| Type | Anlam |
| --- | --- |
| 0 | Echo Reply |
| 3 | Destination Unreachable (code 3: port unreachable, code 4: fragmentation needed) |
| 5 | Redirect |
| 8 | Echo Request |
| 11 | Time Exceeded (TTL sıfırlandı) |

### ping

Kaynak **Echo Request (8)** gönderir, hedef **Echo Reply (0)** döner. Çıktıdaki RTT gecikmeyi, kayıp oranı link kalitesini gösterir. Ping'e cevap gelmemesi hostun kapalı olduğu anlamına gelmez; ICMP firewall'da engellenmiş olabilir.

### traceroute

**TTL** alanını kullanır. Her router paketi iletirken TTL'i 1 azaltır; 0 olursa paketi düşürüp **Time Exceeded (11)** gönderir.

1. TTL=1 ile paket gönderilir → ilk router cevap verir.
2. TTL=2 → ikinci router cevap verir.
3. Hedefe ulaşılana kadar devam edilir. Hedef, UDP kullanılıyorsa **Port Unreachable**, ICMP kullanılıyorsa **Echo Reply** ile cevap verir.

| Araç | Varsayılan probe |
| --- | --- |
| Linux/Cisco `traceroute` | UDP, yüksek portlar (33434+) |
| Windows `tracert` | ICMP Echo |
| `traceroute -T` / `tcptraceroute` | TCP SYN (firewall'ları aşmak için) |

```bash
traceroute -n 8.8.8.8
mtr 8.8.8.8      # ping + traceroute sürekli
```

Çıktıda `* * *` görmek, o hop'un ICMP göndermediği veya rate-limit uyguladığı anlamına gelebilir; ardından gelen hop'lar cevap veriyorsa sorun değildir.$md$, null, $md$medium$md$, $md$network-engineer$md$, $md$ag-temelleri$md$),
  ($md$bilinmesi-gereken-yaygin-port-numaralari-nelerdir-http-ve-https-arasindaki-fark$md$, $md$Bilinmesi gereken yaygın port numaraları nelerdir? HTTP ve HTTPS arasındaki fark nedir?$md$, $md$**HTTP** varsayılan olarak **TCP 80**, **HTTPS** ise **TCP 443** kullanır. HTTPS, HTTP'nin **TLS** üzerinde çalışan hâlidir: veri şifrelenir, sunucu kimliği sertifika ile doğrulanır ve bütünlük korunur. HTTP/3 ise **UDP 443** üzerinde QUIC kullanır.

| Port | Protokol | Taşıma | Not |
| --- | --- | --- | --- |
| 20/21 | FTP | TCP | 20 veri, 21 kontrol |
| 22 | SSH / SFTP / SCP | TCP | Güvenli uzaktan erişim |
| 23 | Telnet | TCP | Şifresiz, kullanılmamalı |
| 25 | SMTP | TCP | 587 submission, 465 SMTPS |
| 53 | DNS | UDP + TCP | Büyük yanıt ve zone transfer TCP |
| 67/68 | DHCP | UDP | Sunucu 67, istemci 68 |
| 69 | TFTP | UDP | Cihaz imajı/konfig yükleme |
| 80 | HTTP | TCP | |
| 110 / 143 | POP3 / IMAP | TCP | TLS'li: 995 / 993 |
| 123 | NTP | UDP | Zaman senkronizasyonu |
| 161/162 | SNMP | UDP | 162 trap |
| 179 | BGP | TCP | |
| 389 / 636 | LDAP / LDAPS | TCP | |
| 443 | HTTPS | TCP (QUIC: UDP) | |
| 445 | SMB | TCP | |
| 514 | Syslog | UDP | |
| 1812/1813 | RADIUS | UDP | Auth / accounting |
| 3389 | RDP | TCP | |

### Port aralıkları

- **0–1023:** Well-known
- **1024–49151:** Registered
- **49152–65535:** Dynamic / ephemeral (istemci kaynak portları)

OSPF (IP protokol 89), EIGRP (88) ve ICMP (1) port kullanmaz; doğrudan IP üzerinde çalışır.$md$, $md$Mülakatta 'DNS hangi portu kullanır?' sorusuna sadece 'UDP 53' demeyin; TCP 53'ün zone transfer ve büyük yanıtlar için kullanıldığını eklemek fark yaratır.$md$, $md$easy$md$, $md$network-engineer$md$, $md$ag-temelleri$md$),
  ($md$spanning-tree-protocol-stp-neden-gereklidir-ve-root-bridge-nasil-secilir$md$, $md$Spanning Tree Protocol (STP) neden gereklidir ve root bridge nasıl seçilir?$md$, $md$Switch'ler arasında yedeklilik için birden fazla link kurulduğunda Layer 2'de **döngü** oluşur. Ethernet çerçevesinde TTL olmadığı için broadcast'ler sonsuza dek döner: **broadcast storm**, MAC tablosu kararsızlığı ve çoğaltılmış çerçeveler ağı dakikalar içinde çökertir. **STP (802.1D)** bazı portları bloklayarak döngüsüz bir ağaç topolojisi oluşturur.

### Seçim süreci

1. **Root bridge seçimi:** En düşük **Bridge ID** kazanır. Bridge ID = priority (varsayılan 32768 + VLAN ID) + MAC adresi. Eşitlikte en düşük MAC kazanır.
2. **Root port:** Her root olmayan switch'te root'a en düşük **path cost**'a sahip port.
3. **Designated port:** Her segmentte root'a en yakın switch'in portu.
4. Kalan portlar **blocking** (RSTP'de alternate/backup) olur.

| Hız | Path cost (kısa yöntem) |
| --- | --- |
| 10 Mbps | 100 |
| 100 Mbps | 19 |
| 1 Gbps | 4 |
| 10 Gbps | 2 |

### Root'u bilinçli seçmek

Root bridge'i rastgele bırakmak (en eski, en düşük MAC'li switch olabilir) kötü pratiktir:

```text
spanning-tree vlan 10,20 priority 4096
! veya
spanning-tree vlan 10 root primary
```

### Varyantlar ve korumalar

- **RSTP (802.1w):** Yakınsama 30-50 sn yerine 1-2 sn. Günümüzde varsayılan tercih.
- **PVST+ / Rapid PVST+:** Cisco, her VLAN için ayrı STP instance.
- **MSTP (802.1s):** VLAN'ları gruplayıp az sayıda instance.
- **PortFast:** Uç cihaz portlarını anında forwarding'e alır.
- **BPDU Guard:** PortFast portunda BPDU gelirse portu err-disable yapar.
- **Root Guard:** Yetkisiz bir switch'in root olmasını engeller.$md$, $md$Klasik STP port durumlarını sırayla sayabilmelisiniz: blocking, listening (15 sn), learning (15 sn), forwarding; max age 20 sn.$md$, $md$medium$md$, $md$network-engineer$md$, $md$yonlendirme-anahtarlama$md$),
  ($md$static-routing-ile-dynamic-routing-arasindaki-fark-nedir-hangi-durumda-hangisi-t$md$, $md$Static routing ile dynamic routing arasındaki fark nedir? Hangi durumda hangisi tercih edilir?$md$, $md$| Özellik | Static Routing | Dynamic Routing |
| --- | --- | --- |
| Yapılandırma | Elle, her rota tek tek | Protokol komşulardan öğrenir |
| Topoloji değişimi | Otomatik uyum yok | Otomatik yakınsama (convergence) |
| Kaynak kullanımı | CPU/bant genişliği harcamaz | Hello, update mesajları ve hesaplama |
| Ölçeklenebilirlik | Küçük ağlar | Büyük ve değişken ağlar |
| Güvenlik | Rota reklamı yok, öngörülebilir | Komşu kimlik doğrulaması gerekir |

### Static routing örneği

```text
ip route 10.20.0.0 255.255.0.0 192.168.1.2
ip route 0.0.0.0 0.0.0.0 203.0.113.1            ! default route
ip route 0.0.0.0 0.0.0.0 198.51.100.1 250       ! floating static (yedek)
```

**Floating static route**, AD değeri dinamik protokolden yüksek verilerek yalnızca ana rota kaybolduğunda devreye giren yedek rotadır.

### Dynamic routing protokolleri

- **IGP (kurum içi):** OSPF (link-state), EIGRP (Cisco, advanced distance-vector), IS-IS, RIP (eski, hop count tabanlı, max 15).
- **EGP (kurumlar arası):** BGP (path-vector, internetin omurgası).

### Tercih

- **Static:** Stub ağlar (tek çıkışlı şube), default route, küçük ortamlar, güvenlik açısından sabit kalması istenen rotalar.
- **Dynamic:** Birden fazla yolun olduğu, yedeklilik gereken ve sık değişen kurumsal ağlar.

Pratikte ikisi birlikte kullanılır: içeride OSPF, internete çıkışta static default route ve bu default'un OSPF'e `default-information originate` ile dağıtılması.$md$, null, $md$easy$md$, $md$network-engineer$md$, $md$yonlendirme-anahtarlama$md$),
  ($md$administrative-distance-nedir-router-ayni-hedefe-birden-fazla-kaynaktan-rota-ogr$md$, $md$Administrative Distance nedir? Router aynı hedefe birden fazla kaynaktan rota öğrenirse hangisini seçer?$md$, $md$**Administrative Distance (AD)**, bir rota kaynağının **güvenilirlik** derecesidir. Router aynı prefix'i farklı protokollerden öğrenirse **AD'si en düşük** olanı routing tablosuna koyar. AD, protokoller arası karşılaştırmadır; aynı protokol içinde ise **metric** belirleyicidir.

| Kaynak | Varsayılan AD (Cisco) |
| --- | --- |
| Connected | 0 |
| Static | 1 |
| EIGRP summary | 5 |
| eBGP | 20 |
| EIGRP (internal) | 90 |
| OSPF | 110 |
| IS-IS | 115 |
| RIP | 120 |
| EIGRP (external) | 170 |
| iBGP | 200 |
| Unknown / kullanılamaz | 255 |

### Seçim sırası

1. **Longest prefix match:** Önce en spesifik prefix seçilir. `10.1.1.0/24` ile `10.1.0.0/16` farklı prefix'lerdir; ikisi de tabloya girer.
2. Aynı prefix ve uzunluk için **en düşük AD**.
3. Aynı protokolde **en düşük metric** (OSPF cost, EIGRP composite, RIP hop).
4. Metric de eşitse **ECMP** ile yük paylaşımı.

### Örnek

`10.5.0.0/16` hem OSPF'ten hem EIGRP'den öğrenildi. Tabloya EIGRP (90) girer; OSPF rotası yedekte bekler.

```text
R1# show ip route 10.5.0.0
Routing entry for 10.5.0.0/16
  Known via "eigrp 100", distance 90, metric 30720
```

AD değiştirilebilir; floating static route bunun en yaygın kullanımıdır:

```text
ip route 10.5.0.0 255.255.0.0 192.168.9.1 200
```$md$, $md$AD ile metric'i karıştırmayın. Ayrıca longest prefix match'in AD'den önce geldiğini vurgulamak sık yapılan bir hatayı düzelttiğinizi gösterir.$md$, $md$medium$md$, $md$network-engineer$md$, $md$yonlendirme-anahtarlama$md$),
  ($md$vlan-lar-arasi-yonlendirme-inter-vlan-routing-nasil-yapilir-router-on-a-stick-il$md$, $md$VLAN'lar arası yönlendirme (inter-VLAN routing) nasıl yapılır? Router-on-a-stick ile Layer 3 switch arasındaki fark nedir?$md$, $md$Her VLAN ayrı bir broadcast domain ve genelde ayrı bir subnet'tir. VLAN'lar arası trafik için **Layer 3 cihaz** gerekir.

### 1. Router-on-a-stick

Router'ın tek fiziksel arayüzü switch'e **802.1Q trunk** ile bağlanır; her VLAN için bir **subinterface** açılır.

```text
! Router
interface Gi0/0
 no shutdown
interface Gi0/0.10
 encapsulation dot1Q 10
 ip address 192.168.10.1 255.255.255.0
interface Gi0/0.20
 encapsulation dot1Q 20
 ip address 192.168.20.1 255.255.255.0

! Switch
interface Gi1/0/24
 switchport mode trunk
 switchport trunk allowed vlan 10,20
```

### 2. Layer 3 switch (SVI)

Switch üzerinde her VLAN için sanal arayüz (**SVI**) oluşturulur; yönlendirme donanımda (ASIC) yapılır.

```text
ip routing
interface Vlan10
 ip address 192.168.10.1 255.255.255.0
 no shutdown
interface Vlan20
 ip address 192.168.20.1 255.255.255.0
 no shutdown
```

### Karşılaştırma

| Kriter | Router-on-a-stick | L3 switch (SVI) |
| --- | --- | --- |
| Performans | Tek link darboğaz, trafik iki kez geçer | Wire-speed, donanım tabanlı |
| Maliyet | Ucuz, mevcut router yeterli | L3 lisanslı switch gerekir |
| Ölçek | Küçük şubeler, lab | Kampüs ve datacenter |
| Ek özellik | WAN, NAT, firewall router'da | Genelde sınırlı WAN özelliği |

SVI'ın **up** olması için VLAN'ın var olması ve o VLAN'da en az bir aktif port (veya trunk) bulunması gerekir. Yaygın hata: native VLAN uyuşmazlığı ve trunk'ta VLAN'ın `allowed` listesinde olmaması.$md$, null, $md$medium$md$, $md$network-engineer$md$, $md$yonlendirme-anahtarlama$md$),
  ($md$link-aggregation-etherchannel-ve-lacp-nedir-trafik-linkler-arasinda-nasil-dagiti$md$, $md$Link aggregation (EtherChannel) ve LACP nedir? Trafik linkler arasında nasıl dağıtılır?$md$, $md$**Link aggregation**, birden fazla fiziksel linki tek bir mantıksal link (Cisco: **EtherChannel / Port-channel**) olarak birleştirir. Faydaları:

- Toplam bant genişliği artar.
- Bir link koparsa trafik diğerlerinde devam eder.
- STP tüm grubu tek port olarak görür; linkler bloklanmaz.

### Protokoller

| Mod | Protokol | Davranış |
| --- | --- | --- |
| `active` | LACP (802.3ad / 802.1AX) | Pazarlık başlatır |
| `passive` | LACP | Sadece cevap verir |
| `desirable` / `auto` | PAgP (Cisco) | Cisco'ya özel |
| `on` | Yok | Zorla açık; pazarlık yok, riskli |

`passive` + `passive` kanal **oluşturmaz**; en az bir taraf `active` olmalıdır. Standart olduğu için LACP tercih edilir.

```text
interface range Gi1/0/1 - 2
 channel-group 1 mode active
interface Port-channel1
 switchport mode trunk
```

```text
show etherchannel summary
```

### Yük dağıtımı

Dağıtım **paket bazlı değil, akış (flow) bazlıdır**. Bir hash fonksiyonu (src/dst MAC, IP, L4 port) her akışı tek bir linke atar; böylece paket sırası bozulmaz.

```text
port-channel load-balance src-dst-ip
```

Bu yüzden 2x1G kanal üzerinde **tek bir TCP akışı** en fazla 1G kullanır. Az sayıda büyük akış varsa (örn. iki sunucu arası yedekleme) dağılım dengesiz olabilir; L4 port içeren hash seçmek yardımcı olur.

### Kurallar

Gruptaki tüm portların **hız, duplex, VLAN ve trunk ayarları aynı** olmalıdır; aksi hâlde port `suspended` olur. Farklı fiziksel switch'lere dağıtmak için **StackWise, VSS veya vPC/MLAG** gerekir.$md$, $md$'4 linkli EtherChannel'da neden tek dosya transferi hızlanmıyor?' sorusunun cevabı hash tabanlı akış dağıtımıdır.$md$, $md$medium$md$, $md$network-engineer$md$, $md$yonlendirme-anahtarlama$md$),
  ($md$hsrp-ve-vrrp-gibi-first-hop-redundancy-protocol-ler-nasil-calisir-aralarindaki-f$md$, $md$HSRP ve VRRP gibi First Hop Redundancy Protocol'ler nasıl çalışır? Aralarındaki farklar nelerdir?$md$, $md$Hostlarda tek bir default gateway tanımlıdır. O router çökerse host başka bir yola geçemez. **FHRP**'ler birden fazla router'ı tek bir **sanal IP ve sanal MAC** arkasında birleştirir; hostlar gateway olarak sanal IP'yi kullanır.

### Çalışma prensibi

1. Router'lar grup içinde **priority** değerine göre active (master) ve standby (backup) seçer.
2. Active router sanal IP'ye gelen trafiği işler ve periyodik **hello** gönderir.
3. Hello'lar kesilirse (hold timer) standby, active olur ve **gratuitous ARP** ile switch'lerin MAC tablosunu günceller. Hostların ARP cache'i değişmez, çünkü sanal MAC aynı kalır.

### Karşılaştırma

| Özellik | HSRP | VRRP | GLBP |
| --- | --- | --- | --- |
| Standart | Cisco | Açık standart (RFC 5798) | Cisco |
| Roller | Active / Standby | Master / Backup | AVG / AVF |
| Sanal MAC | `0000.0c07.acXX` (v1) | `0000.5e00.01XX` | Birden fazla |
| Hello / hold | 3 sn / 10 sn | 1 sn / ~3 sn | 3 sn / 10 sn |
| Preempt varsayılan | Kapalı | Açık | Kapalı |
| Sanal IP = fiziksel IP | Hayır | Evet, olabilir | Hayır |
| Yük paylaşımı | Grup başına | Grup başına | Tek grupta aktif-aktif |

### HSRP örneği (interface tracking ile)

```text
track 1 interface Gi0/0 line-protocol
interface Vlan10
 ip address 192.168.10.2 255.255.255.0
 standby version 2
 standby 10 ip 192.168.10.1
 standby 10 priority 110
 standby 10 preempt
 standby 10 track 1 decrement 20
```

WAN linki (Gi0/0) düşerse priority 110 → 90 olur; preempt açık olan diğer router (100) active olur. Tracking olmadan router LAN tarafında ayakta kaldığı için active kalır ama trafiği kara deliğe gönderir.

### Yük paylaşımı

HSRP/VRRP'de iki grup açılır: VLAN 10'da R1 active, VLAN 20'de R2 active. Böylece iki router da çalışır.$md$, $md$Preempt ve tracking'i birlikte anlatın; 'tracking olmadan WAN kopunca ne olur' senaryosu en sık sorulan devamıdır.$md$, $md$hard$md$, $md$network-engineer$md$, $md$yonlendirme-anahtarlama$md$),
  ($md$router-routing-tablosunda-longest-prefix-match-ile-nasil-karar-verir-bir-paket-i$md$, $md$Router routing tablosunda longest prefix match ile nasıl karar verir? Bir paket için seçilecek rotayı adım adım açıklayın.$md$, $md$Router bir paketin hedef IP'sini routing tablosundaki tüm prefix'lerle karşılaştırır ve **eşleşen en uzun (en spesifik) prefix**'i seçer. Bu kural AD ve metric'ten **önce** uygulanır.

### Örnek tablo

```text
S*   0.0.0.0/0        via 203.0.113.1
O    10.0.0.0/8       via 192.168.1.2
D    10.1.0.0/16      via 192.168.1.3
S    10.1.1.0/24      via 192.168.1.4
C    10.1.1.128/25    is directly connected, Gi0/2
```

| Hedef IP | Eşleşen prefix'ler | Seçilen |
| --- | --- | --- |
| 10.1.1.200 | /0, /8, /16, /24, /25 | **/25**, connected |
| 10.1.1.50 | /0, /8, /16, /24 | **/24**, 192.168.1.4 |
| 10.1.5.9 | /0, /8, /16 | **/16**, 192.168.1.3 |
| 10.200.0.1 | /0, /8 | **/8**, 192.168.1.2 |
| 8.8.8.8 | /0 | **default route** |

/8 rotasının AD'si (110) /16'nın AD'sinden (90) yüksek olsa da bu önemli değildir; karar prefix uzunluğuyla verilir.

### Nasıl eşleşir?

Hedef IP ile prefix'in subnet mask'i **AND**'lenir; sonuç network adresine eşitse eşleşme vardır. `10.1.1.50 AND 255.255.255.128 = 10.1.1.0`, bu `10.1.1.128` olmadığı için /25 eşleşmez.

### Recursive lookup

Static rota bir next-hop IP gösteriyorsa, router o next-hop'a nasıl gideceğini de tabloda arar ve çıkış arayüzünü bulana kadar devam eder.

### Donanımda

Gerçek router ve L3 switch'ler bu aramayı yazılımda yapmaz: **CEF** gibi mekanizmalar FIB'yi (trie yapısı) ve adjacency tablosunu önceden hazırlar; ASIC'lerde **TCAM** tek saat döngüsünde en uzun eşleşmeyi bulur.

```text
show ip route 10.1.1.50
show ip cef 10.1.1.50
```

### Pratik kullanım

- Daha spesifik rota ile trafik mühendisliği (örn. /24'ü farklı ISS'ten çıkarmak).
- Bir prefix'i **Null0**'a yönlendirerek summary rotasında döngüyü engellemek.
- BGP hijack'lerinin mantığı da budur: daha spesifik prefix duyuran kazanır.$md$, null, $md$hard$md$, $md$network-engineer$md$, $md$yonlendirme-anahtarlama$md$),
  ($md$stateful-ve-stateless-firewall-arasindaki-fark-nedir$md$, $md$Stateful ve stateless firewall arasındaki fark nedir?$md$, $md$### Stateless (packet filter)

Her paketi **tek başına** kurallara göre değerlendirir: kaynak/hedef IP, port, protokol. Bağlantının geçmişini bilmez.

- Hızlı ve az kaynak kullanır.
- Dönüş trafiğine de ayrıca izin verilmesi gerekir; genelde "1024 üstü tüm portlar" gibi geniş kurallar açılır, bu da riskli olur.
- Örnek: Cisco standart/extended ACL, AWS **Network ACL**.

### Stateful

Bir **state (connection) table** tutar. İçeriden başlatılan bağlantı tabloya yazılır; dönüş paketleri bu kayıtla eşleştiği için otomatik geçer.

- TCP durumlarını (SYN, ESTABLISHED, FIN) takip eder; eşleşmeyen "ortadan gelen" paketleri düşürür.
- UDP/ICMP için zaman aşımlı sözde oturumlar tutar.
- Örnek: Cisco ASA, Fortinet, Palo Alto, Linux `iptables/nftables` conntrack, AWS **Security Group**.

| Özellik | Stateless | Stateful |
| --- | --- | --- |
| Bağlam | Paket paket | Oturum bazlı |
| Dönüş trafiği | Ayrı kural gerekir | Otomatik izinli |
| Performans | Çok yüksek | Tablo boyutu ve CPU sınırı |
| Saldırı tespiti | Zayıf | Sahte ACK, scan tespiti daha iyi |
| DDoS altında | Tablo yok, etkilenmez | State tablosu dolabilir |

```bash
# Linux stateful örnek
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -s 10.0.0.0/8 -j ACCEPT
iptables -P INPUT DROP
```

**NGFW (Next-Generation Firewall)** bunun üstüne uygulama tanıma (L7), kullanıcı kimliği, IPS ve TLS inspection ekler.$md$, $md$AWS örneği güçlü bir referanstır: Security Group stateful, Network ACL stateless. Bulut tecrübenizi de göstermiş olursunuz.$md$, $md$medium$md$, $md$network-engineer$md$, $md$ag-guvenligi$md$),
  ($md$cisco-da-standart-ve-extended-acl-arasindaki-fark-nedir-nereye-uygulanmalidir$md$, $md$Cisco'da standart ve extended ACL arasındaki fark nedir? Nereye uygulanmalıdır?$md$, $md$**ACL (Access Control List)** paketleri sıralı kurallara göre izin verir veya reddeder. Kurallar **yukarıdan aşağı** okunur, ilk eşleşen uygulanır ve sonda görünmeyen bir **implicit deny any** vardır.

| Özellik | Standart ACL | Extended ACL |
| --- | --- | --- |
| Numara aralığı | 1–99, 1300–1999 | 100–199, 2000–2699 |
| Eşleşme kriteri | Yalnızca **kaynak IP** | Kaynak/hedef IP, protokol, port |
| Yerleşim kuralı | **Hedefe yakın** | **Kaynağa yakın** |

Standart ACL yalnızca kaynağa baktığı için kaynağa yakın konursa o kaynağın her yere erişimini keser. Extended ACL ise istenmeyen trafiği ağda dolaşmadan erken düşürmek için kaynağa yakın konur.

### Standart ACL

```text
access-list 10 permit 192.168.10.0 0.0.0.255
access-list 10 deny any
!
line vty 0 4
 access-class 10 in          ! SSH erişimini sınırla
```

### Extended, named ACL

```text
ip access-list extended WEB-ONLY
 10 permit tcp 192.168.10.0 0.0.0.255 host 10.0.0.50 eq 443
 20 permit udp 192.168.10.0 0.0.0.255 any eq 53
 30 deny   ip 192.168.10.0 0.0.0.255 10.0.0.0 0.255.255.255 log
 40 permit ip any any
!
interface Gi0/1
 ip access-group WEB-ONLY in
```

### Önemli noktalar

- **Wildcard mask**, subnet mask'in tersidir: /24 için `0.0.0.255`. `host x.x.x.x` = `x.x.x.x 0.0.0.0`.
- Arayüz ve yön başına (in/out) protokol başına **tek ACL** uygulanabilir.
- Spesifik kurallar üste, genel kurallar alta yazılır.
- Named ACL'lerde sıra numarası ile araya kural eklenebilir veya tek satır silinebilir.
- Implicit deny, routing protokol trafiğini de keser; OSPF komşuluğu düşebilir.

```text
show access-lists
show ip interface Gi0/1
```$md$, $md$'ACL ekledim, OSPF komşuluğu düştü' senaryosu implicit deny'ı bilip bilmediğinizi ölçer.$md$, $md$medium$md$, $md$network-engineer$md$, $md$ag-guvenligi$md$),
  ($md$ipsec-vpn-ile-ssl-vpn-arasindaki-farklar-nelerdir-ipsec-tunel-kurulumu-hangi-asa$md$, $md$IPsec VPN ile SSL VPN arasındaki farklar nelerdir? IPsec tünel kurulumu hangi aşamalardan oluşur?$md$, $md$### Karşılaştırma

| Özellik | IPsec VPN | SSL/TLS VPN |
| --- | --- | --- |
| Katman | Layer 3 (IP) | Layer 4-7 (TLS) |
| Tipik kullanım | **Site-to-site**, sabit cihazlar | **Remote access**, mobil kullanıcı |
| İstemci | Router/firewall veya özel istemci | Tarayıcı veya hafif istemci (AnyConnect, GlobalProtect) |
| Portlar | UDP 500 (IKE), UDP 4500 (NAT-T), ESP (IP 50) | TCP 443 (veya DTLS UDP 443) |
| NAT / firewall geçişi | NAT-T gerekir, bazen engellenir | Neredeyse her yerden geçer |
| Erişim kontrolü | Genelde tüm subnet | Uygulama bazlı ince ayar kolay |

### IPsec bileşenleri

- **IKE (Internet Key Exchange):** Anahtar müzakeresi. Bugün **IKEv2** tercih edilir.
- **ESP (Encapsulating Security Payload):** Şifreleme + bütünlük. Yaygın kullanılan budur.
- **AH (Authentication Header):** Yalnızca bütünlük, şifreleme yok; IP header'ını da koruduğu için NAT ile çalışmaz.
- **Tunnel mode:** Tüm orijinal IP paketi şifrelenir, yeni IP header eklenir (site-to-site).
- **Transport mode:** Yalnızca payload şifrelenir (host-to-host, GRE over IPsec).

### Kurulum aşamaları

1. **IKE Phase 1:** İki uç kimlik doğrulaması yapar (PSK veya sertifika), Diffie-Hellman ile ortak anahtar üretir ve yönetim için güvenli bir kanal (**IKE SA**) kurar. Parametreler: şifreleme, hash, DH grubu, lifetime.
2. **IKE Phase 2:** Bu güvenli kanal üzerinden veri trafiği için **IPsec SA**'lar müzakere edilir (her yön için bir SA). Hangi trafiğin şifreleneceği **proxy ID / interesting traffic** ile tanımlanır.
3. **Veri aktarımı:** ESP ile şifreli trafik akar; lifetime dolunca rekey yapılır.

### Sık görülen sorunlar

- Phase 1 düşüyor: PSK, şifreleme/DH grubu uyuşmazlığı, UDP 500/4500 engeli.
- Phase 1 kalkıyor ama trafik yok: Phase 2 proxy ID'leri iki uçta birbirinin aynası değil veya NAT exemption eksik.
- Büyük paketler takılıyor: ESP overhead nedeniyle MTU/MSS ayarı.

```text
show crypto ikev2 sa
show crypto ipsec sa
```$md$, $md$Troubleshooting'i 'Phase 1 mi Phase 2 mi?' diye ayırarak anlatmak, sahada VPN debug etmiş biri olduğunuzu gösterir.$md$, $md$hard$md$, $md$network-engineer$md$, $md$ag-guvenligi$md$),
  ($md$ddos-saldiri-turleri-nelerdir-ve-nasil-onlem-alinir$md$, $md$DDoS saldırı türleri nelerdir ve nasıl önlem alınır?$md$, $md$**DDoS**, çok sayıda kaynaktan (genelde botnet) hedefin kaynaklarını tüketerek hizmeti erişilemez kılmaktır. Üç ana sınıf vardır:

| Tür | Hedef | Örnekler | Ölçü birimi |
| --- | --- | --- | --- |
| **Volumetric** | Bant genişliği | UDP flood, DNS/NTP/memcached **amplification** | Gbps |
| **Protocol** | Ağ cihazı ve state tabloları | SYN flood, ACK flood, fragment saldırıları, Ping of Death | pps |
| **Application (L7)** | Uygulama ve sunucu | HTTP GET/POST flood, Slowloris, pahalı arama sorguları | rps |

### Amplification nasıl çalışır?

Saldırgan kaynak IP'yi **kurbanın IP'si olarak sahteler** (spoofing) ve açık bir DNS/NTP sunucusuna küçük bir istek gönderir. Sunucu çok daha büyük yanıtı kurbana yollar. Memcached'te büyütme oranı 50.000 katına ulaşabilir.

### SYN flood

Saldırgan çok sayıda SYN gönderir, ACK'i hiç tamamlamaz. Sunucunun yarı açık bağlantı kuyruğu dolar. Önlem: **SYN cookies**, firewall'da SYN proxy, backlog ve timeout ayarı.

### Önlemler

- **Upstream / bulut scrubbing:** Cloudflare, Akamai, AWS Shield, ISS'in DDoS hizmeti. Volumetric saldırı kendi linkinizi doldurursa yerinde yapılacak bir şey yoktur.
- **Anycast:** Saldırı trafiğini birçok POP'a dağıtır.
- **RTBH (Remote Triggered Black Hole):** BGP ile hedef IP'ye gelen trafiği ISS'te düşürmek (hedef feda edilir, geri kalan ağ korunur).
- **BCP38 / uRPF:** Kendi ağınızdan sahte kaynak IP'li paket çıkmasını engellemek.
- **Rate limiting ve CoPP:** Router control plane'ini korumak.
- **WAF, CAPTCHA, bot yönetimi:** L7 saldırıları için.
- Açık resolver, NTP `monlist`, açık memcached gibi amplification kaynağı olacak servisleri kapatmak.
- **Akış izleme:** NetFlow/sFlow ile baseline çıkarıp anomaliyi erken görmek.$md$, null, $md$medium$md$, $md$network-engineer$md$, $md$ag-guvenligi$md$),
  ($md$ids-ile-ips-arasindaki-fark-nedir$md$, $md$IDS ile IPS arasındaki fark nedir?$md$, $md$| Özellik | IDS (Intrusion Detection System) | IPS (Intrusion Prevention System) |
| --- | --- | --- |
| Görev | Tespit eder ve **alarm** üretir | Tespit eder ve **engeller** |
| Yerleşim | **Out-of-band**: SPAN/mirror port veya TAP ile kopya trafik | **Inline**: trafik cihazın içinden geçer |
| Gecikme | Etkisi yok | Ek gecikme olur |
| Cihaz arızası | Trafik etkilenmez | Fail-open / fail-closed seçimi gerekir |
| False positive etkisi | Gereksiz alarm | **Meşru trafik kesilir** |

### Tespit yöntemleri

- **Signature-based:** Bilinen saldırı imzaları (ör. Snort/Suricata kuralları). Hızlı ve az false positive, ama sıfır gün saldırılarını yakalayamaz.
- **Anomaly-based:** Normal davranışın baseline'ı çıkarılır; sapmalar işaretlenir. Bilinmeyen saldırıları yakalayabilir ama false positive oranı yüksektir.
- **Policy/stateful protocol analysis:** Protokolün RFC'ye uygun kullanılıp kullanılmadığı.

### Yerleşim türleri

- **NIDS/NIPS:** Ağ seviyesinde, segment trafiğini izler.
- **HIDS/HIPS:** Host üzerinde ajan (OSSEC, Wazuh); log ve dosya bütünlüğünü izler.

Örnek Snort/Suricata kuralı:

```text
alert tcp any any -> $HOME_NET 22 (msg:"SSH brute force"; flags:S; threshold:type both, track by_src, count 10, seconds 60; sid:1000001;)
```

Günümüzde IPS genelde ayrı bir cihaz değil, **NGFW'nin bir modülü** olarak çalışır. Şifreli trafikte etkili olabilmesi için TLS inspection gerekir.$md$, null, $md$easy$md$, $md$network-engineer$md$, $md$ag-guvenligi$md$),
  ($md$802-1x-ve-port-security-nedir-switch-portlarina-yetkisiz-cihaz-baglanmasi-nasil$md$, $md$802.1X ve port security nedir? Switch portlarına yetkisiz cihaz bağlanması nasıl engellenir?$md$, $md$### Port security (Cisco)

Bir porta bağlanabilecek **MAC adreslerini** sınırlar. Basit ama MAC adresi kolayca sahtelenebilir.

```text
interface Gi1/0/5
 switchport mode access
 switchport port-security
 switchport port-security maximum 2
 switchport port-security mac-address sticky
 switchport port-security violation restrict
```

| Violation modu | Davranış |
| --- | --- |
| `protect` | Yetkisiz çerçeveleri sessizce düşürür |
| `restrict` | Düşürür, log ve sayaç artırır |
| `shutdown` (varsayılan) | Portu err-disable yapar |

### 802.1X (port-based network access control)

Cihaz, porta bağlandığında kimliğini kanıtlayana kadar yalnızca kimlik doğrulama trafiği (EAPOL) geçebilir.

| Rol | Kim? |
| --- | --- |
| **Supplicant** | İstemci (laptop, telefon) |
| **Authenticator** | Switch veya kablosuz AP |
| **Authentication server** | RADIUS (Cisco ISE, FreeRADIUS, Microsoft NPS) |

Akış: Supplicant EAP ile kimlik bilgisini gönderir; switch bunu RADIUS'a iletir (EAPOL ↔ RADIUS); RADIUS Access-Accept dönerse port açılır. RADIUS ayrıca **dinamik VLAN** veya **downloadable ACL** atayabilir.

Yaygın EAP yöntemleri: **EAP-TLS** (iki tarafta sertifika, en güvenli), **PEAP-MSCHAPv2** (kullanıcı adı/parola).

```text
aaa new-model
aaa authentication dot1x default group radius
dot1x system-auth-control
radius server ISE
 address ipv4 10.0.0.20 auth-port 1812 acct-port 1813
 key S3cr3t
interface Gi1/0/5
 switchport mode access
 authentication port-control auto
 dot1x pae authenticator
 mab
```

Yazıcı, IP kamera gibi 802.1X desteklemeyen cihazlar için **MAB (MAC Authentication Bypass)** fallback olarak kullanılır.

### Tamamlayıcı L2 güvenlik önlemleri

- Kullanılmayan portları kapatıp boş bir VLAN'a almak.
- **DHCP snooping**, **Dynamic ARP Inspection**, **IP Source Guard**.
- Access portlarda DTP'yi kapatmak (`switchport nonegotiate`) ve native VLAN'ı kullanılmayan bir VLAN yapmak (VLAN hopping önlemi).
- **BPDU Guard** ile kullanıcıların switch bağlamasını engellemek.$md$, $md$802.1X'in üç rolünü ve RADIUS portlarını (1812/1813) söyleyebilmek, kurumsal NAC projelerinde çalıştığınızın kanıtı sayılır.$md$, $md$hard$md$, $md$network-engineer$md$, $md$ag-guvenligi$md$),
  ($md$dmz-nedir-ve-tipik-bir-dmz-mimarisi-nasil-tasarlanir$md$, $md$DMZ nedir ve tipik bir DMZ mimarisi nasıl tasarlanır?$md$, $md$**DMZ (Demilitarized Zone)**, internetten erişilmesi gereken sunucuların (web, mail relay, DNS, reverse proxy, VPN gateway) iç ağdan **ayrı bir güvenlik bölgesinde** tutulmasıdır. Amaç: dışa açık bir sunucu ele geçirilirse saldırganın iç ağa doğrudan ulaşamaması.

### Mimari seçenekleri

- **Tek firewall, üç bacak (three-legged):** Firewall'un outside, inside ve DMZ arayüzleri vardır. Ucuz ve yaygındır; tek cihaz kritik nokta olur.
- **Çift firewall (back-to-back):** Dış firewall internet ile DMZ arasında, iç firewall DMZ ile LAN arasında. Farklı üreticiler seçilirse tek bir zafiyet iki katmanı birden aşamaz.

### Tipik trafik politikası

| Kaynak → Hedef | Kural |
| --- | --- |
| Internet → DMZ | Yalnızca gerekli servisler (TCP 443, 25) |
| Internet → LAN | **Tamamen yasak** |
| DMZ → LAN | Varsayılan yasak; sadece zorunlu, spesifik akışlar (ör. app sunucusu → DB 5432) |
| LAN → DMZ | Yönetim ve gerekli erişimler (SSH yalnızca yönetim ağından) |
| DMZ → Internet | Kısıtlı; güncelleme depoları gibi |

### İyi pratikler

- DMZ sunucularını **hardening** ile küçültmek, gereksiz servisleri kapatmak.
- Veritabanını DMZ'de değil, iç ağda veya ayrı bir data zone'da tutmak.
- Mümkünse **reverse proxy / WAF** önde, uygulama sunucusu arkada olacak şekilde katmanlamak.
- DMZ'deki sunucuları birbirinden de izole etmek (**private VLAN** veya mikro-segmentasyon).
- DMZ içi tüm trafiği loglamak ve IDS/IPS ile izlemek.
- Static NAT veya port forwarding'i yalnızca DMZ adreslerine yapmak.

Bulutta DMZ karşılığı: **public subnet** (load balancer, bastion) ve **private subnet** (uygulama, veritabanı) ayrımı, Security Group'lar ile katman bazlı erişim.$md$, null, $md$medium$md$, $md$network-engineer$md$, $md$ag-guvenligi$md$),
  ($md$temel-veri-yapilarinda-yaygin-islemlerin-big-o-karmasikliklari-nelerdir$md$, $md$Temel veri yapılarında yaygın işlemlerin Big-O karmaşıklıkları nelerdir?$md$, $md$**Big-O**, girdi büyüdükçe çalışma süresinin veya bellek kullanımının en kötü durumda nasıl büyüdüğünü ifade eder. Sabitler ve küçük terimler atılır: `3n + 5` -> `O(n)`.

| Yapı | Erişim | Arama | Ekleme | Silme |
| --- | --- | --- | --- | --- |
| Dizi (array) | O(1) | O(n) | Sona O(1) amortize, araya O(n) | O(n) |
| Bağlı liste | O(n) | O(n) | Başa O(1) | Düğüm biliniyorsa O(1) |
| Hash table | - | O(1) ort., O(n) en kötü | O(1) ort. | O(1) ort. |
| Dengeli BST | O(log n) | O(log n) | O(log n) | O(log n) |
| Binary heap | Min/max O(1) | O(n) | O(log n) | Kök O(log n) |
| Stack / Queue | Uç O(1) | O(n) | O(1) | O(1) |

### Büyüme sırası

`O(1) < O(log n) < O(n) < O(n log n) < O(n²) < O(2ⁿ) < O(n!)`

- Karşılaştırmaya dayalı sıralama en iyi `O(n log n)` olabilir.
- İç içe iki döngü genelde `O(n²)`.
- Her adımda problemi yarıya indirmek `O(log n)`.

```python
def has_duplicate(nums):          # O(n) zaman, O(n) bellek
    seen = set()
    for x in nums:
        if x in seen:             # set araması ortalama O(1)
            return True
        seen.add(x)
    return False
```

Aynı problem iç içe döngüyle `O(n²)` zaman ama `O(1)` bellekle çözülür; mülakatta bu **zaman-bellek takasını** açıkça söylemek beklenir.$md$, $md$Kodu yazdıktan sonra sorulmadan zaman ve bellek karmaşıklığını söyleyin; mülakatçıların en sık beklediği alışkanlıktır.$md$, $md$easy$md$, $md$yazilim-muhendisi$md$, $md$algoritmalar$md$),
  ($md$hash-table-nasil-calisir-cakismalar-collision-nasil-cozulur$md$, $md$Hash table nasıl çalışır? Çakışmalar (collision) nasıl çözülür?$md$, $md$Hash table, anahtarı bir **hash fonksiyonu** ile sayıya çevirip dizide bir indekse (`hash(key) % kapasite`) eşler. Bu sayede ortalama `O(1)` ekleme, arama ve silme sağlar.

**Çakışma**, iki farklı anahtarın aynı indekse düşmesidir. Kapasite sınırlı olduğu için kaçınılmazdır.

### 1. Separate chaining (zincirleme)

Her kova (bucket) bir liste tutar; aynı indekse düşenler listeye eklenir.

```python
class HashMap:
    def __init__(self, cap=8):
        self.buckets = [[] for _ in range(cap)]

    def put(self, key, val):
        b = self.buckets[hash(key) % len(self.buckets)]
        for i, (k, _) in enumerate(b):
            if k == key:
                b[i] = (key, val); return
        b.append((key, val))

    def get(self, key):
        b = self.buckets[hash(key) % len(self.buckets)]
        for k, v in b:
            if k == key: return v
        raise KeyError(key)
```

Java'nın `HashMap`'i bir kovada eleman sayısı çok artınca listeyi dengeli ağaca çevirir.

### 2. Open addressing (açık adresleme)

Tüm elemanlar dizide durur; dolu indekse denk gelinirse başka bir boş yer aranır:

- **Linear probing:** `i+1, i+2, ...` (önbellek dostu ama kümelenme olur)
- **Quadratic probing**, **double hashing**

Silmede "tombstone" işareti gerekir, yoksa arama zinciri kopar. Python `dict` açık adresleme kullanır.

### Load factor ve yeniden boyutlandırma

`load factor = eleman sayısı / kapasite`. Eşik aşılınca (ör. 0.75) kapasite genelde iki katına çıkarılır ve tüm elemanlar yeniden hash'lenir: tek seferde `O(n)`, ama **amortize** `O(1)`.

En kötü durumda (her şey aynı kovaya düşerse) işlemler `O(n)` olur; iyi hash fonksiyonu anahtarları düzgün dağıtmalıdır.$md$, null, $md$hard$md$, $md$yazilim-muhendisi$md$, $md$algoritmalar$md$),
  ($md$quick-sort-merge-sort-ve-heap-sort-u-karsilastirin$md$, $md$Quick sort, merge sort ve heap sort'u karşılaştırın.$md$, $md$| | Quick sort | Merge sort | Heap sort |
| --- | --- | --- | --- |
| Ortalama | O(n log n) | O(n log n) | O(n log n) |
| En kötü | O(n²) | O(n log n) | O(n log n) |
| Ek bellek | O(log n) yığın | O(n) | O(1) |
| Kararlı (stable) | Hayır | Evet | Hayır |
| Pratik hız | Genelde en hızlı (önbellek dostu) | İyi, bağlı listede ideal | Sabitleri yüksek |

- **Quick sort:** bir pivot seçer, küçükleri sola büyükleri sağa ayırır (partition), iki tarafı özyinelemeli sıralar. Kötü pivot seçimi (sıralı dizide hep ilk eleman) `O(n²)`'ye yol açar; rastgele veya median-of-three pivot ile önlenir.
- **Merge sort:** diziyi ikiye böler, her yarıyı sıralar, sıralı iki yarıyı birleştirir. Garantili `O(n log n)` ve kararlıdır; harici sıralamada (diske sığmayan veri) kullanılır.
- **Heap sort:** diziden max-heap kurar, kökü sona alıp heap'i küçültür. Yerinde ve garantili ama pratikte yavaştır.

```python
def merge_sort(a):
    if len(a) <= 1:
        return a
    mid = len(a) // 2
    left, right = merge_sort(a[:mid]), merge_sort(a[mid:])
    out, i, j = [], 0, 0
    while i < len(left) and j < len(right):
        if left[i] <= right[j]:      # <= kararlılığı korur
            out.append(left[i]); i += 1
        else:
            out.append(right[j]); j += 1
    return out + left[i:] + right[j:]
```

**Kararlılık**, eşit anahtarlı elemanların orijinal sırasını korumasıdır; örneğin önce isme sonra yaşa göre sıralarken önemlidir. Python'un `sorted` ve Java'nın nesne sıralaması **Timsort** (merge + insertion hibriti) kullanır.$md$, null, $md$medium$md$, $md$yazilim-muhendisi$md$, $md$algoritmalar$md$),
  ($md$dinamik-programlama-nedir-merdiven-cikma-problemi-uzerinden-aciklayin$md$, $md$Dinamik programlama nedir? Merdiven çıkma problemi üzerinden açıklayın.$md$, $md$**Dinamik programlama (DP)**, bir problemi **örtüşen alt problemlere** bölüp her alt problemi bir kez çözerek sonucunu saklama tekniğidir. İki şart aranır:

- **Örtüşen alt problemler:** aynı hesaplama tekrar tekrar yapılıyor.
- **Optimal alt yapı:** büyük problemin cevabı küçüklerin cevaplarından kurulabiliyor.

### Problem

`n` basamaklı merdivende her seferinde 1 veya 2 basamak çıkabiliyorsunuz. Kaç farklı yolla tepeye ulaşırsınız?

Son adım ya 1 ya 2 basamaktır, dolayısıyla: `f(n) = f(n-1) + f(n-2)`, `f(1)=1`, `f(2)=2`. (Fibonacci ile aynı yapı.)

```python
# Naif özyineleme: O(2^n), aynı değerler defalarca hesaplanır
def climb(n):
    if n <= 2: return n
    return climb(n - 1) + climb(n - 2)

# 1) Top-down: memoization -> O(n) zaman, O(n) bellek
from functools import lru_cache
@lru_cache(maxsize=None)
def climb_memo(n):
    if n <= 2: return n
    return climb_memo(n - 1) + climb_memo(n - 2)

# 2) Bottom-up: tabulation, yalnızca son iki değer -> O(n) zaman, O(1) bellek
def climb_dp(n):
    if n <= 2: return n
    a, b = 1, 2
    for _ in range(3, n + 1):
        a, b = b, a + b
    return b
```

### DP çözme adımları

1. **Durumu** tanımla: `dp[i]` neyi ifade ediyor?
2. **Geçiş** formülünü yaz.
3. **Taban durumlarını** belirle.
4. Hesaplama sırasını seç (top-down veya bottom-up), sonra belleği optimize et.

Klasik DP problemleri: bozuk para üstü (coin change), en uzun ortak alt dizi (LCS), 0/1 knapsack, edit distance.$md$, $md$Önce naif özyinelemeyi söyleyip neden yavaş olduğunu gösterin, sonra memoization ve O(1) bellekli versiyona geçin; bu ilerleme mülakatçının görmek istediği düşünce sürecidir.$md$, $md$medium$md$, $md$yazilim-muhendisi$md$, $md$algoritmalar$md$),
  ($md$sliding-window-teknigi-nedir-tekrarsiz-en-uzun-alt-dizeyi-bulun$md$, $md$Sliding window tekniği nedir? Tekrarsız en uzun alt dizeyi bulun.$md$, $md$**Sliding window**, bir dizi veya string üzerinde ardışık bir aralığı (pencere) iki indeksle temsil edip, her adımda pencereyi baştan hesaplamak yerine **bir uçtan ekleyip diğer uçtan çıkararak** güncelleme tekniğidir. İç içe döngülü `O(n²)` çözümleri genelde `O(n)`'e indirir.

İki türü vardır:

- **Sabit boyutlu:** "k uzunluklu alt dizilerin maksimum toplamı"
- **Değişken boyutlu:** koşul bozulunca sol uç daraltılır.

### Problem: tekrarlanan karakter içermeyen en uzun alt dize

`"abcabcbb"` -> `"abc"`, cevap 3.

```python
def length_of_longest_substring(s: str) -> int:
    last_seen = {}       # karakter -> son görüldüğü indeks
    left = 0
    best = 0
    for right, ch in enumerate(s):
        # karakter pencere içinde tekrar ettiyse sol ucu atlat
        if ch in last_seen and last_seen[ch] >= left:
            left = last_seen[ch] + 1
        last_seen[ch] = right
        best = max(best, right - left + 1)
    return best
```

- **Zaman:** `O(n)`, her karakter bir kez işlenir.
- **Bellek:** `O(min(n, alfabe))`.

### Sabit pencere örneği

```python
def max_sum_k(nums, k):
    window = sum(nums[:k])
    best = window
    for i in range(k, len(nums)):
        window += nums[i] - nums[i - k]   # gireni ekle, çıkanı çıkar
        best = max(best, window)
    return best
```

İpucu kelimeler: "ardışık alt dizi/alt dize", "en uzun/en kısa", "en fazla k farklı eleman".$md$, null, $md$medium$md$, $md$yazilim-muhendisi$md$, $md$algoritmalar$md$),
  ($md$two-pointers-teknigi-nedir-sirali-bir-dizideki-tekrarlari-yerinde-nasil-silersin$md$, $md$Two pointers tekniği nedir? Sıralı bir dizideki tekrarları yerinde nasıl silersiniz?$md$, $md$**Two pointers**, dizi üzerinde iki indeksin belirli bir kurala göre hareket ettirilmesidir. Ek bellek kullanmadan `O(n)` çözümler sağlar. İki yaygın biçimi vardır:

- **Zıt uçlardan:** biri baştan, biri sondan içe doğru (palindrom kontrolü, sıralı dizide hedef toplam).
- **Aynı yönde, farklı hızda:** biri okur, biri yazar (tekrar silme, sıfırları sona taşıma).

### Problem: sıralı dizide tekrarları yerinde silme

`[1,1,2,3,3]` -> ilk 3 eleman `[1,2,3]`, dönüş değeri 3.

```python
def remove_duplicates(nums):
    if not nums:
        return 0
    write = 1                     # bir sonraki benzersiz elemanın yazılacağı yer
    for read in range(1, len(nums)):
        if nums[read] != nums[write - 1]:
            nums[write] = nums[read]
            write += 1
    return write
```

Zaman `O(n)`, bellek `O(1)`.

### Zıt uç örneği: palindrom

```python
def is_palindrome(s):
    i, j = 0, len(s) - 1
    while i < j:
        if s[i] != s[j]:
            return False
        i += 1; j -= 1
    return True
```

Dizi **sıralı** ise iki işaretçi tekniği çoğu zaman hash map'e gerek bırakmaz; örneğin sıralı dizide toplamı hedefe eşit çift ararken toplam küçükse sol, büyükse sağ işaretçi hareket ettirilir.$md$, null, $md$easy$md$, $md$yazilim-muhendisi$md$, $md$algoritmalar$md$),
  ($md$binary-tree-de-preorder-inorder-postorder-ve-level-order-gezinme-nedir$md$, $md$Binary tree'de preorder, inorder, postorder ve level-order gezinme nedir?$md$, $md$| Gezinme | Sıra | Tipik kullanım |
| --- | --- | --- |
| Preorder | Kök, sol, sağ | Ağacı kopyalama, serileştirme |
| Inorder | Sol, kök, sağ | BST'de elemanları **sıralı** verir |
| Postorder | Sol, sağ, kök | Silme, alt ağaç boyutu/yüksekliği hesaplama |
| Level-order | Seviye seviye (BFS) | En kısa derinlik, seviye bazlı işlemler |

```python
class Node:
    def __init__(self, val, left=None, right=None):
        self.val, self.left, self.right = val, left, right

def inorder(root, out):
    if root:
        inorder(root.left, out)
        out.append(root.val)
        inorder(root.right, out)
    return out

# Özyinelemesiz inorder (stack ile)
def inorder_iter(root):
    out, stack, cur = [], [], root
    while cur or stack:
        while cur:
            stack.append(cur)
            cur = cur.left
        cur = stack.pop()
        out.append(cur.val)
        cur = cur.right
    return out

from collections import deque
def level_order(root):
    if not root: return []
    res, q = [], deque([root])
    while q:
        level = []
        for _ in range(len(q)):
            node = q.popleft()
            level.append(node.val)
            if node.left: q.append(node.left)
            if node.right: q.append(node.right)
        res.append(level)
    return res
```

- **Zaman:** hepsi `O(n)`.
- **Bellek:** DFS türlerinde `O(h)` (h = yükseklik; dengesiz ağaçta `O(n)`), level-order'da en geniş seviye kadar `O(w)`.

Örneğin `2` kökü, `1` sol ve `3` sağ çocuğu olan ağaçta: preorder `2,1,3`, inorder `1,2,3`, postorder `1,3,2`.$md$, null, $md$medium$md$, $md$yazilim-muhendisi$md$, $md$algoritmalar$md$),
  ($md$bir-dizideki-en-buyuk-k-elemani-top-k-heap-ile-nasil-bulursunuz$md$, $md$Bir dizideki en büyük k elemanı (top-k) heap ile nasıl bulursunuz?$md$, $md$**Heap (priority queue)**, en küçük (min-heap) veya en büyük (max-heap) elemana `O(1)` erişim, ekleme ve kök çıkarmada `O(log n)` sağlayan, dizi üzerinde tutulan tam ikili ağaçtır.

### Fikir

En büyük k elemanı bulmak için boyutu **k** olan bir **min-heap** tutulur. Heap'in kökü, şimdiye kadarki en büyük k elemanın en küçüğüdür. Yeni eleman kökten büyükse kök atılır, yeni eleman eklenir.

```python
import heapq

def top_k(nums, k):
    heap = []
    for x in nums:
        if len(heap) < k:
            heapq.heappush(heap, x)
        elif x > heap[0]:
            heapq.heapreplace(heap, x)   # pop + push tek adımda
    return sorted(heap, reverse=True)

top_k([5, 1, 9, 3, 7, 8], 3)  # [9, 8, 7]
```

- **Zaman:** `O(n log k)`
- **Bellek:** `O(k)`

### Alternatifler

| Yöntem | Zaman | Not |
| --- | --- | --- |
| Tümünü sırala | O(n log n) | En basit |
| Boyutu k min-heap | O(n log k) | Akan (stream) veride ideal |
| Tümünden heap kur, k kez pop | O(n + k log n) | heapify O(n) |
| Quickselect | Ortalama O(n) | Yerinde, en kötü O(n²) |

Python'da kısa yol `heapq.nlargest(k, nums)`. "En sık geçen k eleman" varyasyonunda önce `Counter` ile frekanslar sayılır, sonra frekansa göre aynı teknik uygulanır.

Veri akış hâlinde geliyorsa ve tamamı belleğe sığmıyorsa boyutu k heap yaklaşımı tek uygun seçenektir.$md$, $md$Neden max-heap değil de min-heap kullandığınızı açıklamanız beklenir; bu soru tam olarak bu sezgiyi ölçer.$md$, $md$medium$md$, $md$yazilim-muhendisi$md$, $md$algoritmalar$md$),
  ($md$dijkstra-algoritmasi-nasil-calisir-agirlikli-grafikte-en-kisa-yolu-bulun$md$, $md$Dijkstra algoritması nasıl çalışır? Ağırlıklı grafikte en kısa yolu bulun.$md$, $md$**Dijkstra**, **negatif olmayan** ağırlıklı bir grafikte bir kaynaktan tüm düğümlere en kısa mesafeyi bulur. Açgözlü (greedy) bir algoritmadır: her adımda kesinleşmemiş düğümler arasında mesafesi en küçük olanı seçer ve komşularını **gevşetir** (relax).

### Adımlar

1. Kaynağın mesafesi 0, diğerleri sonsuz.
2. Min-heap'e `(0, kaynak)` eklenir.
3. Heap'ten en küçük mesafeli düğüm çıkarılır; eski (güncel olmayan) kayıtsa atlanır.
4. Her komşu için `dist[u] + w < dist[v]` ise `dist[v]` güncellenir ve heap'e eklenir.
5. Heap boşalana kadar devam edilir.

```python
import heapq

def dijkstra(graph, src):
    # graph: {düğüm: [(komşu, ağırlık), ...]}
    dist = {node: float("inf") for node in graph}
    dist[src] = 0
    pq = [(0, src)]
    while pq:
        d, u = heapq.heappop(pq)
        if d > dist[u]:
            continue                 # eski kayıt
        for v, w in graph[u]:
            nd = d + w
            if nd < dist[v]:
                dist[v] = nd
                heapq.heappush(pq, (nd, v))
    return dist

g = {"A": [("B", 4), ("C", 1)], "C": [("B", 2), ("D", 5)],
     "B": [("D", 1)], "D": []}
dijkstra(g, "A")  # {'A': 0, 'B': 3, 'C': 1, 'D': 4}
```

Yolun kendisi isteniyorsa her düğüm için `prev[v] = u` tutulur ve hedeften geriye gidilir.

### Karmaşıklık

- Binary heap ile **`O((V + E) log V)`**, bellek `O(V + E)`.

### Ne zaman başka algoritma?

| Durum | Algoritma |
| --- | --- |
| Ağırlıksız grafik | BFS, O(V + E) |
| Negatif ağırlık var | Bellman-Ford, O(V·E) |
| Tüm çiftler arası | Floyd-Warshall, O(V³) |
| Hedef belli, iyi bir sezgisel var | A* |

Negatif kenarda Dijkstra yanlış sonuç verir, çünkü kesinleşmiş bir düğüme sonradan daha kısa yol bulunabilir.$md$, null, $md$hard$md$, $md$yazilim-muhendisi$md$, $md$algoritmalar$md$),
  ($md$bagli-listede-dongu-cycle-olup-olmadigini-nasil-tespit-edersiniz$md$, $md$Bağlı listede döngü (cycle) olup olmadığını nasıl tespit edersiniz?$md$, $md$### 1. Hash set ile

Ziyaret edilen düğümler bir kümeye eklenir; aynı düğüme tekrar gelinirse döngü vardır. Zaman `O(n)`, bellek `O(n)`.

### 2. Floyd'un tavşan ve kaplumbağa algoritması

İki işaretçi kullanılır: `slow` her adımda 1, `fast` 2 düğüm ilerler. Döngü yoksa `fast` listenin sonuna (`None`) ulaşır. Döngü varsa `fast` döngü içinde `slow`'a her adımda 1 düğüm yaklaşır ve **mutlaka yakalar**.

```python
class ListNode:
    def __init__(self, val, next=None):
        self.val, self.next = val, next

def has_cycle(head):
    slow = fast = head
    while fast and fast.next:
        slow = slow.next
        fast = fast.next.next
        if slow is fast:
            return True
    return False
```

Zaman `O(n)`, bellek **`O(1)`**.

### Takip sorusu: döngünün başlangıç düğümü

Buluşmadan sonra işaretçilerden biri `head`'e alınır; ikisi de birer adım ilerletilir. Tekrar buluştukları düğüm döngünün başlangıcıdır.

```python
def cycle_start(head):
    slow = fast = head
    while fast and fast.next:
        slow, fast = slow.next, fast.next.next
        if slow is fast:
            slow = head
            while slow is not fast:
                slow, fast = slow.next, fast.next
            return slow
    return None
```

Neden: başlangıca uzaklık `a`, döngü uzunluğu `c` ise buluşma noktasından döngü başına uzaklık da `a` mod `c` olur.

Aynı teknik "listenin ortasını bul" ve "dizide tekrar eden sayıyı bul" (LeetCode 287) sorularında da kullanılır.$md$, null, $md$medium$md$, $md$yazilim-muhendisi$md$, $md$algoritmalar$md$),
  ($md$ozyineleme-recursion-ile-iterasyon-arasindaki-farklar-nelerdir$md$, $md$Özyineleme (recursion) ile iterasyon arasındaki farklar nelerdir?$md$, $md$**Özyineleme**, bir fonksiyonun problemi küçülterek kendini çağırmasıdır. Her özyinelemeli fonksiyonda iki parça olmalıdır:

- **Taban durumu (base case):** özyinelemeyi durdurur.
- **Özyinelemeli adım:** problemi taban duruma yaklaştırır.

```python
def factorial_rec(n):
    if n <= 1:            # taban durumu
        return 1
    return n * factorial_rec(n - 1)

def factorial_iter(n):
    result = 1
    for i in range(2, n + 1):
        result *= i
    return result
```

| | Özyineleme | İterasyon |
| --- | --- | --- |
| Bellek | Her çağrı için call stack çerçevesi, O(derinlik) | Genelde O(1) |
| Risk | Stack overflow (Python'da varsayılan limit ~1000) | Sonsuz döngü |
| Okunabilirlik | Ağaç, graf, böl-ve-yönet için doğal | Doğrusal işlemler için doğal |
| Performans | Fonksiyon çağrısı maliyeti | Genelde biraz daha hızlı |

### Notlar

- Her özyineleme, açık bir **stack** kullanılarak iterasyona çevrilebilir.
- **Tail call optimization:** son işlem özyinelemeli çağrıysa bazı diller (Scheme, bazı derleyiciler) stack büyütmez; Python ve Java bunu yapmaz.
- Örtüşen alt problemlerde (Fibonacci) naif özyineleme üstel süre alır; **memoization** gerekir.
- Ağaç gezinme, permütasyon üretme, backtracking gibi problemlerde özyineleme kodu çok daha sade yapar.$md$, null, $md$easy$md$, $md$yazilim-muhendisi$md$, $md$algoritmalar$md$),
  ($md$trie-prefix-tree-nedir-ekleme-ve-onek-arama-islemlerini-yazin$md$, $md$Trie (prefix tree) nedir? Ekleme ve önek arama işlemlerini yazın.$md$, $md$**Trie**, string'leri karakter karakter saklayan bir ağaçtır. Her düğüm bir karakteri temsil eder; kökten bir düğüme giden yol bir öneki oluşturur. Kelime sonları bir bayrakla işaretlenir.

Kullanım alanları: otomatik tamamlama, yazım denetimi, IP yönlendirme (longest prefix match), kelime oyunları.

```python
class TrieNode:
    def __init__(self):
        self.children = {}
        self.is_end = False

class Trie:
    def __init__(self):
        self.root = TrieNode()

    def insert(self, word):
        node = self.root
        for ch in word:
            node = node.children.setdefault(ch, TrieNode())
        node.is_end = True

    def _find(self, prefix):
        node = self.root
        for ch in prefix:
            if ch not in node.children:
                return None
            node = node.children[ch]
        return node

    def search(self, word):
        node = self._find(word)
        return node is not None and node.is_end

    def starts_with(self, prefix):
        return self._find(prefix) is not None

    def autocomplete(self, prefix, limit=5):
        node, out = self._find(prefix), []
        def dfs(n, path):
            if len(out) >= limit: return
            if n.is_end: out.append(prefix + path)
            for ch in sorted(n.children):
                dfs(n.children[ch], path + ch)
        if node: dfs(node, "")
        return out
```

### Karmaşıklık

- Ekleme / arama / önek kontrolü: **`O(L)`** (L = kelime uzunluğu), sözlükteki kelime sayısından bağımsız.
- Bellek: en kötü `O(toplam karakter sayısı)`; çok sayıda düğüm nedeniyle hash set'ten fazla bellek harcayabilir.

### Hash set ile karşılaştırma

Tam kelime araması için hash set de ortalama `O(L)`'dir. Trie'nin üstünlüğü **önek sorgularıdır**: "`ka` ile başlayan kelimeler" sorusunu set ile tüm kelimeleri tarayarak cevaplamak gerekir.

Bellek optimizasyonu için tek çocuklu zincirleri birleştiren **radix tree (compressed trie)** kullanılır.$md$, null, $md$hard$md$, $md$yazilim-muhendisi$md$, $md$algoritmalar$md$),
  ($md$nesne-yonelimli-programlamanin-4-temel-prensibi-nedir$md$, $md$Nesne yönelimli programlamanın 4 temel prensibi nedir?$md$, $md$### 1. Encapsulation (kapsülleme)

Veri ve onu işleyen metotlar bir arada tutulur, iç durum dışarıdan doğrudan değiştirilemez. Nesne tutarlılığını kendisi korur.

```java
public class BankAccount {
    private BigDecimal balance = BigDecimal.ZERO;

    public void withdraw(BigDecimal amount) {
        if (amount.compareTo(balance) > 0)
            throw new IllegalStateException("Yetersiz bakiye");
        balance = balance.subtract(amount);
    }
    public BigDecimal getBalance() { return balance; }
}
```

### 2. Abstraction (soyutlama)

Karmaşık detaylar gizlenir, yalnızca gerekli arayüz sunulur. `List` kullanan kod onun dizi mi bağlı liste mi olduğunu bilmek zorunda değildir.

### 3. Inheritance (kalıtım)

Bir sınıf başka bir sınıfın özelliklerini ve davranışlarını devralır, "is-a" ilişkisi kurar: `Dog extends Animal`. Kod tekrarını azaltır ama sıkı bağımlılık yaratır.

### 4. Polymorphism (çok biçimlilik)

Aynı arayüz farklı nesnelerde farklı davranır.

```java
List<Shape> shapes = List.of(new Circle(2), new Square(3));
for (Shape s : shapes) {
    System.out.println(s.area()); // her biri kendi area() metodunu çağırır
}
```

- **Runtime (overriding):** alt sınıf metodu ezer, hangisinin çalışacağı çalışma zamanında belirlenir.
- **Compile-time (overloading):** aynı isimli, farklı parametreli metotlar.

Kapsülleme ile soyutlama sık karıştırılır: kapsülleme **veriyi korumak**, soyutlama **karmaşıklığı gizlemek** ile ilgilidir.$md$, $md$Her prensip için tanımın yanında tek cümlelik gerçek bir örnek verin; ezber tanımlar yerine örnek, konuyu anladığınızı gösterir.$md$, $md$easy$md$, $md$yazilim-muhendisi$md$, $md$oop-tasarim-desenleri$md$),
  ($md$solid-prensiplerini-orneklerle-aciklayin$md$, $md$SOLID prensiplerini örneklerle açıklayın.$md$, $md$### S: Single Responsibility

Bir sınıfın **değişmek için tek bir nedeni** olmalı. `UserService` hem kullanıcı kaydı yapıp hem e-posta HTML'i oluşturup hem de PDF rapor üretiyorsa üç ayrı sınıfa bölünmelidir.

### O: Open/Closed

Sınıflar **genişlemeye açık, değişikliğe kapalı** olmalı. Yeni ödeme yöntemi eklemek için mevcut `if/else` zincirini değiştirmek yerine yeni bir sınıf eklenmeli.

```python
class PaymentMethod:
    def pay(self, amount): ...

class CreditCard(PaymentMethod):
    def pay(self, amount): ...

class Papara(PaymentMethod):      # yeni yöntem: mevcut kod değişmez
    def pay(self, amount): ...

def checkout(method: PaymentMethod, amount):
    method.pay(amount)
```

### L: Liskov Substitution

Alt sınıf, üst sınıfın yerine kullanıldığında programın doğruluğu bozulmamalı. Klasik ihlal: `Square extends Rectangle`. `setWidth(5)` çağrısı karede yüksekliği de değiştirir ve `Rectangle` bekleyen kod şaşırır. Alt sınıfta `NotImplementedError` fırlatmak da bir ihlal işaretidir.

### I: Interface Segregation

İstemciler kullanmadıkları metotlara bağımlı olmamalı. Dev bir `Worker { work(); eat(); sleep(); }` arayüzü yerine `Workable`, `Eatable` gibi küçük arayüzler; robot sınıfı `eat()`'i boş implemente etmek zorunda kalmaz.

### D: Dependency Inversion

Üst seviye modüller alt seviye modüllere değil, **soyutlamalara** bağımlı olmalı.

```python
class OrderService:
    def __init__(self, repo: OrderRepository):   # soyut arayüz
        self.repo = repo
# Üretimde PostgresOrderRepository, testte InMemoryOrderRepository verilir
```

Pratikte SOLID bir kural listesi değil, değişime dayanıklı ve test edilebilir kod için yol göstericidir; aşırı uygulanması gereksiz soyutlamaya yol açabilir.$md$, $md$Her harf için kendi projenizden bir ihlal ve düzeltme örneği hazırlayın; özellikle Liskov ve Dependency Inversion'da takip soruları gelir.$md$, $md$medium$md$, $md$yazilim-muhendisi$md$, $md$oop-tasarim-desenleri$md$),
  ($md$composition-ile-inheritance-arasindaki-fark-nedir-neden-composition-over-inherit$md$, $md$Composition ile inheritance arasındaki fark nedir? Neden "composition over inheritance" denir?$md$, $md$- **Inheritance (kalıtım):** "is-a" ilişkisi. `Car extends Vehicle`. Alt sınıf üst sınıfın uygulamasını devralır.
- **Composition (bileşim):** "has-a" ilişkisi. `Car` bir `Engine` nesnesine **sahiptir** ve işi ona devreder.

### Kalıtımın sorunları

- **Sıkı bağlılık:** üst sınıftaki değişiklik tüm alt sınıfları etkiler (fragile base class).
- **Sınıf patlaması:** `FlyingDuck`, `SwimmingDuck`, `FlyingSwimmingDuck`, `RubberDuck`... Her davranış kombinasyonu için yeni sınıf.
- Davranış derleme zamanında sabittir, çalışırken değiştirilemez.
- Çoğu dilde tekli kalıtım vardır.

### Composition ile

```python
class FlyWithWings:
    def fly(self): return "Kanatlarla uçuyor"

class NoFly:
    def fly(self): return "Uçamıyor"

class Duck:
    def __init__(self, name, fly_behavior):
        self.name = name
        self.fly_behavior = fly_behavior    # davranış enjekte edilir

    def fly(self):
        return self.fly_behavior.fly()

mallard = Duck("Yaban ördeği", FlyWithWings())
rubber = Duck("Lastik ördek", NoFly())
rubber.fly_behavior = FlyWithWings()        # çalışma zamanında değişebilir
```

Faydaları: gevşek bağlılık, davranışların yeniden kullanımı, kolay test (mock bileşen verilebilir).

### Kalıtım ne zaman doğru?

- Gerçek bir "is-a" ilişkisi var ve Liskov prensibi sağlanıyorsa.
- Çerçevenin beklediği genişletme noktalarında (ör. `Exception` sınıfından türetmek).
- Hiyerarşi sığ ve kararlıysa.

Kural: kod tekrarını önlemek için kalıtımı ilk araç olarak seçmeyin; önce composition'ı düşünün.$md$, null, $md$medium$md$, $md$yazilim-muhendisi$md$, $md$oop-tasarim-desenleri$md$),
  ($md$interface-ile-abstract-class-arasindaki-fark-nedir$md$, $md$Interface ile abstract class arasındaki fark nedir?$md$, $md$| | Interface | Abstract class |
| --- | --- | --- |
| Amaç | Bir **yetenek/sözleşme** tanımlar ("can-do") | Ortak bir **temel** sağlar ("is-a") |
| Çoklu kullanım | Bir sınıf birden çok interface uygulayabilir | Yalnızca bir sınıftan türetilebilir (Java/C#) |
| Durum (field) | Örnek alanı tutamaz (yalnızca sabitler) | Örnek alanları ve constructor olabilir |
| Metot gövdesi | Java 8+ `default` metotlar hariç yok | Hem soyut hem somut metotlar |
| Erişim belirleyici | Metotlar varsayılan public | private/protected olabilir |

```java
interface Payable {
    void pay(BigDecimal amount);
}

abstract class Employee {
    protected final String name;
    Employee(String name) { this.name = name; }

    abstract BigDecimal monthlySalary();      // alt sınıf belirler

    public String payslip() {                 // ortak davranış
        return name + ": " + monthlySalary();
    }
}

class Engineer extends Employee implements Payable, Comparable<Engineer> {
    ...
}
```

### Ne zaman hangisi?

- Birbiriyle ilgisiz sınıflara ortak bir davranış kazandırmak istiyorsanız **interface** (`Comparable`, `Serializable`).
- Yakından ilişkili sınıflar ortak kod ve durum paylaşacaksa **abstract class**.
- Şüphedeyseniz interface ile başlayın; daha esnektir ve test için mock'lanması kolaydır.

Python'da resmi interface yoktur; `abc.ABC` ile abstract sınıf veya `typing.Protocol` ile yapısal (duck typing) arayüz tanımlanır.$md$, null, $md$easy$md$, $md$yazilim-muhendisi$md$, $md$oop-tasarim-desenleri$md$),
  ($md$singleton-deseni-nedir-neden-bazen-anti-pattern-olarak-gorulur$md$, $md$Singleton deseni nedir? Neden bazen anti-pattern olarak görülür?$md$, $md$**Singleton**, bir sınıfın uygulama boyunca **tek bir örneği** olmasını garanti eder ve ona global bir erişim noktası sağlar. Tipik örnekler: yapılandırma, logger, bağlantı havuzu.

### Thread-safe uygulama (Java)

```java
// Double-checked locking: volatile şart
public final class Config {
    private static volatile Config instance;
    private Config() { /* dosyadan yükle */ }

    public static Config getInstance() {
        if (instance == null) {
            synchronized (Config.class) {
                if (instance == null) {
                    instance = new Config();
                }
            }
        }
        return instance;
    }
}

// Daha basit ve güvenli: enum singleton
public enum Registry {
    INSTANCE;
    public void register(String key) { ... }
}
```

Kilitsiz ilk kontrolde iki thread aynı anda `null` görüp iki örnek oluşturabilir; bu yüzden senkronizasyon gerekir. `volatile` olmadan başka bir thread yarı kurulmuş nesneyi görebilir. Statik alan başlatma veya **holder** sınıfı deseni de JVM'in sınıf yükleme garantisiyle güvenlidir.

### Neden anti-pattern sayılır?

- **Gizli global durum:** bağımlılık imzada görünmez, kod nereden ne değiştiğini anlamak zorlaşır.
- **Test zorluğu:** sahte (mock) bir örnekle değiştirmek zordur; testler arasında durum sızar.
- **Single Responsibility ihlali:** sınıf hem işini yapar hem kendi yaşam döngüsünü yönetir.
- Dağıtık sistemlerde "tek örnek" yalnızca bir süreç içinde geçerlidir.

### Modern alternatif

Sınıfı normal yazın, **DI container**'da singleton ömrüyle kaydedin (Spring bean'leri varsayılan olarak böyledir). Böylece tek örnek garantisi korunur ama bağımlılık açıkça enjekte edilir ve testte değiştirilebilir.$md$, $md$Singleton'ı anlattıktan sonra dezavantajlarını ve DI ile alternatifini sizin açmanız, deseni ezberlemediğinizi gösterir.$md$, $md$hard$md$, $md$yazilim-muhendisi$md$, $md$oop-tasarim-desenleri$md$),
  ($md$factory-deseni-nedir-ne-zaman-kullanilir$md$, $md$Factory deseni nedir? Ne zaman kullanılır?$md$, $md$**Factory**, nesne oluşturma mantığını istemci kodundan ayıran yaratımsal (creational) bir desendir. İstemci hangi somut sınıfın oluşturulacağını bilmez, yalnızca ortak arayüzle çalışır.

### Simple Factory

```python
class Notifier:
    def send(self, to, msg): raise NotImplementedError

class EmailNotifier(Notifier):
    def send(self, to, msg): print(f"E-posta -> {to}: {msg}")

class SmsNotifier(Notifier):
    def send(self, to, msg): print(f"SMS -> {to}: {msg}")

class NotifierFactory:
    _registry = {"email": EmailNotifier, "sms": SmsNotifier}

    @classmethod
    def create(cls, channel: str) -> Notifier:
        try:
            return cls._registry[channel]()
        except KeyError:
            raise ValueError(f"Bilinmeyen kanal: {channel}")

notifier = NotifierFactory.create(user.preferred_channel)
notifier.send(user.contact, "Siparişiniz kargoda")
```

### Varyasyonlar

- **Factory Method:** oluşturma işi alt sınıflara bırakılır; üst sınıf `create_notifier()` metodunu çağırır, alt sınıflar hangi nesnenin döneceğini belirler.
- **Abstract Factory:** birbiriyle uyumlu nesne **aileleri** üretir. Ör. `LightThemeFactory` hem `Button` hem `Checkbox` üretir, `DarkThemeFactory` de karanlık versiyonlarını.

### Ne zaman?

- Oluşturulacak sınıf çalışma zamanında belirleniyorsa (yapılandırma, kullanıcı tercihi).
- Oluşturma karmaşıksa (birçok bağımlılık, ön ayar) ve tek yerde toplanmalıysa.
- Yeni tür eklemenin istemci kodunu değiştirmemesi isteniyorsa (Open/Closed).

Tek bir somut sınıf varsa ve değişmesi beklenmiyorsa factory gereksiz soyutlamadır; doğrudan constructor yeterlidir.$md$, null, $md$medium$md$, $md$yazilim-muhendisi$md$, $md$oop-tasarim-desenleri$md$),
  ($md$observer-deseni-nedir-gercek-hayatta-nerelerde-karsimiza-cikar$md$, $md$Observer deseni nedir? Gerçek hayatta nerelerde karşımıza çıkar?$md$, $md$**Observer**, bir nesnenin (subject) durumu değiştiğinde ona abone olan nesnelere (observers) **otomatik olarak haber vermesini** sağlayan davranışsal bir desendir. Yayıncı ile aboneler birbirinin somut sınıfını bilmez, gevşek bağlıdır.

```python
class EventEmitter:
    def __init__(self):
        self._listeners = {}

    def on(self, event, callback):
        self._listeners.setdefault(event, []).append(callback)
        return lambda: self._listeners[event].remove(callback)  # unsubscribe

    def emit(self, event, *args):
        for cb in list(self._listeners.get(event, [])):
            cb(*args)

orders = EventEmitter()
orders.on("created", lambda o: print(f"E-posta gönder: {o['id']}"))
orders.on("created", lambda o: print(f"Stoktan düş: {o['id']}"))

orders.emit("created", {"id": 42})
```

Sipariş servisi, e-posta veya stok modülünü bilmeden olayı yayınlar; yeni bir abone eklemek mevcut kodu değiştirmez.

### Gerçek hayattan örnekler

- DOM olayları: `button.addEventListener("click", ...)`
- Node.js `EventEmitter`, RxJS Observable'ları
- React state değişince bileşenlerin yeniden render edilmesi, Redux `subscribe`
- MVC'de model değişince view'in güncellenmesi
- Dağıtık sistemlerde **pub/sub** (Kafka, Redis Pub/Sub) aynı fikrin ölçeklenmiş hâlidir.

### Dikkat edilecekler

- **Bellek sızıntısı:** abonelikten çıkılmazsa observer'lar referans tutulduğu için toplanamaz (React'te `useEffect` cleanup bu yüzden önemlidir).
- Bildirim sırası garanti edilmemeli.
- Senkron bildirimde yavaş bir abone tüm akışı yavaşlatır; bir abonenin hatası diğerlerini engellememeli.
- Zincirleme olaylar akışın takibini zorlaştırabilir.$md$, null, $md$medium$md$, $md$yazilim-muhendisi$md$, $md$oop-tasarim-desenleri$md$),
  ($md$strategy-deseni-nedir-if-else-zincirlerini-nasil-ortadan-kaldirir$md$, $md$Strategy deseni nedir? if/else zincirlerini nasıl ortadan kaldırır?$md$, $md$**Strategy**, bir işin farklı yapılış biçimlerini (algoritmaları) ayrı sınıflara/fonksiyonlara koyup **çalışma zamanında değiştirilebilir** hâle getiren davranışsal bir desendir.

### Problem

```python
def calculate_shipping(order, method):
    if method == "standard":
        return 30
    elif method == "express":
        return 30 + order.weight * 5
    elif method == "free_over_500":
        return 0 if order.total >= 500 else 30
    # her yeni yöntemde bu fonksiyon değişir
```

### Strategy ile

```python
from typing import Protocol

class ShippingStrategy(Protocol):
    def cost(self, order) -> float: ...

class Standard:
    def cost(self, order): return 30

class Express:
    def cost(self, order): return 30 + order.weight * 5

class FreeOver:
    def __init__(self, threshold): self.threshold = threshold
    def cost(self, order): return 0 if order.total >= self.threshold else 30

class Checkout:
    def __init__(self, shipping: ShippingStrategy):
        self.shipping = shipping

    def total(self, order):
        return order.total + self.shipping.cost(order)

STRATEGIES = {"standard": Standard(), "express": Express(), "promo": FreeOver(500)}
checkout = Checkout(STRATEGIES[user_choice])
```

### Faydaları

- **Open/Closed:** yeni yöntem eklemek yeni sınıf eklemektir.
- Her strateji ayrı ve kolayca test edilir.
- Davranış çalışma zamanında değiştirilebilir.

### Örnekler

Sıralama karşılaştırıcıları (`sorted(key=...)`), ödeme yöntemleri, sıkıştırma algoritmaları, Passport.js kimlik doğrulama stratejileri.

Fonksiyonların birinci sınıf vatandaş olduğu dillerde strateji çoğu zaman yalnızca bir fonksiyondur; sınıf hiyerarşisi kurmak şart değildir.$md$, null, $md$medium$md$, $md$yazilim-muhendisi$md$, $md$oop-tasarim-desenleri$md$),
  ($md$dependency-injection-nedir-ioc-container-ne-ise-yarar$md$, $md$Dependency Injection nedir? IoC container ne işe yarar?$md$, $md$**Dependency Injection (DI)**, bir sınıfın ihtiyaç duyduğu bağımlılıkları kendisinin oluşturması yerine **dışarıdan almasıdır**. Bu, **Inversion of Control (IoC)** prensibinin bir uygulamasıdır: nesne oluşturma kontrolü sınıftan alınıp dışarıya verilir.

### DI olmadan

```python
class OrderService:
    def __init__(self):
        self.repo = PostgresOrderRepo()     # somut sınıfa sıkı bağlı
        self.mailer = SmtpMailer("smtp.example.com")
```

Test yazarken gerçek veritabanı ve SMTP gerekir; implementasyonu değiştirmek için sınıfı değiştirmek gerekir.

### DI ile

```python
class OrderService:
    def __init__(self, repo: OrderRepo, mailer: Mailer):
        self.repo = repo
        self.mailer = mailer

# Üretim
service = OrderService(PostgresOrderRepo(db), SmtpMailer(cfg))

# Test
service = OrderService(InMemoryOrderRepo(), FakeMailer())
```

### Enjeksiyon türleri

- **Constructor injection:** önerilen yöntem. Bağımlılıklar zorunlu ve görünür, nesne her zaman geçerli durumda oluşur.
- **Setter/property injection:** opsiyonel bağımlılıklar için.
- **Method injection:** yalnızca tek bir çağrıda gereken bağımlılık için.

### IoC container

Büyük uygulamalarda nesne grafiğini elle kurmak zahmetlidir. **Container** (Spring, .NET `IServiceCollection`, NestJS, Angular) bağımlılıkları kayıttan çözer, nesneleri oluşturur ve **yaşam süresini** yönetir:

| Ömür | Anlamı |
| --- | --- |
| Singleton | Uygulama boyunca tek örnek |
| Scoped | İstek (request) başına bir örnek |
| Transient | Her talepte yeni örnek |

Klasik hata: singleton bir servise scoped bir bağımlılık (ör. DB context) enjekte etmek; scoped nesne gereğinden uzun yaşar (captive dependency).

DI bir container gerektirmez; elle yapılan constructor injection da DI'dır. Container yalnızca kolaylık sağlar.$md$, $md$DI'ın asıl faydası olarak test edilebilirliği somut bir mock örneğiyle anlatın; Service Locator ile farkı sorulabilir: orada sınıf bağımlılığı kendisi ister, DI'da kendisine verilir.$md$, $md$hard$md$, $md$yazilim-muhendisi$md$, $md$oop-tasarim-desenleri$md$),
  ($md$clean-code-nedir-yaygin-code-smell-ler-nelerdir$md$, $md$Clean code nedir? Yaygın code smell'ler nelerdir?$md$, $md$**Clean code**, başkasının (ve altı ay sonraki sizin) kolayca okuyup güvenle değiştirebileceği koddur. Kod bir kez yazılır, defalarca okunur.

### Temel ilkeler

- **Anlamlı isimler:** `d` yerine `elapsedDays`; boolean'lar `isActive`, `hasPermission`.
- **Küçük ve tek işi yapan fonksiyonlar**, az parametre.
- **DRY:** bilginin tek bir kaynağı olsun; ama erken soyutlamadan da kaçının.
- **KISS ve YAGNI:** gerekmeyeni yazmayın.
- Yorum "ne"yi değil "neden"i açıklamalı; kod kendini açıklamalı.
- Hatalar sessizce yutulmamalı.

### Yaygın code smell'ler

| Smell | Belirti | Çözüm |
| --- | --- | --- |
| Long method | 100+ satırlık fonksiyon | Extract method |
| God class | Her şeyi yapan `Manager` sınıfı | Sorumluluklara bölme |
| Duplicate code | Kopyala-yapıştır bloklar | Ortak fonksiyon |
| Long parameter list | 6+ parametre | Parametre nesnesi |
| Magic numbers | `if (status == 3)` | İsimli sabit veya enum |
| Feature envy | Metot başka sınıfın verisiyle uğraşıyor | Metodu o sınıfa taşıma |
| Primitive obsession | Para için `float`, e-posta için düz `str` | Değer nesnesi (`Money`) |
| Derin iç içe if'ler | Ok şeklinde kod | Guard clause, erken dönüş |
| Shotgun surgery | Tek değişiklik için 10 dosyaya dokunma | İlgili mantığı bir araya toplama |

```python
# Önce
def process(u):
    if u is not None:
        if u.active:
            if u.balance > 0:
                charge(u)

# Sonra: guard clause
def charge_active_user(user):
    if user is None or not user.active:
        return
    if user.balance <= 0:
        return
    charge(user)
```

Refactoring testlerle güvenceye alınarak, küçük adımlarla yapılmalıdır ("izci kuralı": dokunduğunuz kodu bulduğunuzdan biraz daha temiz bırakın).$md$, null, $md$medium$md$, $md$yazilim-muhendisi$md$, $md$oop-tasarim-desenleri$md$),
  ($md$process-ile-thread-arasindaki-fark-nedir$md$, $md$Process ile thread arasındaki fark nedir?$md$, $md$**Process (süreç)**, çalışmakta olan bir programın örneğidir; kendi **ayrı adres alanına** (kod, veri, heap, stack), dosya tanımlayıcılarına ve işletim sistemi kaynaklarına sahiptir.

**Thread (iş parçacığı)**, bir process içindeki yürütme birimidir. Aynı process'teki thread'ler **belleği ve kaynakları paylaşır**, ama her birinin kendi stack'i, register'ları ve program sayacı vardır.

| | Process | Thread |
| --- | --- | --- |
| Bellek | Ayrı adres alanı | Process belleğini paylaşır |
| Oluşturma maliyeti | Yüksek | Düşük |
| Context switch | Daha pahalı (sayfa tablosu değişir) | Daha ucuz |
| İletişim | IPC gerekir (pipe, socket, shared memory) | Ortak değişkenler üzerinden, doğrudan |
| İzolasyon | Biri çökerse diğerleri etkilenmez | Bir thread çökerse tüm process çöker |
| Senkronizasyon ihtiyacı | Az | Yüksek: race condition riski |

### Örnekler

- Chrome her sekmeyi ayrı **process**'te çalıştırır: bir sekmenin çökmesi tarayıcıyı düşürmez ve güvenlik izolasyonu sağlar.
- Bir web sunucusu her isteği bir **thread** havuzundaki thread ile işleyebilir: ucuz ve belleği paylaşır.
- Python'da GIL nedeniyle CPU yoğun işlerde `multiprocessing`, I/O yoğun işlerde `threading` veya `asyncio` tercih edilir.

Seçim, izolasyon mu yoksa düşük maliyet ve kolay veri paylaşımı mı istendiğine bağlıdır.$md$, null, $md$easy$md$, $md$yazilim-muhendisi$md$, $md$isletim-sistemleri$md$),
  ($md$deadlock-nedir-olusmasi-icin-gereken-dort-kosul-nelerdir-ve-nasil-onlenir$md$, $md$Deadlock nedir? Oluşması için gereken dört koşul nelerdir ve nasıl önlenir?$md$, $md$**Deadlock (kilitlenme)**, iki veya daha fazla thread/process'in, her birinin diğerinin tuttuğu kaynağı beklemesi nedeniyle **sonsuza kadar** beklemesidir.

```python
import threading
a, b = threading.Lock(), threading.Lock()

def t1():
    with a:
        with b:      # t2 b'yi tutuyorsa bekler
            ...

def t2():
    with b:
        with a:      # t1 a'yı tutuyorsa bekler -> deadlock
            ...
```

### Coffman koşulları (dördü aynı anda sağlanmalı)

1. **Mutual exclusion:** kaynak aynı anda yalnızca bir kişi tarafından kullanılabilir.
2. **Hold and wait:** bir kaynağı tutarken başka kaynak beklenir.
3. **No preemption:** kaynak, sahibinden zorla alınamaz.
4. **Circular wait:** bekleyenler döngüsel bir zincir oluşturur (A, B'yi; B, A'yı bekler).

### Önleme: koşullardan birini kırmak

| Kırılan koşul | Yöntem |
| --- | --- |
| Circular wait | Tüm kilitleri **global sabit bir sırada** almak (en pratik çözüm) |
| Hold and wait | Gereken tüm kaynakları tek seferde almak |
| No preemption | `tryLock` ile zaman aşımı; alınamazsa tutulanları bırakıp tekrar denemek |
| Mutual exclusion | Kilitsiz (lock-free) yapılar, değişmez (immutable) veri |

```python
def transfer(src, dst, amount):
    first, second = sorted([src, dst], key=lambda acc: acc.id)  # sabit sıra
    with first.lock, second.lock:
        src.balance -= amount
        dst.balance += amount
```

### Diğer yaklaşımlar

- **Kaçınma (avoidance):** Banker's algoritması, kaynak tahsisini güvenli durumda tutar; pratikte nadir.
- **Tespit ve kurtarma:** bekleme grafiğinde döngü aranır, bir işlem sonlandırılır. Veritabanları bunu yapar: deadlock'ta bir transaction'ı kurban seçip geri alır.

Benzer kavram **livelock**: thread'ler bloklanmaz ama sürekli birbirine yol verip ilerleyemez.$md$, $md$Banka hesapları arası transfer örneğiyle kilit sıralamasını anlatmak, bu sorudaki en akılda kalıcı ve pratik cevaptır.$md$, $md$hard$md$, $md$yazilim-muhendisi$md$, $md$isletim-sistemleri$md$),
  ($md$mutex-ile-semaphore-arasindaki-fark-nedir$md$, $md$Mutex ile semaphore arasındaki fark nedir?$md$, $md$Her ikisi de paylaşılan kaynaklara eşzamanlı erişimi kontrol eden senkronizasyon araçlarıdır.

### Mutex (mutual exclusion)

- Kritik bölgeye aynı anda **yalnızca bir** thread girer.
- **Sahipliği vardır:** kilidi alan thread bırakmalıdır.
- Bazı implementasyonlar priority inheritance ve recursive kilitleme destekler.

### Semaphore

- Bir **sayaç** tutar. `wait()` (P, acquire) sayacı azaltır, sıfırsa bekletir; `signal()` (V, release) artırır.
- **Counting semaphore:** N adet kaynağa aynı anda N erişim (ör. 10 bağlantılık havuz).
- **Binary semaphore:** 0/1, mutex'e benzer ama sahiplik yoktur; başka bir thread `signal` verebilir. Bu yüzden **olay bildirimi** için de kullanılır.

| | Mutex | Semaphore |
| --- | --- | --- |
| Eşzamanlı erişim | 1 | N |
| Sahiplik | Var | Yok |
| Tipik amaç | Kritik bölgeyi korumak | Sınırlı kaynak sayısını yönetmek, thread'ler arası sinyal |

```python
import threading

lock = threading.Lock()
counter = 0
def increment():
    global counter
    with lock:                 # mutex: tek thread
        counter += 1

db_slots = threading.Semaphore(5)
def query():
    with db_slots:             # aynı anda en fazla 5 thread
        run_query()
```

Benzer araçlar: **read-write lock** (çok okuyucu veya tek yazar), **condition variable** (bir koşul gerçekleşene kadar bekleme), **spinlock** (kısa bekleme için uyumadan döngüde bekleme).$md$, null, $md$medium$md$, $md$yazilim-muhendisi$md$, $md$isletim-sistemleri$md$),
  ($md$virtual-memory-ve-paging-nasil-calisir-page-fault-nedir$md$, $md$Virtual memory ve paging nasıl çalışır? Page fault nedir?$md$, $md$**Virtual memory (sanal bellek)**, her process'e kendine ait, büyük ve sürekli bir adres alanı varmış gibi bir soyutlama sunar. Process'in kullandığı **sanal adresler**, donanım (MMU) ve işletim sistemi tarafından **fiziksel adreslere** çevrilir.

### Faydaları

- **İzolasyon:** bir process diğerinin belleğine erişemez.
- Fiziksel RAM'den büyük programlar çalışabilir (kullanılmayan sayfalar diskte).
- Paylaşılan kütüphaneler fiziksel bellekte tek kopya tutulur.
- `fork()` sonrası copy-on-write ile hızlı process oluşturma.

### Paging

- Sanal bellek sabit boyutlu **sayfalara** (page, genelde 4 KB), fiziksel bellek aynı boyutta **çerçevelere** (frame) bölünür.
- Her process'in bir **sayfa tablosu** vardır: sanal sayfa numarası -> fiziksel çerçeve + bayraklar (geçerli mi, yazılabilir mi, değişti mi).
- Adres = sayfa numarası + sayfa içi offset. 4 KB sayfada son 12 bit offset'tir.
- 64 bit sistemlerde tablo çok büyük olacağından **çok seviyeli** sayfa tabloları kullanılır.
- **TLB (Translation Lookaside Buffer):** son çevirileri önbelleğe alan donanım; her bellek erişiminde tabloyu gezmeyi önler.

### Page fault

Erişilen sayfa o anda fiziksel bellekte değilse donanım bir **page fault** kesmesi üretir:

1. İşletim sistemi adresin geçerli olup olmadığına bakar; geçersizse process'e segmentation fault gönderilir.
2. Geçerliyse boş bir çerçeve bulunur; yoksa bir sayfa **sayfa değiştirme algoritmasıyla** (LRU yaklaşımı, Clock) dışarı atılır, değiştirilmişse diske yazılır.
3. İstenen sayfa diskten yüklenir, tablo güncellenir, komut yeniden çalıştırılır.

Disk erişimi RAM'den binlerce kat yavaştır. Bellek yetersiz kalıp sistem zamanının çoğunu sayfa taşımaya harcarsa buna **thrashing** denir.$md$, null, $md$hard$md$, $md$yazilim-muhendisi$md$, $md$isletim-sistemleri$md$),
  ($md$context-switch-nedir-neden-maliyetlidir$md$, $md$Context switch nedir? Neden maliyetlidir?$md$, $md$**Context switch**, CPU'nun çalışmakta olan bir thread/process'i durdurup başka birini çalıştırmaya geçmesidir. İşletim sistemi zamanlayıcısı (scheduler) bunu çok çekirdekli olsa bile sürekli yapar; böylece aynı anda çalışıyormuş izlenimi oluşur.

### Ne zaman olur?

- Zaman dilimi (time slice) dolunca: **preemptive** zamanlama.
- Thread I/O beklemeye, kilide veya `sleep`'e girince: gönüllü bırakma.
- Daha yüksek öncelikli bir iş hazır olunca.
- Kesme (interrupt) işlenirken.

### Adımlar

1. Mevcut iş parçacığının durumu (register'lar, program sayacı, stack pointer) **PCB/TCB**'ye kaydedilir.
2. Scheduler sıradaki işi seçer.
3. Yeni işin durumu yüklenir.
4. Farklı bir **process**'e geçiliyorsa adres alanı da değişir: sayfa tablosu değiştirilir ve TLB büyük oranda geçersizleşir.

### Neden maliyetli?

- **Doğrudan maliyet:** kayıt/yükleme ve çekirdek moduna geçiş (mikrosaniyeler mertebesinde).
- **Dolaylı maliyet (asıl büyük olan):** CPU önbellekleri ve TLB yeni iş için "soğuk"tur; önbellek ıskaları performansı düşürür.
- Thread geçişi, aynı adres alanında kaldığı için process geçişinden ucuzdur.

### Pratik sonuçları

- Binlerce thread açmak çok fazla context switch'e yol açar; bunun yerine **thread havuzu** kullanılır.
- Node.js event loop, Go goroutine'leri, Java virtual thread'leri, `asyncio` gibi modeller, çok sayıda eşzamanlı işi az sayıda OS thread'iyle yürüterek bu maliyeti azaltır.$md$, null, $md$medium$md$, $md$yazilim-muhendisi$md$, $md$isletim-sistemleri$md$),
  ($md$race-condition-nedir-bir-ornekle-nasil-onlenecegini-gosterin$md$, $md$Race condition nedir? Bir örnekle nasıl önleneceğini gösterin.$md$, $md$**Race condition**, programın sonucunun thread'lerin çalışma **zamanlamasına/sırasına** bağlı olmasıdır. Birden fazla thread paylaşılan veriye eşzamanlı erişip en az biri yazıyorsa ve erişim senkronize değilse oluşur.

### Klasik örnek

`counter += 1` tek bir işlem gibi görünür ama aslında üç adımdır: **oku, artır, yaz**.

```python
import threading

counter = 0
def worker():
    global counter
    for _ in range(100_000):
        counter += 1        # atomik değil

threads = [threading.Thread(target=worker) for _ in range(4)]
for t in threads: t.start()
for t in threads: t.join()
print(counter)  # 400000'den az çıkabilir
```

İki thread aynı anda `5` okur, ikisi de `6` yazar: bir artış kaybolur.

### Çözümler

```python
lock = threading.Lock()
def worker():
    global counter
    for _ in range(100_000):
        with lock:          # kritik bölge
            counter += 1
```

- **Kilit (mutex):** kritik bölgeyi tek thread'e açar.
- **Atomik işlemler:** `AtomicInteger`, compare-and-swap (CAS).
- **Paylaşmamak:** her thread kendi verisiyle çalışıp sonunda birleştirir; değişmez (immutable) veri.
- **Mesajlaşma:** veriyi tek bir sahip yönetir, diğerleri kuyruktan istek gönderir (Go channel, actor modeli).

### Uygulama seviyesindeki karşılığı

Aynı sorun veritabanında da görülür: iki istek aynı anda stoğu `1` okur, ikisi de satış yapar. Çözüm: `UPDATE products SET stock = stock - 1 WHERE id = ? AND stock > 0` gibi atomik sorgu, `SELECT ... FOR UPDATE` veya versiyon numarasıyla iyimser kilitleme (optimistic locking).

Race condition'lar zamanlamaya bağlı olduğu için nadiren ve tutarsız biçimde ortaya çıkar; test ile yakalanması zordur. **Check-then-act** (`if not exists: create`) kalıbı en sık kaynaklardan biridir.$md$, $md$Thread örneğinin yanında veritabanındaki stok/çift rezervasyon senaryosunu da anlatmak, konuyu gerçek bir üretim problemine bağladığınızı gösterir.$md$, $md$medium$md$, $md$yazilim-muhendisi$md$, $md$isletim-sistemleri$md$),
  ($md$concurrency-ile-parallelism-arasindaki-fark-nedir$md$, $md$Concurrency ile parallelism arasındaki fark nedir?$md$, $md$- **Concurrency (eşzamanlılık):** birden fazla işin **aynı zaman aralığında ilerlemesi**dir. İşler sırayla, birbirinin arasına girerek yürütülebilir; tek çekirdekte bile mümkündür. Bir **yapı/tasarım** meselesidir.
- **Parallelism (paralellik):** birden fazla işin **aynı anda fiziksel olarak** çalışmasıdır. Birden fazla çekirdek veya işlemci gerektirir. Bir **yürütme** meselesidir.

Benzetme: tek bir aşçı çorba kaynarken salata doğrar (concurrency); iki aşçı aynı anda farklı yemekleri yapar (parallelism).

| | Concurrency | Parallelism |
| --- | --- | --- |
| Amaç | Bekleme sürelerini değerlendirmek, yanıt verebilirlik | Hesaplamayı hızlandırmak |
| Tipik iş | I/O yoğun (ağ, disk, veritabanı) | CPU yoğun (görüntü işleme, hesaplama) |
| Donanım | Tek çekirdek yeterli | Çok çekirdek |
| Örnek araçlar | async/await, event loop, goroutine | Çoklu process, thread havuzu, GPU, SIMD |

```python
import asyncio
# Concurrency: 3 HTTP isteği beklerken birbirini bloklamaz
async def main():
    results = await asyncio.gather(fetch(u1), fetch(u2), fetch(u3))

from concurrent.futures import ProcessPoolExecutor
# Parallelism: CPU yoğun iş çekirdeklere dağıtılır
with ProcessPoolExecutor() as ex:
    results = list(ex.map(resize_image, images))
```

Bir sistem hem eşzamanlı hem paralel olabilir: çok çekirdekli bir sunucuda çalışan Go programı goroutine'leri birden fazla çekirdeğe dağıtır.

Rob Pike'ın özeti: "Concurrency, birçok şeyle aynı anda **ilgilenmek**; parallelism, birçok şeyi aynı anda **yapmaktır**."$md$, null, $md$easy$md$, $md$yazilim-muhendisi$md$, $md$isletim-sistemleri$md$),
  ($md$en-buyuk-zayif-yonunuz-nedir$md$, $md$En büyük zayıf yönünüz nedir?$md$, $md$Bu soru gerçek bir zayıflığı öğrenmekten çok **öz farkındalığınızı** ve **gelişme isteğinizi** ölçer.

### Kaçınılması gerekenler

- "Mükemmeliyetçiyim", "çok çalışıyorum" gibi kılık değiştirmiş övgüler: samimiyetsiz görünür.
- "Zayıf yönüm yok" demek.
- Rolün çekirdeğini oluşturan bir eksiklik (backend pozisyonunda "veritabanlarından anlamam").

### Cevap yapısı

1. **Gerçek ama işi engellemeyen** bir zayıflık seçin.
2. Bunun sizi nasıl etkilediğini somut bir örnekle anlatın.
3. Bu konuda **ne yaptığınızı** ve şu anki durumu söyleyin.

### Örnek cevap

"Kariyerimin başında, bir işe takıldığımda yardım istemekte geç kalıyordum. Bir keresinde ödeme entegrasyonundaki bir hatayla iki gün tek başıma uğraştım; ekip arkadaşım kendi tecrübesiyle 20 dakikada çözdü. Bu bana tek başına inatlaşmanın ekibe maliyetini gösterdi. O günden beri kendime bir kural koydum: bir sorunda 1–2 saat ilerleme kaydedemezsem, ne denediğimi yazıp soruyorum. Bu hem işlerimi hızlandırdı hem de ekipte bilgi paylaşımını artırdı. Hâlâ bilinçli olarak takip ettiğim bir alışkanlık."

Diğer iyi seçenekler: topluluk önünde konuşma, işleri devretmekte zorlanma, belirli bir teknik alanda (ör. frontend testleri) deneyim eksikliği ve bunu kapatmak için yapılanlar.$md$, $md$Cevabı her zaman bugün attığınız somut bir adımla bitirin; mülakatçının aklında zayıflık değil, gelişim kalmalı.$md$, $md$easy$md$, $md$yazilim-muhendisi$md$, $md$davranissal$md$),
  ($md$neden-bizim-sirketimizde-calismak-istiyorsunuz$md$, $md$Neden bizim şirketimizde çalışmak istiyorsunuz?$md$, $md$Bu soru şirketi araştırıp araştırmadığınızı ve motivasyonunuzun bu role özgü olup olmadığını ölçer. "Büyük ve iyi bir şirket" veya "maaş" gibi genel cevaplar zayıftır.

### Hazırlık

- Şirketin ürünü kullanılabiliyorsa kullanın.
- Mühendislik blogu, açık kaynak projeleri, konferans konuşmaları, iş ilanındaki teknoloji yığını.
- Son haberler: yeni ürün, yatırım, büyüme alanı.
- Çalışanların LinkedIn paylaşımları ve şirket değerleri.

### Cevap formülü

1. **Şirket / ürün:** sizi gerçekten ilgilendiren somut bir şey.
2. **Rol / teknoloji:** pozisyonun öğrenmek veya derinleşmek istediğiniz alana nasıl uyduğu.
3. **Katkı:** sizin deneyiminizin onlara nasıl fayda sağlayacağı.

### Örnek cevap

"Üç sebebim var. Birincisi, ürününüzü bir yıldır kendi muhasebem için kullanıyorum ve küçük işletmelerin e-fatura gibi karmaşık süreçlerini nasıl sadeleştirdiğinizi kullanıcı olarak gördüm. İkincisi, mühendislik blogunuzda monolitten servislere geçişinizi anlatan yazıyı okudum; dağıtık sistemler ve event-driven mimari tam olarak derinleşmek istediğim alan. Üçüncüsü, şu anki işimde yüksek trafikli bir ödeme servisini ölçekledim; ilandaki 'ödeme altyapısı' ekibine bu deneyimle hızlı katkı sağlayabileceğimi düşünüyorum."

Cevap kısa (1–2 dakika) olmalı ve araştırmanızı gösteren en az bir **spesifik** detay içermelidir.$md$, null, $md$easy$md$, $md$yazilim-muhendisi$md$, $md$davranissal$md$),
  ($md$basarisiz-oldugunuz-bir-durumu-ve-ondan-ne-ogrendiginizi-anlatin$md$, $md$Başarısız olduğunuz bir durumu ve ondan ne öğrendiğinizi anlatın.$md$, $md$Bu soru sorumluluk alıp alamadığınızı, hatalardan öğrenip öğrenmediğinizi ve baskı altında nasıl davrandığınızı ölçer. **STAR** yöntemiyle yapılandırın.

### STAR yöntemi

- **S (Situation):** bağlam. Proje, ekip, kritiklik. Kısa tutun.
- **T (Task):** sizin sorumluluğunuz neydi?
- **A (Action):** ne yaptınız? "Biz" değil **"ben"** diye anlatın. Cevabın en uzun kısmı burası olmalı.
- **R (Result):** sonuç, mümkünse sayılarla; bu soruda **öğrenilen ders** ve sonradan nasıl uygulandığı.

### Dikkat edilecekler

- Gerçek bir başarısızlık seçin; "aslında başarıydı" hikâyeleri inandırıcı değildir.
- Suçu başkasına atmayın.
- Felaket boyutunda veya etik sorun içeren bir hikâye seçmeyin.

### Örnek cevap

"**(S)** Bir e-ticaret projesinde sipariş tablosuna yeni bir kolon eklenen bir migration'ı Cuma akşamı canlıya aldım. **(T)** Değişikliğin geliştirilmesi ve deploy'u benim sorumluluğumdaydı. Migration büyük tabloyu kilitledi ve yaklaşık 15 dakika boyunca sipariş alınamadı.

**(A)** Durumu fark eder etmez ekibe haber verdim, deploy'u geri aldım ve servisi ayağa kaldırdım. Ertesi gün bir postmortem yazdım: test ortamındaki tablo canlıdaki 30 milyon satırın yanında çok küçüktü ve kilitlenme orada görünmemişti. Migration'ı, kolonu önce nullable ekleyip veriyi parçalar hâlinde dolduracak şekilde yeniden yazdım.

**(R)** Ekipte büyük tablolar için migration kontrol listesi oluşturduk ve Cuma öğleden sonra deploy yapmama kuralı getirdik. Sonraki bir yılda migration kaynaklı kesinti yaşamadık. Kendi açımdan öğrendiğim, canlı ortamın veri hacmini test ortamından bağımsız olarak düşünmem gerektiğiydi."$md$, $md$Hikâyenin en az üçte birini sonuç ve öğrenilen derse ayırın; mülakatçı başarısızlığın kendisinden çok sonrasında ne yaptığınızı dinler.$md$, $md$medium$md$, $md$yazilim-muhendisi$md$, $md$davranissal$md$),
  ($md$sikisik-bir-teslim-tarihinde-birden-fazla-isi-nasil-onceliklendirirsiniz$md$, $md$Sıkışık bir teslim tarihinde birden fazla işi nasıl önceliklendirirsiniz?$md$, $md$Bu soru planlama, iletişim ve paydaşlarla beklenti yönetimi becerinizi ölçer. İyi bir cevap hem **yöntem** hem **gerçek bir örnek** içerir.

### Yöntem

1. **Görünür kılmak:** tüm işleri listeleyin, tahmini süreleri çıkarın.
2. **Etki ve aciliyet:** iş etkisi yüksek, başka işleri bloklayan, geri dönüşü olmayan işler öne alınır. Eisenhower matrisi (acil/önemli) veya MoSCoW (Must/Should/Could/Won't) kullanılabilir.
3. **Kapsamı müzakere etmek:** her şey yetişmeyecekse bunu erken söyleyin ve seçenek sunun: "Tarihi koruyup X özelliğini sonraki sürüme bırakabiliriz ya da hepsini bir hafta sonra teslim ederiz."
4. **Erken ve sık iletişim:** riskleri son güne bırakmamak.
5. **Kaliteden sessizce ödün vermemek:** test atlanacaksa bu bilinçli ve görünür bir karar olmalı, teknik borç olarak kaydedilmeli.

### Örnek cevap (STAR)

"**(S)** Bir kampanya lansmanından bir hafta önce, ödeme sayfası yenilemesi, bir müşterinin acil hata bildirimi ve raporlama ekranı aynı anda üzerimdeydi. **(T)** Hepsinin lansmana yetişmesi bekleniyordu ama tahminlerim toplamda 9 iş günü tutuyordu.

**(A)** Önce hatayı inceledim; ödemeyi etkileyen kritik bir sorundu, aynı gün çözdüm. Sonra ürün yöneticisiyle oturup kalan iki işi kampanyaya etkisi açısından değerlendirdik. Raporlama ekranı yalnızca iç ekip tarafından kullanılıyordu; lansmandan sonraya ertelemeyi önerdim ve geçici olarak bir SQL sorgusuyla CSV rapor sağladım. Ödeme sayfasında da 'olmazsa olmaz' maddeleri ayırdık.

**(R)** Kampanya zamanında ve sorunsuz çıktı, rapor ekranı bir hafta sonra tamamlandı. Bu deneyimden sonra her sprint başında işlerin kampanya ve gelir etkisini ürün ekibiyle birlikte sıralamayı alışkanlık hâline getirdim."$md$, null, $md$medium$md$, $md$yazilim-muhendisi$md$, $md$davranissal$md$),
  ($md$maas-beklentiniz-nedir-bu-soruyu-nasil-yonetmelisiniz$md$, $md$Maaş beklentiniz nedir? Bu soruyu nasıl yönetmelisiniz?$md$, $md$Bu soru hem pazarlık hem de kendinizi ne kadar iyi tanıdığınızla ilgilidir. Amaç, düşük bir rakam söyleyip kendinizi bağlamamak ve aynı zamanda kaçamak görünmemektir.

### Hazırlık

- **Piyasayı araştırın:** topluluk maaş anketleri, Glassdoor/LinkedIn verileri, aynı seviyedeki tanıdıklar. Şehir, sektör (finans, oyun, ajans), şirket büyüklüğü ve uzaktan çalışma rakamı ciddi etkiler.
- Kendi **alt sınırınızı** (bunun altına kabul etmem) ve **hedefinizi** belirleyin.
- **Net mi brüt mü** konuşulduğunu netleştirin; Türkiye'de pazarlıklar çoğu zaman aylık net üzerinden yapılır ama teklif mektubu brüt olabilir. Döviz bazlı veya enflasyon ayarlı zam politikası da sorulmalı.
- Toplam paketi düşünün: prim/bonus, yemek kartı, özel sağlık sigortası, hisse, eğitim bütçesi, uzaktan/hibrit çalışma, yıllık izin, yılda kaç kez zam yapıldığı.

### Taktikler

- Mümkünse önce **rolün kapsamını ve bütçeyi** öğrenmeye çalışın: "Pozisyonun sorumluluklarını biraz daha anlamak isterim; bu rol için belirlediğiniz bir aralık var mı?"
- Rakam vermeniz gerekiyorsa **araştırmaya dayalı bir aralık** verin ve aralığın alt ucunu gerçek hedefinize yakın tutun.
- Mevcut maaşınızı söylemek zorunda değilsiniz; beklentiye odaklanın.
- Teklif geldiğinde hemen kabul etmeyin; teşekkür edip değerlendirmek için süre isteyin. Karşı teklif nazik ve gerekçeli olmalı.

### Örnek cevap

"Pozisyonun sorumlulukları, deneyimim ve piyasa araştırmama göre aylık net **X ile Y TL** arasında bir rakam bekliyorum. Tabii yan haklar ve toplam paketle birlikte değerlendirmek isterim; bu konuda esneklik payım var. Sizin bu rol için öngördüğünüz bütçe nedir?"

Mülakatın ilk aşamasında soruluyorsa kısa tutup "Süreç ilerledikçe toplam paketi birlikte konuşmak isterim, ama beklentim kabaca bu aralıkta" demek de kabul görür.$md$, $md$Rakamı söyledikten sonra susun ve karşı tarafın yanıtını bekleyin; hemen gerekçe sıralamak veya rakamı kendiliğinden düşürmek, pazarlıkta en sık yapılan hatadır.$md$, $md$hard$md$, $md$yazilim-muhendisi$md$, $md$davranissal$md$)
) as v(slug, title, answer, tip, difficulty, profession_slug, topic_slug)
join public.professions p on p.slug = v.profession_slug
join public.topics t on t.slug = v.topic_slug
on conflict (slug) do nothing;
