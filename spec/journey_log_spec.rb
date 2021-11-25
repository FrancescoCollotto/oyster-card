require 'journey_log'

describe JourneyLog do
  let(:journey) { Journey }
  let(:subject) { JourneyLog.new(journey_class: journey) }

  it "expects in_journey to be true when travelling" do
    subject.start("Victoria")
    expect(subject.in_journey?).to eq true
  end

  it "expects in_journey to be true when not travelling" do
    expect(subject.in_journey?).to eq false
  end

  it " has an empty list of journeys by default" do
    expect(subject.journeys.empty?).to eq true
  end

  it "creates a journey after a journey is ended" do
    subject.start("Victoria")
    subject.end("Bank")
    expect(subject.journeys.count).to eq 1
  end

  it "create a new Journey when starting a journey" do
    subject.start("Victoria")
    expect(subject.current_journey).to be_an_instance_of Journey
  end
end