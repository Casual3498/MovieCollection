module Cashbox

  def cash
    return @money
  end

  def pay(amount)
    @money += amount
  end


end