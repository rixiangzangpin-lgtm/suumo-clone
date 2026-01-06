import { createClient } from '@/lib/supabase/server'
import Header from '@/components/Header'
import PropertyCard from '@/components/PropertyCard'

/**
 * 物件一覧ページ（Server Component）
 * Supabaseから物件データを取得して表示します
 */
export default async function HomePage() {
  const supabase = createClient()
  
  // 物件データを取得（画像も一緒に取得）
  const { data: properties, error } = await supabase
    .from('properties')
    .select(`
      *,
      property_images (
        id,
        image_url,
        display_order
      )
    `)
    .order('created_at', { ascending: false })

  return (
    <div className="min-h-screen">
      <Header />
      
      <main className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-6">
        {/* エラー処理 */}
        {error && (
          <div className="bg-red-50 border border-red-200 rounded-lg p-4 mb-6">
            <p className="text-red-800 font-bold mb-1">エラーが発生しました</p>
            <p className="text-red-600 text-sm">{error.message}</p>
          </div>
        )}

        {/* データが存在しない場合 */}
        {!error && (!properties || properties.length === 0) && (
          <div className="bg-white rounded-lg p-8 text-center">
            <p className="text-gray-600">物件が見つかりませんでした。</p>
          </div>
        )}

        {/* 物件リスト */}
        {!error && properties && properties.length > 0 && (
          <>
            <div className="mb-4">
              <h2 className="text-2xl font-bold text-gray-800">
                物件一覧
              </h2>
              <p className="text-sm text-gray-600 mt-1">
                全{properties.length}件の物件が見つかりました
              </p>
            </div>

            <div className="space-y-4">
              {properties.map((property) => (
                <PropertyCard key={property.id} property={property} />
              ))}
            </div>
          </>
        )}
      </main>
    </div>
  )
}
