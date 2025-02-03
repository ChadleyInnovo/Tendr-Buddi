/** @type {import('next').NextConfig} */
const nextConfig = {
  output: "standalone",
  poweredByHeader: false,
  compress: true,
  productionBrowserSourceMaps: false,
  images: {
    domains: ["localhost"],
    unoptimized: false,
  },
  experimental: {
    serverActions: true,
  },
}

module.exports = nextConfig

