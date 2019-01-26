# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# coding: utf-8

# rootカテゴリー
ladies, mens, baby_kids, interior, book_music_game, hobby, cosmetics, consumer_electronics, sports, handmade, ticket, car_mortercycle, other = Category.create([{name: "レディース"}, {name: "メンズ"}, {name: "ベビー・キッズ"},{name: "インテリア・住まい・小物"}, {name: "本・音楽・ゲーム"}, {name: "おもちゃ・ホビー・グッズ"}, {name: "コスメ・香水・美容"}, {name: "家電・スマホ・カメラ"}, {name: "スポーツ・レジャー"}, {name: "ハンドメイド"}, {name: "チケット"}, {name: "自動車・オートバイ"}, {name: "その他"}])

# ladiesカテゴリー
tops, outer, pants, skirt, onepiece, shoes, room_wear, leg_wear, cap, bag, accessary, hair_accessary, komono, clock, wig, yukata, suit_dress, maternity, other = ladies.children.create([{name: "トップス"}, {name: "ジャケット/アウター"}, {name: "パンツ"}, {name: "スカート"}, {name: "ワンピース"}, {name: "靴"}, {name: "ルームシェア/パジャマ"}, {name: "レッグウェア"}, {name: "帽子"}, {name: "バッグ"}, {name: "アクセサリー"}, {name: "ヘアアクセサリー"}, {name: "小物"}, {name: "時計"}, {name: "ウィッグ/エクステ"}, {name: "浴衣/水着"}, {name: "スーツ/フォーマル/ドレス"}, {name: "マタニティ"}, {name: "その他"}])

# ladies-topsカテゴリー
 short_tshirt, long_tshirt, short_shirt, long_shirt, polo, camisole, tanktop, halter_neck, knit, tunic, cardigan, ensemble, best, parker, trainer, pair_top, jersey, other = tops.children.create([{name: "Tシャツ/カットソー(半袖/袖なし)"}, {name: "Tシャツ/カットソー(七分/長袖)"}, {name: "シャツ/ブラウス(半袖/袖なし)"}, {name: "シャツ/ブラウス(七分/長袖)"}, {name: "ポロシャツ"}, {name: "キャミソール"}, {name: "タンクトップ"}, {name: "ホルターネック"}, {name: "ニット/セーター"}, {name: "チュニック"}, {name: "カーディガン/ボレロ"}, {name: "アンサンブル"}, {name: "ベスト/ジレ"}, {name: "パーカー"}, {name: "トレーナー/スウェット"}, {name: "ペアトップ/チューブトップ"}, {name: "ジャージ"}, {name: "その他"}])
