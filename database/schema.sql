-- 物件情報テーブル
CREATE TABLE IF NOT EXISTS properties (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    rent INTEGER NOT NULL,
    management_fee INTEGER DEFAULT 0,
    name TEXT NOT NULL,
    address TEXT NOT NULL,
    latitude DOUBLE PRECISION NOT NULL,
    longitude DOUBLE PRECISION NOT NULL,
    layout TEXT NOT NULL,
    area NUMERIC(6, 2) NOT NULL,
    building_age INTEGER NOT NULL,
    owner_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- カラムのコメント
COMMENT ON TABLE properties IS '物件情報テーブル';
COMMENT ON COLUMN properties.rent IS '家賃（円）';
COMMENT ON COLUMN properties.management_fee IS '管理費（円）';
COMMENT ON COLUMN properties.name IS '物件名';
COMMENT ON COLUMN properties.address IS '住所';
COMMENT ON COLUMN properties.latitude IS '緯度';
COMMENT ON COLUMN properties.longitude IS '経度';
COMMENT ON COLUMN properties.layout IS '間取り（1K, 2LDKなど）';
COMMENT ON COLUMN properties.area IS '広さ（平米数）';
COMMENT ON COLUMN properties.building_age IS '築年数';
COMMENT ON COLUMN properties.owner_id IS '大家さん（登録者）のID';

-- 物件画像テーブル（1つの物件に複数の画像を保存）
CREATE TABLE IF NOT EXISTS property_images (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    property_id UUID NOT NULL REFERENCES properties(id) ON DELETE CASCADE,
    image_url TEXT NOT NULL,
    display_order INTEGER DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- カラムのコメント
COMMENT ON TABLE property_images IS '物件画像テーブル';
COMMENT ON COLUMN property_images.image_url IS '画像URL';
COMMENT ON COLUMN property_images.display_order IS '表示順序';

-- お気に入りテーブル
CREATE TABLE IF NOT EXISTS favorites (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    property_id UUID NOT NULL REFERENCES properties(id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(user_id, property_id) -- 同じユーザーが同じ物件を重複してお気に入りできないように
);

-- カラムのコメント
COMMENT ON TABLE favorites IS 'お気に入りテーブル';

-- インデックスの作成（検索パフォーマンス向上のため）
CREATE INDEX IF NOT EXISTS idx_properties_owner_id ON properties(owner_id);
CREATE INDEX IF NOT EXISTS idx_properties_location ON properties(latitude, longitude);
CREATE INDEX IF NOT EXISTS idx_properties_rent ON properties(rent);
CREATE INDEX IF NOT EXISTS idx_property_images_property_id ON property_images(property_id);
CREATE INDEX IF NOT EXISTS idx_favorites_user_id ON favorites(user_id);
CREATE INDEX IF NOT EXISTS idx_favorites_property_id ON favorites(property_id);

-- updated_atを自動更新するトリガー関数
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- propertiesテーブルのupdated_atを自動更新するトリガー
CREATE TRIGGER update_properties_updated_at
    BEFORE UPDATE ON properties
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- Row Level Security (RLS) の有効化
ALTER TABLE properties ENABLE ROW LEVEL SECURITY;
ALTER TABLE property_images ENABLE ROW LEVEL SECURITY;
ALTER TABLE favorites ENABLE ROW LEVEL SECURITY;

-- RLSポリシーの設定
-- 物件情報は全員が閲覧可能
CREATE POLICY "Properties are viewable by everyone"
    ON properties FOR SELECT
    USING (true);

-- 物件情報は認証済みユーザーが作成可能
CREATE POLICY "Properties are insertable by authenticated users"
    ON properties FOR INSERT
    WITH CHECK (auth.role() = 'authenticated');

-- 物件情報は所有者のみ更新可能
CREATE POLICY "Properties are updatable by owner"
    ON properties FOR UPDATE
    USING (auth.uid() = owner_id);

-- 物件情報は所有者のみ削除可能
CREATE POLICY "Properties are deletable by owner"
    ON properties FOR DELETE
    USING (auth.uid() = owner_id);

-- 物件画像は全員が閲覧可能
CREATE POLICY "Property images are viewable by everyone"
    ON property_images FOR SELECT
    USING (true);

-- 物件画像は認証済みユーザーが作成可能
CREATE POLICY "Property images are insertable by authenticated users"
    ON property_images FOR INSERT
    WITH CHECK (auth.role() = 'authenticated');

-- 物件画像は物件所有者のみ更新・削除可能
CREATE POLICY "Property images are updatable by property owner"
    ON property_images FOR UPDATE
    USING (
        EXISTS (
            SELECT 1 FROM properties
            WHERE properties.id = property_images.property_id
            AND properties.owner_id = auth.uid()
        )
    );

CREATE POLICY "Property images are deletable by property owner"
    ON property_images FOR DELETE
    USING (
        EXISTS (
            SELECT 1 FROM properties
            WHERE properties.id = property_images.property_id
            AND properties.owner_id = auth.uid()
        )
    );

-- お気に入りは全員が閲覧可能（自分のお気に入りのみ）
CREATE POLICY "Favorites are viewable by owner"
    ON favorites FOR SELECT
    USING (auth.uid() = user_id);

-- お気に入りは認証済みユーザーが作成可能
CREATE POLICY "Favorites are insertable by authenticated users"
    ON favorites FOR INSERT
    WITH CHECK (auth.uid() = user_id);

-- お気に入りは所有者のみ削除可能
CREATE POLICY "Favorites are deletable by owner"
    ON favorites FOR DELETE
    USING (auth.uid() = user_id);
