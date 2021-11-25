require 'journey'

describe Journey do
  let(:journey) { Journey.new}

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

end