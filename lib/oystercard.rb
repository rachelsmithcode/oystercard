
require './lib/journey_log.rb'

class Oystercard

  attr_reader :balance, :entry_station, :journey_complete, :journey_klass

  MAX_LIMIT = 90
  DEFAULT_MIN = 1
  PEN_FARE = 6
  #STANDARD_FARE = 1

  def initialize(journey_log = JourneyLog.new)
    @balance = 0
    @journey_log = journey_log
  end

  def top_up(amount)
    raise "Unable to top up balance to above #{MAX_LIMIT} amount" if @balance + amount > MAX_LIMIT
    @balance += amount
  end

  def show_journeys
    @journey_log.journey_hist
  end

  def touch_in(station)
    raise "Balance under #{DEFAULT_MIN}" if @balance < DEFAULT_MIN
    deduct(PEN_FARE)
    @journey_log.start_journey(station)
  end

  def touch_out(station)
    if @journey_log.current_journey
      @journey_log.end_journey(station)
      reimburse unless @journey_log.incomplete_journey?
      @journey_log.reset
    else
      @journey_log.start_journey("no touch in")
      @journey_log.end_journey(station)
      @journey_log.reset
      deduct(PEN_FARE)
    end
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def reimburse
    amount = PEN_FARE - @journey_log.outstanding_charges
    @balance += amount
  end

end
