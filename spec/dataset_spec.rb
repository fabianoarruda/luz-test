require 'rspec'
require_relative '../lib/dataset'

describe Dataset do
  describe '#load' do
    context 'when loading files' do
      it 'should find coupons file' do
        expect(File).to exist('coupons.csv')
      end

      it 'should find products file' do
        expect(File).to exist('products.csv')
      end

      it 'should find orders file' do
        expect(File).to exist('orders.csv')
      end

      it 'should find order_items file' do
        expect(File).to exist('order_items.csv')
      end

    end

  end
end