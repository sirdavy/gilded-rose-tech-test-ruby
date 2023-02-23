require "item"

describe Item do
  it "constructs an item" do
    item = Item.new("Odd Substance", 10, 10)
    expect(item.name).to eq "Odd Substance"
    expect(item.sell_in).to eq 10
    expect(item.quality).to eq 10
  end

  it "returns a string with item info" do
    item = Item.new("Odd Substance", 10, 10)
    expect(item.to_s).to eq "Odd Substance, 10, 10"
  end
end
