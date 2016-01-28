
class Journey
  attr_reader :entry_station, :exit_station, :journey_cost

  PEN_FARE = 6
  STANDARD_FARE = 1

  def initialize(entry_station = "no touch in")
    #@journey_cost = 0
    @entry_station = entry_station
    @exit_station = "no touch out"
  end

  def record_exit(exit_station)
      @exit_station = exit_station
  end

  def fare
    @complete_journey ? @journey_cost = PEN_FARE : @journey_cost = STANDARD_FARE
  end

  def incomplete?
    #@complete_journey = true if
    @exit_station == "no touch out" || @entry_station == "no touch in"
  end
  #
  # def fininsh_journey
  #   @complete_journey = true
  # end

end
