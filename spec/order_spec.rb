require 'rspec'
require_relative '../lib/order'
require_relative '../lib/product'

describe Order do

  let(:order) {Order.new}

  # set order total before any discount is applied
  describe '#set_total' do
    context 'when order has no products' do
      it 'total should be 0.0' do

        order.set_total
        expect(order.total).to eq 0.0
      end
    end
    context 'when order has products' do
      it 'total should be 2500.0' do

        product1 = Product.new(:price => 2400.0)
        product2 = Product.new(:price => 100.0)

        order.products << product1
        order.products << product2

        order.set_total
        expect(order.total).to eq 2500.0

      end
    end
  end

  #get the discount over order total
  describe '#get_discount' do
    context 'when total has not been set' do
      it 'should return nil' do
        expect(order.get_discount).to be_nil
      end
    end
    context 'when order has a coupon' do
      context 'when coupon discount is bigger' do
        it 'total_with_discount should be 70.0' do
          coupon = Coupon.new(:amount => 50, :type => 'percent', :quantity => 1, :exp_date => (Date.today + 1))
          coupon.save
          order.coupon = coupon

          product1 = Product.new(:price => 100.0)
          product2 = Product.new(:price => 40.0)

          order.products << product1
          order.products << product2

          order.set_total
          order.get_discount
          expect(order.total_with_discount).to eq 70.0

        end
      end

      context 'when cumulative discount is bigger' do
        it 'total_with_discount should be 152.0' do

          coupon = Coupon.new(:amount => 10, :type => 'percent', :quantity => 1, :exp_date => (Date.today + 1))
          coupon.save
          order.coupon = coupon

          product1 = Product.new(:price => 100.0)
          product2 = Product.new(:price => 40.0)
          product3 = Product.new(:price => 30.0)
          product4 = Product.new(:price => 20.0)

          order.products << product1
          order.products << product2
          order.products << product3
          order.products << product4

          order.set_total
          order.get_discount
          expect(order.total_with_discount).to eql 152.0

        end
      end

    end

  end
end
