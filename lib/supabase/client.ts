import { createBrowserClient } from '@supabase/ssr'

/**
 * クライアントサイド（ブラウザ）用のSupabaseクライアント
 * 
 * 使用例:
 * ```tsx
 * 'use client'
 * import { createClient } from '@/lib/supabase/client'
 * 
 * const supabase = createClient()
 * const { data } = await supabase.from('properties').select('*')
 * ```
 */
export function createClient() {
  return createBrowserClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!
  )
}
