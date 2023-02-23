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
        Item.new("Conjured item", 0, 0),
        Item.new("Conjured item", 10, 1),
        Item.new("Conjured item", 0, 3),
        Item.new("Normal item", 0, 1)

      ]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
      expect(items[1].quality).to eq 1
      expect(items[2].quality).to eq 80
      expect(items[3].quality).to eq 0
      expect(items[4].quality).to eq 0
      expect(items[5].quality).to eq 0
      expect(items[6].quality).to eq 0
      expect(items[7].quality).to eq 0
    end

    it "tests the update of sell_in and quality of Brie" do
      items = [
        Item.new("Aged Brie", 10, 10),
        Item.new("Aged Brie", 1, 20),
        Item.new("Aged Brie", 0, 30),
        Item.new("Aged Brie", -1, 40)
        ]
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq 9
      expect(items[0].quality).to eq 11
      expect(items[1].sell_in).to eq 0
      expect(items[1].quality).to eq 21
      expect(items[2].sell_in).to eq -1
      expect(items[2].quality).to eq 32
      expect(items[3].sell_in).to eq -2
      expect(items[3].quality).to eq 42
    end


    it "tests the quality of any item can never more than 50" do
      items = [
        Item.new("Aged Brie", 10, 50),
        Item.new("Aged Brie", -1, 50),
        Item.new("Aged Brie", -1, 50),
        Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 50),
        Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 50),
        Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 50)
        ]
      GildedRose.new(items).update_quality()
      expect(items.map(&:quality)).to all(eq(50))
    end

    it "tests update of sell_in and quality of Sulfuras" do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 80)]
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq 0
      expect(items[0].quality).to eq 80
    end

    it "tests the update of sell_in and quality of Backstage passes" do 
      items = [
        Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 10),
        Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 10),
        Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 10),
        Item.new("Backstage passes to a TAFKAL80ETC concert", 1, 10),
        Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 10),
        Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 49),
        Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 50),
        Item.new("Backstage passes to a TAFKAL80ETC concert", 9, 49),
        Item.new("Backstage passes to a TAFKAL80ETC concert", 9, 48),
        Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 47),
        Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 48),
        Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 49)
        ]
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq 14
      expect(items[0].quality).to eq 11
      expect(items[1].sell_in).to eq 9
      expect(items[1].quality).to eq 12
      expect(items[2].sell_in).to eq 4
      expect(items[2].quality).to eq 13
      expect(items[3].sell_in).to eq 0
      expect(items[3].quality).to eq 13
      expect(items[4].sell_in).to eq -1
      expect(items[4].quality).to eq 0
      expect(items[5].sell_in).to eq 14
      expect(items[5].quality).to eq 50
      expect(items[6].sell_in).to eq 14
      expect(items[6].quality).to eq 50
      expect(items[7].sell_in).to eq 8 
      expect(items[7].quality).to eq 50
      expect(items[8].sell_in).to eq 8
      expect(items[8].quality).to eq 50
      expect(items[9].sell_in).to eq 4
      expect(items[9].quality).to eq 50
      expect(items[10].sell_in).to eq 4
      expect(items[10].quality).to eq 50
      expect(items[11].sell_in).to eq 4
      expect(items[11].quality).to eq 50
    end

    # it "tests that quality of conjured item degrades twices as fast when sell_in changes to zero" do
    #   items = [
    #     Item.new("Conjured item", 10, 10)
    #     Item.new("Conjured item", 0, 10)
    #     ]
    #   GildedRose.new(items).update_quality()
    #   expect(items[0].sell_in).to eq 9
    #   expect(items[0].quality).to eq 8
    #   expect(items[1].sell_in).to eq -1
    #   expect(items[1].quality).to eq 6
    # end


  end
end



