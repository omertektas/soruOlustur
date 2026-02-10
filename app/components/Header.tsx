import Link from "next/link";

export default function Header() {
  return (
    <header className="sticky top-0 z-50 w-full border-b border-gray-200 bg-white/80 backdrop-blur-md">
      <div className="mx-auto flex h-16 max-w-6xl items-center justify-between px-4 sm:px-6 lg:px-8">
        {/* Logo Alanı */}
        <div className="flex items-center gap-2">
          
          <Link href="/" className="text-xl font-bold text-gray-900 tracking-tight">
            OFTECH<span className="text-blue-600">SOLUTIONS</span>
          </Link>
        </div>

        {/* Menü Linkleri (Masaüstü) */}
        <nav className="hidden md:flex gap-8 text-sm font-medium text-gray-600">
          <a href="#nasil-calisir" className="hover:text-blue-600 transition-colors">Nasıl Çalışır?</a>
         
        </nav>

       
      </div>
    </header>
  );
}