require_relative 'journey'

class JourneyLog 

  def initialize(journey_class:) #check here
    @current_journey = journey_class
    # @current_journey = nil 

  end

  def start(station)
    if !in_journey?
      @current_journey = Journey.new(station)
    else
      deduct(@current_journey.fare)
      @journeys << @current_journey
      @current_journey = Journey.new(station)
    end
  end


  def in_journey?
    !!@current_journey
  end


end