class Oystercard

  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise "Unable to top up balance to above maximum amount" if @balance + amount > 90
    @balance += amount
  end

end
