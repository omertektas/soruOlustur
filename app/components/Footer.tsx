export default function Footer() {
  return (
    <footer className="bg-gray-900 text-gray-300 border-t border-gray-800 mt-20">
      <div className="mx-auto max-w-6xl px-4 py-12 sm:px-6 lg:px-8">
        <div className="grid grid-cols-1 md:grid-cols-4 gap-8">
          {/* Marka ve Açıklama */}
          <div className="col-span-1 md:col-span-2">
            <div className="flex items-center gap-2 mb-4">
              <span className="text-xl font-bold text-white">
                OFTECHSOLUTIONS
              </span>
            </div>
            <p className="text-sm text-gray-400 max-w-xs leading-relaxed">
              Öğretmenler ve öğrenciler için geliştirilmiş sınav hazırlama &&
              sınava hazırlık aracı. Saniyeler içinde PDF notlarınızı sınav
              sorularına dönüştürün.
            </p>
          </div>

          {/* Yasal & İletişim */}
          <h2>
            <a
            href="mailto:omerfaruktektas@outlook.com?subject=AI Sınav Hazırlayıcı Hakkında&body=Merhaba,"
            className=" text-gray-500 hover:text-blue-600 transition-colors"
          >
            <b>Bizimle iletişime geçin</b>
          </a>
          </h2>
        </div>

        <div className="border-t border-gray-800 mt-12 pt-8 flex flex-col md:flex-row justify-between items-center text-sm text-gray-500">
          <p>&copy; 2026 SınavHazırlayıcı. Tüm hakları saklıdır.</p>
          <p className="mt-2 md:mt-0">
            *Yapay zeka hatalı bilgi verebilir, soruları kontrol ediniz.
          </p>
        </div>
      </div>
    </footer>
  );
}
