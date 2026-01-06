# Node.js インストールガイド

## 問題
`npm`コマンドが認識されない場合、Node.jsがインストールされていないか、PATHに追加されていない可能性があります。

## 解決方法

### ステップ1: Node.jsのインストール

1. **Node.js公式サイトにアクセス**
   - https://nodejs.org/ にアクセス

2. **LTS版をダウンロード**
   - 「推奨版」（LTS - Long Term Support）を選択
   - Windows用のインストーラー（.msiファイル）をダウンロード

3. **インストーラーを実行**
   - ダウンロードした`.msi`ファイルをダブルクリック
   - インストールウィザードに従って進める
   - **重要**: 「Add to PATH」オプションがチェックされていることを確認（通常はデフォルトでチェックされています）

4. **インストール完了後、PowerShellを再起動**
   - 現在開いているPowerShellを閉じる
   - 新しいPowerShellウィンドウを開く

### ステップ2: インストール確認

新しいPowerShellウィンドウで、以下のコマンドを実行して確認してください：

```powershell
node --version
npm --version
```

両方のコマンドがバージョン番号を表示すれば、インストール成功です。

### ステップ3: パッケージのインストール

Node.jsのインストールが確認できたら、プロジェクトディレクトリで以下を実行：

```powershell
npm install
```

または、Supabaseパッケージのみをインストールする場合：

```powershell
npm install @supabase/ssr @supabase/supabase-js
```

## トラブルシューティング

### PowerShellを再起動してもnpmが認識されない場合

1. **環境変数の確認**
   - Windowsキー + R を押す
   - `sysdm.cpl` と入力してEnter
   - 「詳細設定」タブ → 「環境変数」をクリック
   - 「システム環境変数」の「Path」を選択 → 「編集」
   - 以下のパスが含まれているか確認：
     - `C:\Program Files\nodejs\`
     - または `C:\Program Files (x86)\nodejs\`
   - 含まれていない場合は追加

2. **手動でPATHに追加する場合**
   - 上記の環境変数設定で、Node.jsのインストールパスを追加
   - PowerShellを再起動

### 別の方法: nvm-windowsを使用（上級者向け）

複数のNode.jsバージョンを管理したい場合は、nvm-windowsを使用することもできます：

1. https://github.com/coreybutler/nvm-windows/releases からインストーラーをダウンロード
2. インストール後、以下のコマンドでNode.jsをインストール：
   ```powershell
   nvm install lts
   nvm use lts
   ```

## 推奨バージョン

- **Node.js**: 18.x以上（LTS版推奨）
- **npm**: Node.jsと一緒にインストールされます（通常は8.x以上）

## 次のステップ

Node.jsのインストールが完了したら、`SETUP.md`の手順に従って、Supabaseの接続設定を進めてください。
