require "./lib/journey.rb"

describe Journey do
subject(:journey) {described_class.new}


  describe "#initialize" do

    it "shows a journey_cost of £0 on new journey" do
      expect(journey.journey_cost).to eq 0
    end

    it "sets in_journey to false on initialization" do
      expect(journey.in_journey).to eq false
    end

    it "sets entry_station to nil on initialization by default" do
      expect(journey.entry_station).to eq nil
    end

    it "sets exit_station to nil on initialization by default" do
      expect(journey.exit_station).to eq nil
    end

  end

  describe "#start journey" do
    let(:station) {double(:station)}

    it "sets entry_station if it is a new journey after calling start_journey" do
      journey.start_journey(station)
      expect(journey.entry_station).to eq station
    end

    it "sets in_journey to true if it is a new journey after calling start_journey" do
      journey.start_journey(station)
      expect(journey.in_journey).to eq true
    end

    it "sets exit_station to 'no touch out' if it is not a new journey when calling start_journey" do
      journey.start_journey(station)
      journey.start_journey(station)
      expect(journey.exit_station).to eq 'no touch out'
    end

    it "sets in_journey to true if it is a new journey after calling start_journey" do
      journey.start_journey(station)
      journey.start_journey(station)
      expect(journey.in_journey).to eq false
    end

  end

  describe "#end journey" do
    let(:station) {double(:station)}
    #let(:journey) {double(:journey)}

    it "sets exit_station if end_journey is called after calling start_journey" do
      journey.start_journey(station)
      journey.end_journey(station)
      expect(journey.exit_station).to eq station
    end

    it "sets in_journey to false after calling end_journey where start_journey was called first" do
      journey.start_journey(station)
      journey.end_journey(station)
      expect(journey.in_journey).to eq false
    end

    it "sets in_journey to true after calling end_journey where start_journey was not called first" do
      journey.end_journey(station)
      expect(journey.in_journey).to eq true
    end

    it "sets entry_station to 'no touch in' if end_journey called without calling start_journey first" do
      journey.end_journey(station)
      expect(journey.entry_station).to eq 'no touch in'
    end

  end

  describe "#journey complete" do
    let(:station) {double(:station)}

    it "records an entry_station in the hash journey_details when journey complete called if journey start and journey end" do
      journey.start_journey(station)
      journey.end_journey(station)
      journey.journey_complete
      expect(journey.journey_details.has_key?(station)).to eq true
    end

    it "records an exit_station in the hash journey_details when journey complete called if journey start and journey end" do
      journey.start_journey(station)
      journey.end_journey(station)
      expect(journey.journey_details.value?(station)).to eq true
    end

  end

  describe "#fare" do
    let(:station) {double(:station)}

    it "sets journey cost to penalty fare when no touch out after touch in" do
      journey.start_journey(station)
      journey.journey_complete
      expect(journey.journey_cost).to eq (Journey::PEN_FARE)
    end

    it "sets journey cost to penalty fare when no touch in after touch out" do
      journey.end_journey(station)
      journey.journey_complete
      expect(journey.journey_cost).to eq (Journey::PEN_FARE)
    end

    it "sets journey_cost to standard fare after touch in and out" do
      journey.end_journey(station)
      journey.start_journey(station)
      journey.journey_complete
      expect(journey.journey_cost).to eq (Journey::STANDARD_FARE)
    end

  end

end
