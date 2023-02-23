# require 'item'

class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      if item.name == "Sulfuras, Hand of Ragnaros"
        handle_sulfuras(item)
      elsif item.name == "Aged Brie"
        handle_brie(item)
      elsif item.name == "Backstage passes to a TAFKAL80ETC concert"
        handle_backstage_passes(item)
      elsif item.name.downcase.include? "conjured"
        handle_conjured_items(item) 
      else
        handle_normal_items(item)
      end
    end
  end

  def handle_sulfuras(item)
    return item
  end

  def handle_brie(item)   
    if item.quality < 50 && item.sell_in > 0
      item.quality = item.quality + 1
    elsif item.quality < 50 && item.sell_in <= 0
      item.quality = item.quality + 2
    end
    item.sell_in = item.sell_in - 1
    return item
  end

  
  def handle_backstage_passes(item)
    if item.sell_in > 10 && item.quality < 50 
      item.quality = item.quality + 1
    elsif item.sell_in > 10 && item.quality == 50 
        item.quality = item.quality
    elsif item.sell_in > 5 && item.quality <= 48
      item.quality = item.quality + 2
    elsif item.sell_in > 5 && item.quality <= 49
      item.quality = item.quality + 1
    elsif item.sell_in > 5 && item.quality == 50
      item.quality = item.quality 
    elsif item.sell_in > 0 && item.quality <= 47
      item.quality = item.quality + 3
    elsif item.sell_in > 0 && item.quality <= 48
      item.quality = item.quality + 2
    elsif item.sell_in > 0 && item.quality <= 49
      item.quality = item.quality + 1
    elsif item.sell_in > 0 && item.quality == 50
      item.quality = item.quality
    else
      item.quality = 0
    end
    item.sell_in = item.sell_in - 1
    return item
  end

  def handle_conjured_items(item)
    if item.sell_in > 0 && item.quality >= 2
      item.quality = item.quality - 2
    elsif item.sell_in <= 0 && item.quality >= 4
      item.quality = item.quality - 4
    else
      item.quality = 0
    end
    item.sell_in = item.sell_in - 1
    return item
  end

  def handle_normal_items(item)
    if item.sell_in > 0 && item.quality >= 1
      item.quality = item.quality - 1
    elsif item.sell_in <= 0 && item.quality >= 2
      item.quality = item.quality - 2
    else
      item.quality = 0
    end
    item.sell_in = item.sell_in - 1
    return item
  end
  
end




#   def update_quality()
#     @items.each do |item|
#       #Handles quality update of normal items
#       if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
#         if item.quality > 0
#           if item.name != "Sulfuras, Hand of Ragnaros"
#             item.quality = item.quality - 1
#           end
#         end
#       else
#         if item.quality < 50
#           item.quality = item.quality + 1
#           if item.name == "Backstage passes to a TAFKAL80ETC concert"
#             if item.sell_in < 11
#               if item.quality < 50
#                 item.quality = item.quality + 1
#               end
#             end
#             if item.sell_in < 6
#               if item.quality < 50
#                 item.quality = item.quality + 1
#               end
#             end
#           end
#         end
#       end
#       if item.name != "Sulfuras, Hand of Ragnaros"
#         item.sell_in = item.sell_in - 1
#       end
#       if item.sell_in < 0
#         if item.name != "Aged Brie"
#           if item.name != "Backstage passes to a TAFKAL80ETC concert"
#             if item.quality > 0
#               if item.name != "Sulfuras, Hand of Ragnaros"
#                 item.quality = item.quality - 1
#               end
#             end
#           else
#             item.quality = item.quality - item.quality
#           end
#         else
#           if item.quality < 50
#             item.quality = item.quality + 1
#           end
#         end
#       end
#     end
#   end
# end
