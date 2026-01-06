import { createServerClient } from '@supabase/ssr'
import { cookies } from 'next/headers'

/**
 * サーバーサイド（Server Components, Server Actions）用のSupabaseクライアント
 * 
 * 使用例（Server Component）:
 * ```tsx
 * import { createClient } from '@/lib/supabase/server'
 * 
 * export default async function Page() {
 *   const supabase = createClient()
 *   const { data } = await supabase.from('properties').select('*')
 *   return <div>...</div>
 * }
 * ```
 * 
 * 使用例（Server Action）:
 * ```tsx
 * 'use server'
 * import { createClient } from '@/lib/supabase/server'
 * 
 * export async function getProperties() {
 *   const supabase = createClient()
 *   const { data } = await supabase.from('properties').select('*')
 *   return data
 * }
 * ```
 */
export function createClient() {
  const cookieStore = cookies()

  return createServerClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!,
    {
      cookies: {
        getAll() {
          return cookieStore.getAll()
        },
        // カッコの中身に : { ... }[] を追加して型を教える
        setAll(cookiesToSet: { name: string; value: string; options: any }[]) {
          try {
            cookiesToSet.forEach(({ name, value, options }) =>
              cookieStore.set(name, value, options)
            )
          } catch {
            // The `setAll` method was called from a Server Component.
            // This can be ignored if you have middleware refreshing
            // user sessions.
          }
        },
      },
    }
  )
}
