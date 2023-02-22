require 'gilded_rose'
require 'item'

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end
    
    it "tests update of sell_in and quality of normal items" do
      items = [
        Item.new("Normal item", 10, 10),
        Item.new("Normal item", 0, 8)
        ]
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq 9
      expect(items[0].quality).to eq 9
      expect(items[1].sell_in).to eq -1
      expect(items[1].quality).to eq 6
    end

  end

end



