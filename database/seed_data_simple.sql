-- ダミーデータ作成用SQL（シンプル版）
-- 
-- 【使用方法】
-- 1. 以下のSQLの 'YOUR_USER_ID_HERE' を実際のユーザーID（UUID）に置き換えてください
-- 2. SupabaseのSQL Editorで実行してください
--
-- 既存のユーザーIDを確認する方法:
-- SELECT id, email FROM auth.users LIMIT 1;

-- 物件情報のダミーデータを10件挿入
-- 注意: 'YOUR_USER_ID_HERE' を実際のユーザーIDに置き換えてください
INSERT INTO properties (rent, management_fee, name, address, latitude, longitude, layout, area, building_age, owner_id) VALUES
-- 1. 東京都世田谷区（家賃85,000円）
(85000, 5000, '世田谷区の閑静なアパート', '東京都世田谷区三軒茶屋1-2-3', 35.6431, 139.6706, '1LDK', 32.5, 5, 'd2992b37-5186-4560-bb44-235ffca68f4a'::UUID),

-- 2. 東京都渋谷区（家賃120,000円）
(120000, 8000, '渋谷駅徒歩5分のマンション', '東京都渋谷区渋谷1-15-5', 35.6598, 139.7006, '2LDK', 45.0, 3, 'd2992b37-5186-4560-bb44-235ffca68f4a'::UUID),

-- 3. 東京都新宿区（家賃95,000円）
(95000, 6000, '新宿区の築浅物件', '東京都新宿区新宿3-1-1', 35.6909, 139.7003, '1K', 25.0, 1, 'd2992b37-5186-4560-bb44-235ffca68f4a'::UUID),

-- 4. 東京都港区（家賃150,000円）
(150000, 10000, '六本木の高級マンション', '東京都港区六本木3-2-1', 35.6627, 139.7314, '2LDK', 55.0, 8, 'd2992b37-5186-4560-bb44-235ffca68f4a'::UUID),

-- 5. 東京都目黒区（家賃70,000円）
(70000, 4000, '目黒区のリーズナブルな物件', '東京都目黒区目黒本町4-3-2', 35.6331, 139.6989, '1DK', 28.5, 12, 'd2992b37-5186-4560-bb44-235ffca68f4a'::UUID),

-- 6. 東京都品川区（家賃80,000円）
(80000, 5000, '品川駅近くのアパート', '東京都品川区大崎1-6-1', 35.6197, 139.7286, '1LDK', 30.0, 7, 'd2992b37-5186-4560-bb44-235ffca68f4a'::UUID),

-- 7. 東京都杉並区（家賃65,000円）
(65000, 3000, '杉並区の静かな住宅街', '東京都杉並区高円寺南2-4-5', 35.7034, 139.6503, '1K', 22.0, 15, 'd2992b37-5186-4560-bb44-235ffca68f4a'::UUID),

-- 8. 東京都練馬区（家賃90,000円）
(90000, 5500, '練馬区のファミリー向け物件', '東京都練馬区練馬1-2-3', 35.7359, 139.6517, '2DK', 38.0, 10, 'd2992b37-5186-4560-bb44-235ffca68f4a'::UUID),

-- 9. 東京都中野区（家賃75,000円）
(75000, 4500, '中野区の駅近物件', '東京都中野区中野2-1-1', 35.7056, 139.6658, '1LDK', 29.5, 6, 'd2992b37-5186-4560-bb44-235ffca68f4a'::UUID),

-- 10. 東京都文京区（家賃110,000円）
(110000, 7000, '文京区の大学近くの物件', '東京都文京区本郷3-1-1', 35.7074, 139.7618, '2LDK', 42.0, 4, 'd2992b37-5186-4560-bb44-235ffca68f4a'::UUID)
RETURNING id, name;

-- 上記のINSERT文を実行後、各物件に画像を追加します
-- 物件1（世田谷区）の画像
INSERT INTO property_images (property_id, image_url, display_order)
SELECT id, 'https://placehold.co/600x400', 1 FROM properties WHERE address = '東京都世田谷区三軒茶屋1-2-3';
INSERT INTO property_images (property_id, image_url, display_order)
SELECT id, 'https://placehold.co/600x400', 2 FROM properties WHERE address = '東京都世田谷区三軒茶屋1-2-3';

