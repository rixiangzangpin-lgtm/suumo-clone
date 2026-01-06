import Image from 'next/image'

interface PropertyImage {
  id: string
  image_url: string
  display_order: number
}

interface Property {
  id: string
  name: string
  rent: number
  management_fee: number
  address: string
  layout: string
  area: number
  building_age: number
  latitude: number
  longitude: number
  property_images?: PropertyImage[]
}

interface PropertyCardProps {
  property: Property
}

/**
 * 物件カードコンポーネント
 * PC: 横長レイアウト（画像左・詳細右）
 * スマホ: 縦長カード
 */
export default function PropertyCard({ property }: PropertyCardProps) {
  // 画像URLを取得（最初の画像を使用、なければプレースホルダー）
  const imageUrl = property.property_images && property.property_images.length > 0
    ? property.property_images.sort((a, b) => a.display_order - b.display_order)[0].image_url
    : 'https://placehold.co/400x300'
  
  // 敷金・礼金はダミーデータ（実際のデータがないため）
  const deposit = '-'
  const keyMoney = '-'

  return (
    <div className="bg-white border border-gray-200 rounded-lg overflow-hidden hover:shadow-lg transition-shadow duration-200">
      <div className="flex flex-col md:flex-row">
        {/* 左側: 物件画像 */}
        <div className="relative w-full md:w-80 h-48 md:h-40 flex-shrink-0">
          <Image
            src={imageUrl}
            alt={property.name}
            fill
            className="object-cover"
            unoptimized
          />
          {/* 画像上のバッジ */}
          <div className="absolute top-2 left-2 flex flex-col gap-1">
            <span className="bg-red-500 text-white text-xs px-2 py-0.5 rounded font-bold">
              新着
            </span>
            <span className="bg-blue-500 text-white text-xs px-2 py-0.5 rounded">
              動画あり
            </span>
          </div>
        </div>

        {/* 右側: 物件詳細 */}
        <div className="flex-1 p-4 md:p-5">
          <div className="flex items-start justify-between mb-2">
            <h3 className="text-lg md:text-xl font-bold text-blue-600 hover:text-blue-800 cursor-pointer line-clamp-2 flex-1">
              {property.name}
            </h3>
          </div>

          {/* メイン情報: グリッド形式 */}
          <div className="grid grid-cols-2 md:grid-cols-3 gap-3 mb-3 text-sm">
            {/* 賃料 */}
            <div className="col-span-2 md:col-span-1">
              <div className="text-xs text-gray-500 mb-0.5">賃料</div>
              <div className="flex items-baseline gap-1">
                <span className="text-2xl font-bold text-red-600">
                  {(property.rent / 10000).toFixed(1)}万円
                </span>
                {property.management_fee > 0 && (
                  <span className="text-sm text-gray-600">
                    (管理費 {property.management_fee.toLocaleString()}円)
                  </span>
                )}
              </div>
            </div>

            {/* 敷/礼 */}
            <div>
              <div className="text-xs text-gray-500 mb-0.5">敷/礼</div>
              <div className="border border-gray-300 rounded px-2 py-1 text-sm inline-block">
                敷 {deposit} / 礼 {keyMoney}
              </div>
            </div>

            {/* 間取り/専有面積 */}
            <div>
              <div className="text-xs text-gray-500 mb-0.5">間取り/専有面積</div>
              <div className="text-sm font-medium">
                {property.layout} / {property.area}m²
              </div>
            </div>

            {/* 所在地 */}
            <div className="col-span-2 md:col-span-1">
              <div className="text-xs text-gray-500 mb-0.5">所在地</div>
              <div className="text-sm">{property.address}</div>
            </div>

            {/* アクセス */}
            <div className="col-span-2 md:col-span-1">
              <div className="text-xs text-gray-500 mb-0.5">アクセス</div>
              <div className="text-sm">
                {property.address.split('区')[0]}区 徒歩5分
              </div>
            </div>

            {/* 築年数 */}
            <div>
              <div className="text-xs text-gray-500 mb-0.5">築年数</div>
              <div className="text-sm font-medium">築{property.building_age}年</div>
            </div>
          </div>

          {/* CTAボタン */}
          <div className="flex gap-2 mt-3 pt-3 border-t border-gray-100">
            <button className="flex-1 bg-orange-500 text-white px-4 py-2 rounded-md hover:bg-orange-600 text-sm font-medium transition-colors">
              詳細を見る
            </button>
            <button className="px-4 py-2 border border-gray-300 rounded-md hover:bg-gray-50 text-sm flex items-center gap-1">
              <svg className="w-5 h-5 text-gray-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z" />
              </svg>
              <span className="hidden sm:inline">お気に入り</span>
            </button>
          </div>
        </div>
      </div>
    </div>
  )
}
