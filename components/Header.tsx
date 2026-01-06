/**
 * ヘッダーコンポーネント（Sticky固定）
 */
export default function Header() {
  return (
    <header className="sticky top-0 z-50 bg-white border-b border-gray-200 shadow-sm">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex items-center justify-between h-16">
          {/* 左側: ロゴ */}
          <div className="flex items-center">
            <h1 className="text-2xl font-bold text-suumo-green">
              SUUMOクローン
            </h1>
          </div>

          {/* 中央: ナビゲーションメニュー */}
          <nav className="hidden md:flex items-center space-x-6">
            <a href="#" className="text-gray-700 hover:text-suumo-green font-medium text-sm">
              借りる
            </a>
            <a href="#" className="text-gray-700 hover:text-suumo-green font-medium text-sm">
              買う
            </a>
            <a href="#" className="text-gray-700 hover:text-suumo-green font-medium text-sm">
              建てる
            </a>
            <a href="#" className="text-gray-700 hover:text-suumo-green font-medium text-sm">
              売る
            </a>
          </nav>

          {/* 右側: ログイン・お気に入り */}
          <div className="flex items-center space-x-4">
            <button className="hidden sm:flex items-center space-x-1 text-gray-700 hover:text-suumo-green text-sm">
              <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z" />
              </svg>
              <span>お気に入り</span>
            </button>
            <button className="px-4 py-2 bg-suumo-green text-white rounded-md hover:bg-[#0a8f25] text-sm font-medium">
              ログイン
            </button>
          </div>
        </div>
      </div>
    </header>
  )
}
