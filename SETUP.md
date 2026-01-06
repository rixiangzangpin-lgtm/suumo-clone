# Supabase接続セットアップガイド

このガイドでは、Next.js（App Router）からSupabaseに接続するための設定手順を説明します。

## 📋 前提条件

- Node.js 18以上がインストールされていること
- Supabaseプロジェクトが作成済みであること
- Supabaseのデータベーススキーマが作成済みであること

## 🚀 セットアップ手順

### ステップ1: 必要なパッケージのインストール

ターミナルで以下のコマンドを実行してください：

```bash
npm install @supabase/ssr @supabase/supabase-js
```

または、yarnを使用する場合：

```bash
yarn add @supabase/ssr @supabase/supabase-js
```

### ステップ2: 環境変数の設定

1. **Supabaseの認証情報を取得**
   - Supabaseダッシュボードにログイン
   - プロジェクトを選択
   - 左メニューから「Settings」→「API」を選択
   - 以下の情報をコピー：
     - **Project URL**（例: `https://xxxxx.supabase.co`）
     - **anon public**キー（`Project API keys`セクション）

2. **`.env.local`ファイルの作成**
   - プロジェクトのルートディレクトリに`.env.local`ファイルを作成
   - 以下の内容を記入（実際の値に置き換えてください）：

```env
NEXT_PUBLIC_SUPABASE_URL=https://xxxxx.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key-here
```

⚠️ **重要**: `.env.local`ファイルは`.gitignore`に含まれているため、Gitにコミットされません。これは機密情報を保護するためです。

### ステップ3: Supabaseクライアントファイルの確認

以下のファイルが既に作成されていることを確認してください：

- `lib/supabase/client.ts` - クライアントサイド用
- `lib/supabase/server.ts` - サーバーサイド用

これらのファイルは既にプロジェクトに含まれています。

## 📝 使用方法

### クライアントサイド（ブラウザ）での使用

```tsx
'use client'

import { createClient } from '@/lib/supabase/client'
import { useEffect, useState } from 'react'

export default function ClientComponent() {
  const [properties, setProperties] = useState([])
  
  useEffect(() => {
    async function fetchProperties() {
      const supabase = createClient()
      const { data, error } = await supabase
        .from('properties')
        .select('*')
      
      if (error) {
        console.error('Error:', error)
      } else {
        setProperties(data)
      }
    }
    
    fetchProperties()
  }, [])
  
  return (
    <div>
      {properties.map((property) => (
        <div key={property.id}>{property.name}</div>
      ))}
    </div>
  )
}
```

### サーバーサイド（Server Component）での使用

```tsx
import { createClient } from '@/lib/supabase/server'

export default async function ServerComponent() {
  const supabase = createClient()
  const { data: properties, error } = await supabase
    .from('properties')
    .select('*')
  
  if (error) {
    console.error('Error:', error)
    return <div>エラーが発生しました</div>
  }
  
  return (
    <div>
      {properties?.map((property) => (
        <div key={property.id}>{property.name}</div>
      ))}
    </div>
  )
}
```

### サーバーアクション（Server Action）での使用

```tsx
'use server'

import { createClient } from '@/lib/supabase/server'

export async function getProperties() {
  const supabase = createClient()
  const { data, error } = await supabase
    .from('properties')
    .select('*')
  
  if (error) {
    throw new Error(error.message)
  }
  
  return data
}
```

## 🔍 動作確認

1. 開発サーバーを起動：
   ```bash
   npm run dev
   ```

2. ブラウザで `http://localhost:3000` を開く

3. ブラウザのコンソール（F12）でエラーがないか確認

## ❓ トラブルシューティング

### エラー: "NEXT_PUBLIC_SUPABASE_URL is not defined"

- `.env.local`ファイルが正しく作成されているか確認
- 環境変数名が`NEXT_PUBLIC_`で始まっているか確認（クライアントサイドで使用する場合は必須）
- 開発サーバーを再起動（環境変数の変更後は再起動が必要）

### エラー: "Invalid API key"

- Supabaseダッシュボードで正しいキーをコピーしたか確認
- キーに余分なスペースや改行が含まれていないか確認

### データが取得できない

- SupabaseのRLS（Row Level Security）ポリシーを確認
- 認証が必要な場合は、ユーザーがログインしているか確認

## 📚 参考リンク

- [Supabase公式ドキュメント](https://supabase.com/docs)
- [Next.js公式ドキュメント](https://nextjs.org/docs)
- [@supabase/ssr ドキュメント](https://supabase.com/docs/guides/auth/server-side/creating-a-client)
