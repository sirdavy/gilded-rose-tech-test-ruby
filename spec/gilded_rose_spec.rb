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
    
    it "tests that the quality of any item, when zero, does not degrade below zero" do
      items = [
        Item.new("Normal item", 2, 0),
        Item.new("Aged Brie", 10, 0),
        Item.new("Sulfuras, Hand of Ragnaros", 0, 80),
        Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 0),
        #Item.new("Conjured item", 0, 0)
      ]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
      expect(items[1].quality).to eq 1
      expect(items[2].quality).to eq 80
      expect(items[3].quality).to eq 0
      # expect(items[4].quality).to eq 0
    
    end



  end
end



