require "oystercard"

describe Oystercard do
subject(:oystercard) {described_class.new}

  describe "#initialize" do

    it "shows a balance of £0 on new card" do
      expect(oystercard.balance).to eq 0
    end

    it "creates a new journey list which is blank on initialization" do
      expect(oystercard.journey_list).to eq []
    end

    it "creates a new instance of the journey class on initialization by default" do
      expect(oystercard.journey_class).to eq Journey
    end

  end

  describe "#top_up" do

    it "allows balance to be topped up" do
      expect(oystercard.top_up(10)).to eq oystercard.balance
    end
  end

  describe "#top_up maximum" do

    it "prevents balance to be topped up beyond £90" do
      oystercard.instance_variable_set("@balance", 1)
      expect{oystercard.top_up(Oystercard::DEFAULT_MAX)}.to raise_error("Unable to top up balance to above #{Oystercard::DEFAULT_MAX} amount")
    end
  end

  # describe "#deduct" do
  #   it "Allows balance to be reduced when money deducted" do
  #     expect(oystercard.deduct(10)).to eq oystercard.balance
  #   end
  # end

  describe "#touch_in" do
    let(:station) {double(:station)}

    it "checks min balance on touch_in" do
      expect{oystercard.touch_in(station)}.to raise_error("Balance under #{Oystercard::DEFAULT_MIN}")
    end

    # it "records the station of departure at touch_in" do
    #   oystercard.instance_variable_set("@balance", 1)
    #   oystercard.touch_in(station)
    #   expect(oystercard.entry_station).to eq station
    # end

  end

  describe "#touch_out" do
    let(:station) {double(:station)}

    it "deducts the cost of journey on touch_out" do
      oystercard.instance_variable_set("@balance", 1)
      expect {oystercard.touch_out(station)}.to change{oystercard.balance}.by(-1)
    end

  end

  describe "#in_journey" do
    let(:station) {double(:station)}

    # it "shows as in_journey after touch_in" do
    #   oystercard.top_up(1)
    #   oystercard.touch_in(station)
    #   expect(oystercard).to be_in_journey
    # end

  end

end
