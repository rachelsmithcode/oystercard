class Oystercard

  attr_reader :balance, :in_use

  DEFAULT_MAX = 90
  DEFAULT_MIN = 1

  def initialize
    @balance = 0
    @in_use = false
  end

  def top_up(amount)
    raise "Unable to top up balance to above #{DEFAULT_MAX} amount" if @balance + amount > DEFAULT_MAX
    @balance += amount
  end

  def touch_in
    raise "Balance under #{DEFAULT_MIN}" if @balance < DEFAULT_MIN
    @in_use = true
  end

  def touch_out
    deduct(1)
    @in_use = false
  end

  def in_journey?
    @in_use
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
