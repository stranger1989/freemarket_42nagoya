require 'csv'

CSV.foreach('db/brand.csv', headers: true) do |row|
  cate = Brand.new(name: row[0])
  cate.save(validate: false)
end
