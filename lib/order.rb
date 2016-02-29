class Order < Sequel::Model
  many_to_many :products
  many_to_one :coupon


  # set the order total before the discount is applied
  def set_total
    self.total = 0
    products.each do |p|
      self.total += p.price
    end
    self.save

  end

  # set the bigger discount over the order total
  def get_discount

    @coupon_discount = 0
    @progressive_discount = 0
    @progressive_amount = nil

    if self.total.nil?

      nil

    else

      @coupon_discount = coupon.discount(total) if coupon

      if self.products.count >= 2
        self.products.each_with_index do |p, index|
          if index == 1
            @progressive_amount = 10
          end

          if index.between?(2,7)
            @progressive_amount += 5
          end

        end
      end

      if @progressive_amount
        @progressive_discount = @progressive_amount * self.total / 100
      end

      self.total_with_discount = self.total - [@coupon_discount, @progressive_discount].max
      self.save

    end



  end


end