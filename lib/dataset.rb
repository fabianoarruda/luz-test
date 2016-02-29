require 'csv'
require 'sequel'
require 'date'

class Dataset

  def self.load(args)

    coupons_file = args[0]
    products_file = args[1]
    orders_file = args[2]
    order_items_file = args[3]

    db = Sequel.sqlite

    # load coupons

    db.create_table :coupons do
      primary_key :id
      Float :amount
      String :type
      Date :exp_date
      Integer :quantity
    end

    coupons = db[:coupons]

    CSV.foreach(coupons_file) do |row|
      coupons.insert(:id => row[0], :amount => row[1], :type => row[2], :exp_date => Date.strptime(row[3], '%Y/%m/%d'), :quantity => row[4])
    end


    # load products

    db.create_table :products do
      primary_key :id
      Float :price
    end

    products = db[:products]

    CSV.foreach(products_file) do |row|
      unless row[0].nil?
        products.insert(:id => row[0], :price => row[1])
      end

    end

    #load orders

    db.create_table :orders do
      primary_key :id
      Integer :coupon_id
      Float :total
      Float :total_with_discount
    end

    orders = db[:orders]

    CSV.foreach(orders_file) do |row|
      orders.insert(:id => row[0], :coupon_id => row[1])
    end

    #load order items

    db.create_table :orders_products do
      Integer :order_id
      Integer :product_id
    end

    orders_products = db[:orders_products]

    CSV.foreach(order_items_file) do |row|
      orders_products.insert(:order_id => row[0], :product_id => row[1])
    end

  db

  end

end