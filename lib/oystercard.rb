class Oystercard

  attr_reader :balance

  DEFAULT_MAX = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise "Unable to top up balance to above maximum amount" if @balance + amount > DEFAULT_MAX
    @balance += amount
  end

end
