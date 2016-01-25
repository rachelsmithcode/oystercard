require "oystercard"

describe Oystercard do
subject(:oystercard) {described_class.new}

  describe "#initialize" do
    it "Shows a balance of £0 on new card" do
      expect(oystercard.balance).to eq 0
    end

    it "sets 'in_use' to false on initialization" do
      expect(oystercard.in_use).to eq false
    end
  end

  describe "#top_up" do
    it "Allows balance to be topped up" do
      expect(oystercard.top_up(10)).to eq oystercard.balance
    end
  end

  describe "#top_up maximum" do
    it "Prevents balance to be topped up beyond £90" do
      oystercard.instance_variable_set("@balance", 1)
      expect{oystercard.top_up(Oystercard::DEFAULT_MAX)}.to raise_error("Unable to top up balance to above #{Oystercard::DEFAULT_MAX} amount")
    end
  end

  describe "#deduct" do
    it "Allows balance to be reduced when money deducted" do
      expect(oystercard.deduct(10)).to eq oystercard.balance
    end
  end

  describe "#touch_in" do

    it "Card shows as in_use after touch_in" do
      oystercard.instance_variable_set("@balance", 1)
      expect(oystercard.touch_in).to eq true
    end

    it "Check min balance on touch_in" do
      expect{oystercard.touch_in}.to raise_error("Balance under #{Oystercard::DEFAULT_MIN}")
    end
  end

  describe "#touch_out" do

    it "Card shows as not in_use after touch_out" do
      expect(oystercard.touch_out).to eq false
    end

    it "Cost for journey is deducted on touch_out" do
      oystercard.instance_variable_set("@balance", 1)
      oystercard.touch_out
      expect(oystercard.balance).to eq 0
    end


  end

  describe "#in_journey" do
    it "Card shows as not in_use after touch_out" do
      oystercard.top_up(1)
      oystercard.touch_in
      expect(oystercard).to be_in_journey
    end
  end

end
