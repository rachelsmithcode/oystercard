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


end
