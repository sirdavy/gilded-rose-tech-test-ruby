# Gilded Rose Tech Test #

**This is my attempt at the Gilded Rose kata set by Makers Academy; a tech test commonly used to test a dev's ability to read, refactor and extend legacy code. The specifications are [here](https://github.com/emilybache/GildedRose-Refactoring-Kata).**

## Approach to the test ##

* Read through the test outline and downloaded required files. 
* Chose to complete the test using Ruby.
* Initialised project folder and arranged existing implementation code into two separate files, arranged folders for rspec testing removing any unwanted tests from non-rspec framework
* Read through the code, and tried it out in irb.
* Read http://coding-is-like-cooking.info/2013/03/writing-good-tests-for-the-gilded-rose-kata/
* Read https://iamnotmyself.com/why-most-solutions-to-gilded-rose-miss-the-bigger-picture/
* Settled on the following plan:
  1. Create unit and integration tests for the existing code, taking into account the many edge cases (which this test is clearly designed to create).
  2. TDD a method for the new “Conjured” items.
  3. Refactor.


## Results ##

* Creating the tests took up at least 60% of overall time spent on the kata. With each item in the Gilded Rose's inventory - including the new 'Conjured' goods - come a host of edge cases.
* Rather than create the conjured method first, it was much easier to refactor the code by separating out the huge block of if-else conditions that made up the original code into smaller methods of single responsiblity, starting with the 'Sulfuras' and then working through the increasingly more complex methods.
* Once these methods were created adding the 'Conjured' goods method was straightforward. The resulting code is a lot tidier and easy to parse.

![Screenshot of program](https://github.com/sirdavy/gilded-rose-tech-test-ruby/blob/main/GildedRose.png)

* Testing was carried out using rspec and SimpleCov. 
All tests pass with a 100% coverage.

![Testing screenshot](https://github.com/sirdavy/gilded-rose-tech-test-ruby/blob/main/GildedRoseTesting.png)

## Installing & Running the code ##

* Install Ruby & RVM - visit here https://rvm.io/

* In the root folder install the latest Ruby
```
; rvm get stable
; rvm use ruby --latest --install --default
```
* Navigate to lib folder and open IRB 
```
cd lib
irb
```
* Require the files
```
require './gilded_rose.rb'
require './item.rb'
```

### Commands ###
* Create an inventory of instances of Item:
```
items = [
  Item.new("Potion", 10, 20),
  Item.new("Aged Brie", 5, 40),
  Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 48),
  Item.new("Sulfuras, Hand of Ragnaros", 0, 80)
  Item.new("Conjured item", 5, 48),
  Item.new("Normal item", 10, 10)
]
```
* Inject the inventory into a new instance of GildedRose 
```
gilded_rose = GildedRose.new(items)
```
* Update the inventory qualities:
```
gilded_rose.update_quality()
```
```
items.each do |item|
  puts item.to_s
end
```

* Output:
```
Potion, 9, 19
Aged Brie, 4, 41
Backstage passes to a TAFKAL80ETC concert, 14, 21
Sulfuras, Hand of Ragnaros, 0, 8
```


