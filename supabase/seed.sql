-- Mülakat Defteri — initial content (83 questions)
-- Run AFTER schema.sql. Idempotent (safe to run again).

insert into public.professions (slug, name, short_name, description, sort_order) values
  ($md$frontend-developer$md$, $md$Frontend Developer$md$, $md$Frontend$md$, $md$HTML, CSS, JavaScript ve React mülakat soruları: tarayıcı, DOM, performans ve modern arayüz geliştirme konuları.$md$, 10),
  ($md$backend-developer$md$, $md$Backend Developer$md$, $md$Backend$md$, $md$API tasarımı, veritabanları, Python ve ölçeklenebilir sunucu mimarisi üzerine backend mülakat soruları.$md$, 20),
  ($md$full-stack-developer$md$, $md$Full Stack Developer$md$, $md$Full Stack$md$, $md$Web güvenliği, sistem tasarımı, Git ve uçtan uca uygulama geliştirme üzerine full stack mülakat soruları.$md$, 30),
  ($md$yazilim-muhendisi$md$, $md$Yazılım Mühendisi$md$, $md$Yazılım Müh.$md$, $md$Algoritmalar, veri yapıları ve davranışsal sorular: her yazılım pozisyonunda karşınıza çıkan temel mülakat soruları.$md$, 40),
  ($md$game-developer$md$, $md$Oyun Geliştirici (Game Developer)$md$, $md$Game Dev$md$, $md$Unity, C#, oyun döngüsü, fizik ve oyun matematiği üzerine oyun geliştirici mülakat soruları.$md$, 50),
  ($md$network-engineer$md$, $md$Network Mühendisi$md$, $md$Network$md$, $md$OSI ve TCP/IP, alt ağlar, DNS, VLAN, OSPF ve BGP üzerine network mühendisi mülakat soruları.$md$, 60),
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

Örneğin insan kulağı yaklaşık 20 kHz'e kadar duyar; CD kalitesinde ses bu yüzden 44,1 kHz ile örneklenir.$md$, null, $md$medium$md$, $md$elektrik-elektronik-muhendisi$md$, $md$sinyal-isleme$md$)
) as v(slug, title, answer, tip, difficulty, profession_slug, topic_slug)
join public.professions p on p.slug = v.profession_slug
join public.topics t on t.slug = v.topic_slug
on conflict (slug) do nothing;
