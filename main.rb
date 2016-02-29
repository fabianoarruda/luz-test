#!/usr/bin/env ruby
require 'csv'
require 'sequel'

require_relative 'lib/dataset'

unless ARGV.count == 5
  p "Wrong number of arguments. #{ARGV.count} of 5"
  p 'Usage: main.rb coupons_file products_file orders_file order_items_file totals_file'
  exit
end

DB = Dataset.load(ARGV)

require_relative 'lib/coupon'
require_relative 'lib/product'
require_relative 'lib/order'

output_file = ARGV[4]


CSV.open(output_file, 'wb') do |csv|
  Order.all.each do |o|
    o.set_total
    o.get_discount
    csv << [o.id , o.total_with_discount]
  end
end



