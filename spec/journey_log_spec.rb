require './lib/journey_log.rb'

describe JourneyLog do
subject(:journey_log) {described_class.new}


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

  describe "#journey_history" do

    it "" do
      expect(journey.journey_cost).to eq 0
    end

  end

  describe "#start_journey" do

    it "" do
      expect(journey.journey_cost).to eq 0
    end

  end

  describe "#end_journey" do

    it "" do
      expect(journey.journey_cost).to eq 0
    end

  end

  describe "#current_journey" do

    it "" do
      expect(journey.journey_cost).to eq 0
    end

  end

  describe "#outstanding_charges" do

    it "" do
      expect(journey.journey_cost).to eq 0
    end

  end

  describe "#incomplete_journey" do

    it "" do
      expect(journey.journey_cost).to eq 0
    end

  end

end
