require 'journey'
require 'oyster'

describe Oyster do
  let(:card) { described_class.new }
  let(:station) { double('station') }
  let(:station_b) { double('station_b') }

  it "return a default balance of 0" do
    expect(card.balance).to eq 0
  end

  it "allows user to top up card" do
    expect(card).to respond_to(:top_up).with(1).argument
  end

  it "balance increases by a specified amount when user tops up" do
    expect{ card.top_up 1 }.to change{ card.balance }.by 1
  end

  it "does not allow user to top  up card beyond maximum balance" do
    expect{ card.top_up(Oyster::LIMIT + 1) }.to raise_error "This top up would exceed your £#{Oyster::LIMIT} card limit."
  end

  # it "set in_use to be false when touch out" do
  #   card.top_up(Oyster::MIN_BALANCE)
  #   card.touch_in(station)
  #   card.touch_out(station_b)
  #   expect(card).not_to be_in_journey
  # end
  it "in_journey return true when touch in" do
    card.top_up(Oyster::MIN_BALANCE)
    card.touch_in(station)
    expect(card.in_journey?).to eq true
  end

  it "in_journey return false when touch_in and touch_out" do
    card.top_up(Oyster::MIN_BALANCE)
    card.touch_in(station)
    card.touch_out(station_b)
    expect(card.in_journey?).to eq false
  end

  it "does not allow user to touch in if card is under the minimum balance" do
    expect { card.touch_in(station) }.to raise_error "You have less than the £#{Oyster::MIN_BALANCE} minimum balance, please top up."
  end

  it "deducts the mimimum fare after touch_out" do
    card.top_up(Oyster::MIN_BALANCE)
    card.touch_in(station) 
    expect { card.touch_out(station_b) }.to change{card.balance}.by(- Journey::FARE)
  end

  it "card has an empty list of journeys by default" do
    expect(card.journeys.empty?).to eq true
  end

  it "creates a journey after touch_in and touch_out" do
    card.top_up(Oyster::MIN_BALANCE)
    card.touch_in(station)
    card.touch_out(station_b)
    expect(card.journeys.count).to eq 1
  end

  it "create a new Journey when touch in" do
    card.top_up(Oyster::MIN_BALANCE)
    expect(card.touch_in(station)).to be_an_instance_of Journey
  end

  it "deduct a penalty fare when touch in twice" do
    card.top_up(Oyster::MIN_BALANCE)
    card.touch_in(station)
    expect { card.touch_in(station_b) }.to change{ card.balance }.by(- Journey::PENALTY_FARE)
  end

  it "deduct a penalty fare when touch out when not touch in" do
    expect { card.touch_out(station_b) }.to change{ card.balance }.by(- Journey::PENALTY_FARE)
  end
end




