/** @type {import('next').NextConfig} */
const nextConfig = {
  // Bu ayar, pdf-parse gibi eski kütüphanelerin hatasız çalışmasını sağlar
  serverExternalPackages: ["pdf-parse"], 
};

export default nextConfig;