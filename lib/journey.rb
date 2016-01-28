
class Journey
  attr_reader :entry_station, :exit_station, :journey_cost

  PEN_FARE = 6
  STANDARD_FARE = 1

  def initialize(entry_station = "no touch in")
    @journey_cost = 0
    @complete_journey = false
    @entry_station = entry_station
    @exit_station = "no touch_out"
  end

  def record_exit(exit_station)
      @complete_journey = true
      @exit_station = exit_station
      self
  end

  def fare
    @complete_journey ? @journey_cost = PEN_FARE : @journey_cost = STANDARD_FARE
  end

  def complete_journey?
    @complete_journey
  end

  def fininsh_journey
    @complete_journey = true
  end

end
