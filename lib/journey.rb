require_relative ('station')

class Journey
  attr_reader :entry_station, :exit_station, :cost_journey

  PEN_FARE = 6

  def initialize(entry_station = "no touch in")
    @entry_station = entry_station
    @exit_station = "no touch out"
  end

  def record_exit(exit_station)
      @exit_station = exit_station
  end

  def fare
    zones_travelled + 1
  end

  def incomplete?
    @exit_station == "no touch out" || @entry_station == "no touch in"
  end

   def cost_journey
    @cost_journey = incomplete? ? PEN_FARE : fare
   end

  def zones_travelled
    (entry_station.zone - exit_station.zone).abs
  end

end
