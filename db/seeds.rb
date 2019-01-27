# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# -*- coding: utf-8 -*-

require 'csv'

CSV.foreach('db/category.csv', headers: true) do |row|
  cate = Category.new(name: row[0], ancestry: row[1])
  cate.save(validate: false)
end
