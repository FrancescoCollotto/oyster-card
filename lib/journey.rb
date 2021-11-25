
class Journey
  PENALTY_FARE = 6
  FARE = 1
  attr_reader :entry_station, :exit_station

  def initialize
    @entry_station = nil
    @exit_station = nil 
   end

  def entry_station=(station)
    @entry_station = station
  end
  
  def exit_station=(station)
    @exit_station = station
  end
  
  def completed
    return false unless @entry_station && @exit_station
    true
  end

  def fare
    return FARE unless !@entry_station || !@exit_station
    PENALTY_FARE
  end

end


