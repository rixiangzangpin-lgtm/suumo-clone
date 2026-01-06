-- ダミーデータ作成用SQL
-- 注意: 実行前に、auth.usersテーブルにテストユーザーが存在することを確認してください
-- 存在しない場合は、以下のコマンドでSupabaseの認証からユーザーを作成するか、
-- 既存のユーザーIDを使用してください

-- テスト用のowner_idを設定（実際のユーザーIDに置き換えてください）
-- この例では、仮のUUIDを使用していますが、実際には既存のユーザーIDを使用してください
DO $$
DECLARE
    test_owner_id UUID;
BEGIN
    -- 既存のユーザーIDを取得（存在する場合）
    SELECT id INTO test_owner_id FROM auth.users LIMIT 1;
    
    -- ユーザーが存在しない場合は、以下のUUIDを使用（実際の環境に合わせて変更してください）
    IF test_owner_id IS NULL THEN
        test_owner_id := '00000000-0000-0000-0000-000000000001'::UUID;
    END IF;

    -- 物件情報のダミーデータを10件挿入
    INSERT INTO properties (rent, management_fee, name, address, latitude, longitude, layout, area, building_age, owner_id) VALUES
    -- 1. 東京都世田谷区
    (85000, 5000, '世田谷区の閑静なアパート', '東京都世田谷区三軒茶屋1-2-3', 35.6431, 139.6706, '1LDK', 32.5, 5, test_owner_id),
    
    -- 2. 東京都渋谷区
    (120000, 8000, '渋谷駅徒歩5分のマンション', '東京都渋谷区渋谷1-15-5', 35.6598, 139.7006, '2LDK', 45.0, 3, test_owner_id),
    
    -- 3. 東京都新宿区
    (95000, 6000, '新宿区の築浅物件', '東京都新宿区新宿3-1-1', 35.6909, 139.7003, '1K', 25.0, 1, test_owner_id),
    
    -- 4. 東京都港区
    (150000, 10000, '六本木の高級マンション', '東京都港区六本木3-2-1', 35.6627, 139.7314, '2LDK', 55.0, 8, test_owner_id),
    
    -- 5. 東京都目黒区
    (70000, 4000, '目黒区のリーズナブルな物件', '東京都目黒区目黒本町4-3-2', 35.6331, 139.6989, '1DK', 28.5, 12, test_owner_id),
    
    -- 6. 東京都品川区
    (80000, 5000, '品川駅近くのアパート', '東京都品川区大崎1-6-1', 35.6197, 139.7286, '1LDK', 30.0, 7, test_owner_id),
    
    -- 7. 東京都杉並区
    (65000, 3000, '杉並区の静かな住宅街', '東京都杉並区高円寺南2-4-5', 35.7034, 139.6503, '1K', 22.0, 15, test_owner_id),
    
    -- 8. 東京都練馬区
    (90000, 5500, '練馬区のファミリー向け物件', '東京都練馬区練馬1-2-3', 35.7359, 139.6517, '2DK', 38.0, 10, test_owner_id),
    
    -- 9. 東京都中野区
    (75000, 4500, '中野区の駅近物件', '東京都中野区中野2-1-1', 35.7056, 139.6658, '1LDK', 29.5, 6, test_owner_id),
    
    -- 10. 東京都文京区
    (110000, 7000, '文京区の大学近くの物件', '東京都文京区本郷3-1-1', 35.7074, 139.7618, '2LDK', 42.0, 4, test_owner_id);

    -- 各物件に画像を2〜3枚ずつ追加
    -- 物件1（世田谷区）
    INSERT INTO property_images (property_id, image_url, display_order) 
    SELECT id, 'https://placehold.co/600x400', 1 FROM properties WHERE address = '東京都世田谷区三軒茶屋1-2-3';
    INSERT INTO property_images (property_id, image_url, display_order) 
    SELECT id, 'https://placehold.co/600x400', 2 FROM properties WHERE address = '東京都世田谷区三軒茶屋1-2-3';
    
    -- 物件2（渋谷区）
    INSERT INTO property_images (property_id, image_url, display_order) 
    SELECT id, 'https://placehold.co/600x400', 1 FROM properties WHERE address = '東京都渋谷区渋谷1-15-5';
    INSERT INTO property_images (property_id, image_url, display_order) 
    SELECT id, 'https://placehold.co/600x400', 2 FROM properties WHERE address = '東京都渋谷区渋谷1-15-5';
    INSERT INTO property_images (property_id, image_url, display_order) 
    SELECT id, 'https://placehold.co/600x400', 3 FROM properties WHERE address = '東京都渋谷区渋谷1-15-5';
    
    -- 物件3（新宿区）
    INSERT INTO property_images (property_id, image_url, display_order) 
    SELECT id, 'https://placehold.co/600x400', 1 FROM properties WHERE address = '東京都新宿区新宿3-1-1';
    INSERT INTO property_images (property_id, image_url, display_order) 
    SELECT id, 'https://placehold.co/600x400', 2 FROM properties WHERE address = '東京都新宿区新宿3-1-1';
    
    -- 物件4（港区）
    INSERT INTO property_images (property_id, image_url, display_order) 
    SELECT id, 'https://placehold.co/600x400', 1 FROM properties WHERE address = '東京都港区六本木3-2-1';
    INSERT INTO property_images (property_id, image_url, display_order) 
    SELECT id, 'https://placehold.co/600x400', 2 FROM properties WHERE address = '東京都港区六本木3-2-1';
    INSERT INTO property_images (property_id, image_url, display_order) 
    SELECT id, 'https://placehold.co/600x400', 3 FROM properties WHERE address = '東京都港区六本木3-2-1';
    
    -- 物件5（目黒区）
    INSERT INTO property_images (property_id, image_url, display_order) 
    SELECT id, 'https://placehold.co/600x400', 1 FROM properties WHERE address = '東京都目黒区目黒本町4-3-2';
    INSERT INTO property_images (property_id, image_url, display_order) 
    SELECT id, 'https://placehold.co/600x400', 2 FROM properties WHERE address = '東京都目黒区目黒本町4-3-2';
    
    -- 物件6（品川区）
    INSERT INTO property_images (property_id, image_url, display_order) 
    SELECT id, 'https://placehold.co/600x400', 1 FROM properties WHERE address = '東京都品川区大崎1-6-1';
    INSERT INTO property_images (property_id, image_url, display_order) 
    SELECT id, 'https://placehold.co/600x400', 2 FROM properties WHERE address = '東京都品川区大崎1-6-1';
    
    -- 物件7（杉並区）
    INSERT INTO property_images (property_id, image_url, display_order) 
    SELECT id, 'https://placehold.co/600x400', 1 FROM properties WHERE address = '東京都杉並区高円寺南2-4-5';
    INSERT INTO property_images (property_id, image_url, display_order) 
    SELECT id, 'https://placehold.co/600x400', 2 FROM properties WHERE address = '東京都杉並区高円寺南2-4-5';
    
    -- 物件8（練馬区）
    INSERT INTO property_images (property_id, image_url, display_order) 
    SELECT id, 'https://placehold.co/600x400', 1 FROM properties WHERE address = '東京都練馬区練馬1-2-3';
    INSERT INTO property_images (property_id, image_url, display_order) 
    SELECT id, 'https://placehold.co/600x400', 2 FROM properties WHERE address = '東京都練馬区練馬1-2-3';
    INSERT INTO property_images (property_id, image_url, display_order) 
    SELECT id, 'https://placehold.co/600x400', 3 FROM properties WHERE address = '東京都練馬区練馬1-2-3';
    
    -- 物件9（中野区）
    INSERT INTO property_images (property_id, image_url, display_order) 
    SELECT id, 'https://placehold.co/600x400', 1 FROM properties WHERE address = '東京都中野区中野2-1-1';
    INSERT INTO property_images (property_id, image_url, display_order) 
    SELECT id, 'https://placehold.co/600x400', 2 FROM properties WHERE address = '東京都中野区中野2-1-1';
    
    -- 物件10（文京区）
    INSERT INTO property_images (property_id, image_url, display_order) 
    SELECT id, 'https://placehold.co/600x400', 1 FROM properties WHERE address = '東京都文京区本郷3-1-1';
    INSERT INTO property_images (property_id, image_url, display_order) 
    SELECT id, 'https://placehold.co/600x400', 2 FROM properties WHERE address = '東京都文京区本郷3-1-1';
    INSERT INTO property_images (property_id, image_url, display_order) 
    SELECT id, 'https://placehold.co/600x400', 3 FROM properties WHERE address = '東京都文京区本郷3-1-1';

END $$;
