require "./lib/oystercard.rb"

describe Oystercard do
subject(:oystercard) {described_class.new}


  describe "#initialize" do

    it "shows a balance of £0 on new card" do
      expect(oystercard.balance).to eq 0
    end

    it "creates a new journey list which is blank on initialization" do
      expect(oystercard.journey_hist).to eq []
    end

    it "creates a new instance of the journey class on initialization by default" do
      expect(oystercard.journey_klass).to eq Journey
    end

    it "creates a new instance of the journey class with current_journey set to nil" do
      expect(oystercard.current_journey).to eq nil
    end

  end

  describe "#top_up" do

    it "allows balance to be topped up" do
      expect {oystercard.top_up(10)}.to change{oystercard.balance}.by(10)
    end
  end

  describe "#top_up maximum" do

    it "prevents balance to be topped up beyond £90" do
      oystercard.instance_variable_set("@balance", 1)
      expect{oystercard.top_up(Oystercard::MAX_LIMIT)}.to raise_error("Unable to top up balance to above #{Oystercard::MAX_LIMIT} amount")
    end
  end

  describe "#balance and deduction" do
    let(:station) {double(:station)}
    let(:journey) {double(:journey)}

    before do
      oystercard.instance_variable_set("@balance", 20)
    end

    it "prevents balance to be topped up beyond £90" do
      expect{oystercard.top_up(Oystercard::MAX_LIMIT)}.to raise_error("Unable to top up balance to above #{Oystercard::MAX_LIMIT} amount")
    end

    it "Allows balance to be reduced by penalty fare when two touch in's in a row" do
      oystercard.touch_in(station)
      oystercard.touch_in(station)
      expect {oystercard.touch_in(station)}.to change{oystercard.balance}.by(-6)
    end

    it "allows balance to be reduced by penalty fare when two touch out's in a row" do
      oystercard.touch_out(station)
      oystercard.touch_out(station)
      expect {oystercard.touch_out(station)}.to change{oystercard.balance}.by(-6)
    end
  end


  describe "#touch_in" do
    let(:station) {double(:station)}
    let(:journey) {double(:journey)}

    it "checks min balance on touch_in" do
      expect{oystercard.touch_in(station)}.to raise_error("Balance under #{Oystercard::DEFAULT_MIN}")
    end

    it "creates a new instance of the journey class on top_up if one does not already exist" do
      oystercard.instance_variable_set("@balance", 1)
      oystercard.touch_in(station)
      expect(oystercard.current_journey).not_to eq nil
    end

    #it "records the station of departure at touch_in" do
    #   oystercard.instance_variable_set("@balance", 1)
    #   oystercard.touch_in(station)
    #   expect(oystercard.entry_station).to eq station
    # end

  end

  describe "#touch_out" do
    let(:station) {double(:station)}
    let(:journey) {double(:journey)}

    it "deducts the minimum cost of a journey on touch_out after touch_in" do
      oystercard.instance_variable_set("@balance", 1)
      oystercard.touch_in(station)
      expect {oystercard.touch_out(station)}.to change{oystercard.balance}.by(-1)
    end



  end

  #describe "#in_journey" do
  #  let(:station) {double(:station)}

    # it "shows as in_journey after touch_in" do
    #   oystercard.top_up(1)
    #   oystercard.touch_in(station)
    #   expect(oystercard).to be_in_journey
    # end

  #end

end
