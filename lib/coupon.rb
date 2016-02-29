class Coupon < Sequel::Model

  # get the discount provided by a coupon over a given total
  def discount(value)

    if self.quantity > 0 && self.exp_date >= Date.today

      case self.type
        when 'absolute'
          self.quantity -= 1
          self.save
          self.amount

        when 'percent'
          self.quantity -= 1
          self.save
          self.amount * value / 100

        else
          false
      end
    else
      0
    end

  end

end

