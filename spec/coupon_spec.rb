require 'rspec'
require_relative '../lib/coupon'

describe Coupon do
  describe '#discount' do

    let(:total) {200}
    let(:discount) {15}
    let(:today) {Date.today}

    context 'given coupon quantity is 0' do
      it 'should return 0' do
        coupon = Coupon.new(:amount => discount, :type => 'absolute', :quantity => 0)
        expect(coupon.discount(total)).to eql 0
      end
    end

    context 'given coupon quantity is 1 or more' do
      context 'given exp_date is 1 day in the future' do
        context 'given type is absolute' do
          it 'should return 15.0' do
            coupon = Coupon.new(:amount => discount, :type => 'absolute', :quantity => 1, :exp_date => (today + 1))
            expect(coupon.discount(total)).to eql 15.0
          end
          context 'given type is percent' do
            it 'should return 30.0' do
              coupon = Coupon.new(:amount => 15, :type => 'percent', :quantity => 1, :exp_date => (today + 1))
              expect(coupon.discount(total)).to eql 30.0
            end

          end
        end

      end

      context 'given exp_date is 1 day ago' do
        it 'should return 0' do
          coupon = Coupon.new(:amount => discount, :type => 'absolute', :quantity => 1, :exp_date => (today - 1))
          expect(coupon.discount(total)).to eql 0
        end
      end

    end

  end

end