-- 物件2（渋谷区）の画像
INSERT INTO property_images (property_id, image_url, display_order)
SELECT id, 'https://placehold.co/600x400', 1 FROM properties WHERE address = '東京都渋谷区渋谷1-15-5';
INSERT INTO property_images (property_id, image_url, display_order)
SELECT id, 'https://placehold.co/600x400', 2 FROM properties WHERE address = '東京都渋谷区渋谷1-15-5';
INSERT INTO property_images (property_id, image_url, display_order)
SELECT id, 'https://placehold.co/600x400', 3 FROM properties WHERE address = '東京都渋谷区渋谷1-15-5';

-- 物件3（新宿区）の画像
INSERT INTO property_images (property_id, image_url, display_order)
SELECT id, 'https://placehold.co/600x400', 1 FROM properties WHERE address = '東京都新宿区新宿3-1-1';
INSERT INTO property_images (property_id, image_url, display_order)
SELECT id, 'https://placehold.co/600x400', 2 FROM properties WHERE address = '東京都新宿区新宿3-1-1';

-- 物件4（港区）の画像
INSERT INTO property_images (property_id, image_url, display_order)
SELECT id, 'https://placehold.co/600x400', 1 FROM properties WHERE address = '東京都港区六本木3-2-1';
INSERT INTO property_images (property_id, image_url, display_order)
SELECT id, 'https://placehold.co/600x400', 2 FROM properties WHERE address = '東京都港区六本木3-2-1';
INSERT INTO property_images (property_id, image_url, display_order)
SELECT id, 'https://placehold.co/600x400', 3 FROM properties WHERE address = '東京都港区六本木3-2-1';

-- 物件5（目黒区）の画像
INSERT INTO property_images (property_id, image_url, display_order)
SELECT id, 'https://placehold.co/600x400', 1 FROM properties WHERE address = '東京都目黒区目黒本町4-3-2';
INSERT INTO property_images (property_id, image_url, display_order)
SELECT id, 'https://placehold.co/600x400', 2 FROM properties WHERE address = '東京都目黒区目黒本町4-3-2';

-- 物件6（品川区）の画像
INSERT INTO property_images (property_id, image_url, display_order)
SELECT id, 'https://placehold.co/600x400', 1 FROM properties WHERE address = '東京都品川区大崎1-6-1';
INSERT INTO property_images (property_id, image_url, display_order)
SELECT id, 'https://placehold.co/600x400', 2 FROM properties WHERE address = '東京都品川区大崎1-6-1';

-- 物件7（杉並区）の画像
INSERT INTO property_images (property_id, image_url, display_order)
SELECT id, 'https://placehold.co/600x400', 1 FROM properties WHERE address = '東京都杉並区高円寺南2-4-5';
INSERT INTO property_images (property_id, image_url, display_order)
SELECT id, 'https://placehold.co/600x400', 2 FROM properties WHERE address = '東京都杉並区高円寺南2-4-5';

-- 物件8（練馬区）の画像
INSERT INTO property_images (property_id, image_url, display_order)
SELECT id, 'https://placehold.co/600x400', 1 FROM properties WHERE address = '東京都練馬区練馬1-2-3';
INSERT INTO property_images (property_id, image_url, display_order)
SELECT id, 'https://placehold.co/600x400', 2 FROM properties WHERE address = '東京都練馬区練馬1-2-3';
INSERT INTO property_images (property_id, image_url, display_order)
SELECT id, 'https://placehold.co/600x400', 3 FROM properties WHERE address = '東京都練馬区練馬1-2-3';

-- 物件9（中野区）の画像
INSERT INTO property_images (property_id, image_url, display_order)
SELECT id, 'https://placehold.co/600x400', 1 FROM properties WHERE address = '東京都中野区中野2-1-1';
INSERT INTO property_images (property_id, image_url, display_order)
SELECT id, 'https://placehold.co/600x400', 2 FROM properties WHERE address = '東京都中野区中野2-1-1';

-- 物件10（文京区）の画像
INSERT INTO property_images (property_id, image_url, display_order)
SELECT id, 'https://placehold.co/600x400', 1 FROM properties WHERE address = '東京都文京区本郷3-1-1';
INSERT INTO property_images (property_id, image_url, display_order)
SELECT id, 'https://placehold.co/600x400', 2 FROM properties WHERE address = '東京都文京区本郷3-1-1';
INSERT INTO property_images (property_id, image_url, display_order)
SELECT id, 'https://placehold.co/600x400', 3 FROM properties WHERE address = '東京都文京区本郷3-1-1';
