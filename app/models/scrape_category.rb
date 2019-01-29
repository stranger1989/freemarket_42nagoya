require 'nokogiri'

#URLに接続するためのライブラリ
require "open-uri"

require 'csv'


#スクレイピング対象のURL
url = "https://www.mercari.com/jp/category/"

#取得するhtml用charset
charset = nil

# User-Agentの設定
opt = {}
opt['User-Agent'] = 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; Googlebot/2.1; +http://www.google.com/bot.html) Safari/537.36'

html = open(url, opt) do |page|
  #charsetを取得
  charset = page.charset
  #htmlの読み込み
  page.read
end

# Nokogiriでhtmlをパースして切り分ける
category = Nokogiri::HTML.parse(html, nil, charset)

array = []

# rootカテゴリ名の抽出
category.css('.category-root-category-link-name').each do |root|
  root_category = root.css('div').inner_text
  array << [root_category]
end

# childカテゴリ名の抽出
category.css('.category-list-individual-box-sub-category-name').each do |child|
  child_category = child.css('h4').inner_text
  array << [child_category]
end

# grand_childカテゴリ名の抽出
category.css('.search-category-subparent > li > a').each do |grand_child|
  grand_child_category = grand_child.css('.search-category-subchild').inner_text
  array << [grand_child_category]
end

csv_header = ['name', 'ancestry']

CSV.open("category.csv", "w") do |csv|
  # csvへの書き込み
  csv << csv_header
  array.each do |row|
    csv << row
  end
end
