require_relative './journey_log'
require_relative './journey'

class Oyster
  LIMIT = 90
  MIN_BALANCE = 1
  attr_reader :balance
  attr_reader :entry_station

  def initialize
    @balance = 0
    @journey_log = JourneyLog.new(journey_class: Journey)
  end

  def exceed_limit?(amount)
    @balance + amount > LIMIT
  end

  def enough_balance?
    @balance >= MIN_BALANCE
  end

  def top_up(amount)
    raise "This top up would exceed your £#{LIMIT} card limit." if exceed_limit?(amount)
    @balance += amount
  end

  def touch_in(station)
    raise "You have less than the £#{MIN_BALANCE} minimum balance, please top up." unless enough_balance?
    deduct(@journey_log.current_journey.fare) if @journey_log.in_journey?
    @journey_log.start(station)
  end

  def touch_out(station)
    deduct(@journey_log.end(station))
  end

  def list_journeys
    @journey_log.journeys
  end
  
  private 

  def deduct(fare)
    @balance -= fare
  end

end
