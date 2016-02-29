require 'sequel'

module DbSetup
  DB= Sequel.sqlite

  DB.create_table :coupons do
    primary_key :id
    Float :amount
    String :type
    Date :exp_date
    Integer :quantity
  end

  DB.create_table :products do
    primary_key :id
    Float :price
  end

  DB.create_table :orders do
    primary_key :id
    Integer :coupon_id
    Float :total
    Float :total_with_discount
  end

  DB.create_table :orders_products do
    Integer :order_id
    Integer :product_id
  end


end

RSpec.configure do |config|
  config.include DbSetup
end
