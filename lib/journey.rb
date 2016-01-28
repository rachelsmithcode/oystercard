require_relative ('station')

class Journey
  attr_reader :entry_station, :exit_station, :journey_cost

  PEN_FARE = 6
  #STANDARD_FARE = 1

  def initialize(entry_station = "no touch in")
    @entry_station = entry_station
    @exit_station = "no touch out"
  end

  def record_exit(exit_station)
      @exit_station = exit_station
  end

  def fare
    zones_travelled + 1
    #@journey_cost = STANDARD_FARE
  end

  def incomplete?
    #@complete_journey = true if
    @exit_station == "no touch out" || @entry_station == "no touch in"
  end
  #
  # def fininsh_journey
  #   @complete_journey = true
  # end

  def zones_travelled
    (entry_station.zone - exit_station.zone).abs
  end

end
