require "oystercard"

describe Oystercard do
subject(:oystercard) {described_class.new}

  describe "#initialize" do
    it "Shows a balance of £0 on new card" do
    expect(oystercard.balance).to eq 0
    end
  end

  describe "#top_up" do
    it "Allows balance to be topped up" do
      expect(oystercard.top_up(10)).to eq oystercard.balance
    end
  end

  describe "#top_up maximum" do
    it "Prevents balance to be topped up beyond £90" do
      oystercard.top_up(1)
      expect{oystercard.top_up(Oystercard::DEFAULT_MAX)}.to raise_error("Unable to top up balance to above maximum amount")
    end

  end

end
