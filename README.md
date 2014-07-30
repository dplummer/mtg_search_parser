# MtgSearchParser

A parser for search strings for finding Magic the Gathering cards. Inspired by
[magiccards.info](http://magiccards.info).

## Syntax I want to support

Name:

* Birds of Paradise
* "Birds of Paradise"
* !Anger (Match the full name)

Rules Text (Oracle):

* o:Flying
* o:"First strike"
* o:{T} o:"add one mana of any color"
* o:"whenever ~ deals combat damage"

Types (Oracle):

* t:angel
* t:"legendary angel"
* t:basic
* t:"arcane instant"

Colors:

* c:w (Any card that is white)
* c:wu (Any card that is white or blue)
* c:wum (Any card that is white or blue, and multicolored)
* c!w (Cards that are only white)
* c!wu (Cards that are only white or blue, or both)
* c!wum (Cards that are only white and blue, and multicolored)
* c!wubrgm (Cards that are all five colors)
* c:m (Any multicolored card)
* c:l or c:c (Lands and colorless cards)

Color Identity:

* ci:wu (Any card that is white or blue, but does not contain any black, red or green mana symbols)

Color Indicator:

* in:wu (Any card that is white or blue according to the color indicator.)

Mana Cost:

* mana=3G (Spells that cost exactly 3G, or split cards that can be cast with 3G)
* mana>=2WW (Spells that cost at least two white and two colorless mana)
* mana<GGGGGG (Spells that can be cast with strictly less than six green mana)
* mana>=2RR mana<=6RR (Spells that cost two red mana and between two and six colorless mana)
* mana>={2/R}
* mana>={W/U}
* mana>={UP}

Power, Toughness, Converted Mana Cost:

* pow>=8
* tou<pow (All combinations are possible)
* cmc=7
* cmc>=*

Rarity:

* r:mythic
* Format:
* f:standard (or block, extended, vintage, classic, legacy, modern, commander)
* banned:extended (or legal, restricted)

Artist:

* a:"rk post"

Edition:

* e:al/en (Uses the abbreviations that are listed on the sitemap)
* e:al,be (Cards that appear in Alpha or Beta)
* e:al+be (Cards that appear in Alpha and Beta)
* e:al,be -e:al+be (Cards that appear in Alpha or Beta but not in both editions)
* year<=1995 (Cards printed in 1995 and earlier)

Is:

* is:split, is:flip
* is:vanilla (Creatures with no card text)
* is:old, is:new, is:future (Old/new/future card face)
* is:timeshifted
* is:funny, not:funny (Unglued/Unhinged/Happy Holidays Promos)
* is:promo (Promotional cards)
* is:promo is:old (Promotional cards with the original card face)
* is:permanent, is:spell
* is:black-bordered, is:white-bordered, is:silver-bordered
* has:foil

Language:

* l:de, l:it, l:jp (Uses the abbreviations that are listed on the sitemap)

## Installation

Add this line to your application's Gemfile:

    gem 'mtg_search_parser'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mtg_search_parser

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it ( http://github.com/<my-github-username>/mtg_search_parser/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
