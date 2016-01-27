require_relative 'station'
require_relative 'journey'

class Oystercard

  attr_reader :balance, :entry_station, :journey_hist, :journey_complete, :current_journey, :journey_class

  DEFAULT_MAX = 90
  DEFAULT_MIN = 1

  def initialize(journey_klass = Journey)
    @balance = 0
    @journey_klass = journey_klass
    @journey_hist = []

  end

  def top_up(amount)
    raise "Unable to top up balance to above #{DEFAULT_MAX} amount" if @balance + amount > DEFAULT_MAX
    @balance += amount
  end

  def touch_in(station)
    raise "Balance under #{DEFAULT_MIN}" if @balance < DEFAULT_MIN
    @current_journey = @journey_klass.new(station)

  end

  def touch_out(station)
    deduct(DEFAULT_MIN)
    @current_journey.end_journey(station)
    journey_complete(station)
  end

  # def in_journey?
  #   @entry_station
  # end

  private

  def deduct(amount)
    @balance -= amount
  end

  def journey_complete(exit_station)
    journey = { @entry_station => exit_station }
    @journey_hist << journey
  end

end
