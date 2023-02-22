

* Read through outline and download required files
* Open and initialising project folder and arrange code into separate files, and folders for rspec testing removing any unwanted tests from non-rspec framework
* read through code, use existing code in irb

# Create a list of items
items = [
  Item.new("Potion", 10, 20),
  Item.new("Aged Brie", 5, 40),
  Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20),
  Item.new("Sulfuras, Hand of Ragnaros", 0, 80)
]

# Create a GildedRose object with the list of items
gilded_rose = GildedRose.new(items)

# Update the quality and sell-in values of the items
gilded_rose.update_quality()

# Print the updated values of the items
items.each do |item|
  puts item.to_s
end

# OUTPUTS =>
Potion, 9, 19
Aged Brie, 4, 41
Backstage passes to a TAFKAL80ETC concert, 14, 21
Sulfuras, Hand of Ragnaros, 0, 80


Edge Cases

BRIE

INPUT
"Aged Brie", 10, 20
"Aged Brie", 1, 20
"Aged Brie", 0, 40
"Aged Brie", -1, 30

OUTPUT
Aged Brie, 9, 21
"Aged Brie", 0, 21
Aged Brie, -1, 42
Aged Brie, -2, 32

So, the quality rate of Aged Brie doubles (goes up by 2 instead of 1) when it goes past sell_in date of 0.

BACKSTAGE PASSES

INPUT
"Backstage passes to a TAFKAL80ETC concert", 15, 10
"Backstage passes to a TAFKAL80ETC concert", 10, 10
"Backstage passes to a TAFKAL80ETC concert", 5, 10

OUTPUT
Backstage passes to a TAFKAL80ETC concert, 14, 11
Backstage passes to a TAFKAL80ETC concert, 9, 12
Backstage passes to a TAFKAL80ETC concert, 4, 13


* Understand specifications of test:
  
1. Create tests for the existing code
2. Update the code to take into account new “Conjured” items, which degrade in Quality twice as fast as normal items.
3. Refactor the code, improve code (would it benefit from a print items method?)
4. Do not alter the Item class or Items property 
5. You *can* make the UpdateQuality method and Items property static if you like.

* Read http://coding-is-like-cooking.info/2013/03/writing-good-tests-for-the-gilded-rose-kata/
* Read https://iamnotmyself.com/why-most-solutions-to-gilded-rose-miss-the-bigger-picture/

# 1. Create integrated tests and unit tests for the existing code # 

*integrated tests*

# fixes existing failing test - "does not change the name"

items = [Item.new("foo", 0, 0)]
GildedRose.new(items).update_quality()
expect(items[0].name).to eq "foo"

# updates sell_in and quality of normal item #

items = [
  Item.new("Normal item", 10, 10)
  Item.new("Normal item", 0, 8)
  ]
GildedRose.new(items).update_quality()
expect(items[0].sell_in).to eq 9
expect(items[0].quality).to eq 9
expect(items[1].sell_in).to eq -1
expect(items[1].quality).to eq 6

# tests that quality of normal item degrades twices as fast when sell_in changes to zero

items = [Item.new("foo", 10, 1)]
GildedRose.new(items).update_quality()
expect(items[0].sell_in).to eq 0
expect(items[0].quality).to eq 9
GildedRose.new(items).update_quality()
expect(items[0].sell_in).to eq -1
expect(items[0].quality).to eq 8

# tests that quality of any item when zero, does not degrade below zero
items = [
  Item.new("Normal item", 2, 0),
  Item.new("Aged Brie", 10, 0),
  Item.new("Sulfuras, Hand of Ragnaros", 0, 80),
  Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 0),
  #Item.new("Conjured Item" 4, 0), # <-- :O
]
  GildedRose.new(items).update_quality()
  expect(items[0].quality).to eq 0
  expect(items[1].quality).to eq 0
  expect(items[2].quality).to eq 80
  expect(items[3].quality).to eq 0
  expect(items[4].quality).to eq 0
  #expect(items[5].quality).to eq 0

# tests update of sell_in and quality of Brie

items = [
  Item.new("Aged Brie", 10, 10)
  Item.new("Aged Brie", 1, 20)
  Item.new("Aged Brie", 0, 30)
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

# tests that quality of any item can never more than 50

items = [
  Item.new("Aged Brie", 10, 50)
  Item.new("Aged Brie", -1, 50),
  Item.new("Aged Brie", -1, 50),
  Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 50),
  Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 50),
  Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 50),
  ]
  GildedRose.new(items).update_quality()
  expect(items[0].quality).to eq 50
  expect(items[1].quality).to eq 50
  expect(items[2].quality).to eq 50
  expect(items[3].quality).to eq 50
  expect(items[4].quality).to eq 50
  expect(items[5].quality).to eq 50
  #OR expect(items.map(&:quality)).to all(eq(50))


# tests update of sell_in and quality of “Sulfuras”

  items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 80)]
    GildedRose.new(items).update_quality()
    expect(items[0].sell_in).to eq 0
    expect(items[0].quality).to eq 80

# tests update of sell_in and quality of “Backstage passes” 

items = [
Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 10)
Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 10)
Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 10)
Item.new("Backstage passes to a TAFKAL80ETC concert", 1, 10)
]
GildedRose.new(items).update_quality()
  expect(items[0].sell_in).to eq 14
  expect(items[0].quality).to eq 11
  expect(items[1].sell_in).to eq 9
  expect(items[1].quality).to eq 12
  expect(items[2].sell_in).to eq 4
  expect(items[2].quality).to eq 13
  expect(items[3].sell_in).to eq 0
  expect(items[3].quality).to eq 0

# tests that quality of conjured item degrades twices as fast when sell_in changes to zero
    and add to necessary tests above

items = [
  Item.new("Conjured item", 10, 10)
  Item.new("Conjured item", 0, 10)
  ]
  GildedRose.new(items).update_quality()
  expect(items[0].sell_in).to eq 9
  expect(items[0].quality).to eq 8
  expect(items[1].sell_in).to eq -1
  expect(items[1].quality).to eq 6



GildedRose Unit Test Examples

















```