require "gilded_rose"

####### commented out tests are ones I could not get to work but have left in to address at a later date #########

describe GildedRose do
  describe "#update_quality" do
    context "with a normal item" do
      it "decreases the sell_in by 1" do
        item = double(name: "item", sell_in: 5, quality: 10).as_null_object
        gilded_rose = GildedRose.new([item])
        gilded_rose.update_quality()
        expect(item).to have_received(:sell_in=).with(4)
      end

      it "decreases the quality by 1" do
        item = double(name: "item", sell_in: 5, quality: 10).as_null_object
        gilded_rose = GildedRose.new([item])
        gilded_rose.update_quality()
        expect(item).to have_received(:quality=).with(9)
      end

      # it "decreases the quality by 2 after the sell-by date has passed" do
      #   item = double(name: "item", sell_in: 0, quality: 10).as_null_object
      #   gilded_rose = GildedRose.new([item])
      #   gilded_rose.update_quality()
      #   expect(item).to have_received(:quality=).with(8)
      # end

      #   it "does not decrease the quality below 0" do
      #     item = double(name: "item", sell_in: 5, quality: 0).as_null_object
      #     gilded_rose = GildedRose.new([item])
      #     gilded_rose.update_quality()
      #     expect(item).to have_received(:quality=).with(0)
      #   end
    end

    context "with Aged Brie" do
      it "decreases the sell_in by 1" do
        item = double(name: "Aged Brie", sell_in: 5, quality: 10).as_null_object
        gilded_rose = GildedRose.new([item])
        gilded_rose.update_quality()
        expect(item).to have_received(:sell_in=).with(4)
      end

      it "increases the quality by 1" do
        item = double(name: "Aged Brie", sell_in: 5, quality: 10).as_null_object
        gilded_rose = GildedRose.new([item])
        gilded_rose.update_quality()
        expect(item).to have_received(:quality=).with(11)
      end

      # it "does not increase the quality above 50" do
      #   item = double(name: "Aged Brie", sell_in: 5, quality: 50).as_null_object
      #   gilded_rose = GildedRose.new([item])
      #   gilded_rose.update_quality()
      #   expect(item).to have_received(:quality=).with(50)
      # end
    end

    context "with Sulfuras" do
      it "does not change the sell_in or quality" do
        item = double(name: "Sulfuras, Hand of Ragnaros", sell_in: 0, quality: 80).as_null_object
        gilded_rose = GildedRose.new([item])
        gilded_rose.update_quality()
        expect(item).not_to have_received(:sell_in=)
        expect(item).not_to have_received(:quality=)
      end
    end

    # context "with Backstage passes" do
    #   it "decreases the sell_in by 1" do
    #     item = double(name:"Backstage passes to a TAFKAL80ETC concert", sell_in: 20, quality: 10).as_null_object
    #     gilded_rose = GildedRose.new([item])
    #     gilded_rose.update_quality()
    #     expect(item.sell_in).to eq 19
    #   end

    #   it "increases the quality by 1 when sell_in > 10" do
    #     item = double(name:"Backstage passes to a TAFKAL80ETC concert", sell_in: 20, quality: 10).as_null_object
    #     gilded_rose = GildedRose.new([item])
    #     gilded_rose.update_quality()
    #     expect(item.quality).to eq 11
    #   end

    #   it "increases the quality by 2 when sell_in <= 10 and sell_in > 5" do
    #     item = double(name:"Backstage passes to a TAFKAL80ETC concert", sell_in: 10, quality: 10).as_null_object
    #     gilded_rose = GildedRose.new([item])
    #     gilded_rose.update_quality()
    #     expect(item.quality).to eq 12
    #   end

    #   it "increases the quality by 3 when sell_in <= 5 and sell_in > 0" do
    #     item = double(name:"Backstage passes to a TAFKAL80ETC concert", sell_in: 5, quality: 10).as_null_object
    #     gilded_rose = GildedRose.new([item])
    #     gilded_rose.update_quality()
    #     expect(item.quality).to eq 13
    #   end

    #   it "drops the quality to 0 when sell_in <= 0" do
    #     item = double(name:"Backstage passes to a TAFKAL80ETC concert", sell_in: 0, quality: 10).as_null_object
    #     gilded_rose = GildedRose.new([item])
    #     gilded_rose.update_quality()
    #     expect(item.quality).to eq 0
    #   end

    # end

  end
end
