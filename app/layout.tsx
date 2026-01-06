import type { Metadata } from 'next'
import './globals.css'

export const metadata: Metadata = {
  title: 'SUUMO - 不動産検索アプリ',
  description: '不動産物件を検索・閲覧できるアプリケーション',
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="ja">
      <body className="bg-[#f2f2f2]">
        {children}
      </body>
    </html>
  )
}
