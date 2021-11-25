require 'journey'

describe Journey do
  let(:journey) { Journey.new}
  let(:bank) { double("bank") }
  let(:moorgate) { double("moorgate") }

  it "has the proper attributes" do
    expect(journey).to have_attributes(:entry_station => nil, :exit_station => nil)
  end

  it "can set a new entry_station" do
    journey.entry_station=("Aldgate")
    expect(journey.entry_station).to eq "Aldgate"
  end

  it "can set an exit_station" do
    journey.exit_station=("Battersea")
    expect(journey.exit_station).to eq "Battersea"
  end

  it "return false when journey not complete" do
    expect(journey.completed).to eq false
  end

  it "return true when journey complete" do
    journey.entry_station=("Victoria")
    journey.exit_station=("Moorgate")
    expect(journey.completed).to eq true
  end

  it "return penalty fare if journey not complete" do
    expect(journey.fare).to eq Journey::PENALTY_FARE
  end

  it "returns a fare of 1 when travelling from zone 1 to zone 1" do
    allow(bank).to receive(:zone).and_return(1)
    allow(moorgate).to receive(:zone).and_return(1)
    journey.entry_station=(bank)
    journey.exit_station=(moorgate)
    expect(journey.fare).to eq 1
  end

  it "returns a fare of 3 when travelling from zone 4 to zone 2" do
    allow(bank).to receive(:zone).and_return(4)
    allow(moorgate).to receive(:zone).and_return(2)
    journey.entry_station=(bank)
    journey.exit_station=(moorgate)
    expect(journey.fare).to eq 3
  end

  it "returns a fare of 2 when travelling from zone 6 to 5" do
    allow(bank).to receive(:zone).and_return(6)
    allow(moorgate).to receive(:zone).and_return(5)
    journey.entry_station=(bank)
    journey.exit_station=(moorgate)
    expect(journey.fare).to eq 2
  end
end