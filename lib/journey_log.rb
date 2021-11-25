require_relative 'journey'

class JourneyLog 
  attr_reader :current_journey

  def initialize(journey_class:) 
    @journey_class = journey_class
    @journeys = []
    @current_journey = nil
  end

  def start(station)
    if !in_journey?
      set_new_journey(station)
    else
      @journeys << @current_journey
      set_new_journey(station)
    end
  end

  def end(station)
    if in_journey?
      @current_journey.exit_station=(station)
      amount = @current_journey.fare
      @journeys << @current_journey
      @current_journey = nil
      amount
    else
      @current_journey = @journey_class.new
      @current_journey.exit_station=(station)
      amount = current_journey.fare
      @journeys << @current_journey
      @current_journey = nil
      amount 
    end
  end

  def in_journey?
    !!@current_journey
  end

  def journeys
    @journeys.dup
  end

  private

  def set_new_journey(station)
    @current_journey = @journey_class.new
    @current_journey.entry_station=(station)
  end

end