require "oystercard"

describe Oystercard do
subject(:oystercard) {described_class.new}

  describe "#initialize" do
    it "Shows a balance of £0 on new card" do
    expect(oystercard.balance).to eq 0
    end
  end


end
