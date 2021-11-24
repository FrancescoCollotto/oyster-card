# require_relative 'journey'

class Oyster
  LIMIT = 90
  MIN_BALANCE = 1
  attr_reader :balance
  attr_reader :entry_station
  attr_reader :journeys

  def initialize
    @balance = 0
    @journeys = []
    @current_journey = nil
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
    if !in_journey?
      @current_journey = Journey.new(station)
    else
      deduct(@current_journey.fare)
      @journeys << @current_journey
      @current_journey = Journey.new(station)
    end
  end

  def touch_out(station)
    if in_journey?
      @current_journey.exit_station=(station)
      deduct(@current_journey.fare)
      @journeys << @current_journey
      @current_journey = nil 
    else
      @current_journey = Journey.new(nil)
      @current_journey.exit_station=(station)
      deduct(@current_journey.fare)
      @journeys << @current_journey
      @current_journey = nil 
    end
  end

  def in_journey?
    !!@current_journey
  end
  
  private 

  def deduct(fare)
    @balance -= @current_journey.fare
  end

end
