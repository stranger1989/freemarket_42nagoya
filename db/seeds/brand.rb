require 'csv'

CSV.foreach('db/brand.csv', headers: true) do |row|
  brand = Brand.new(name: row[0])
  brand.save(validate: false)
end
