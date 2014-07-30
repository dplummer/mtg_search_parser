require 'spec_helper'

module MtgSearchParser
  describe Parser do
    describe "#parse" do
      context "name" do
        it "Birds of Paradise" do
          expect(subject.parse("Birds of Paradise")).
            to eq(Parsed::Name.new("Birds of Paradise"))
        end

        it '"Birds of Paradise"' do
          expect(subject.parse('"Birds of Paradise"')).
            to eq(Parsed::Name.new("Birds of Paradise"))
        end

        it "!Birds of Paradise" do
          expect(subject.parse("!Birds of Paradise")).
            to eq(Parsed::ExactName.new("Birds of Paradise"))
        end
      end

      context "rules text" do
        it "o:Flying" do
        end

        it 'o:"First strike"' do

        end

        it 'o:{T} o:"add one mana of any color"' do

        end

        it 'o:"whenever ~ deals combat damage"' do

        end
      end

      context "types" do
        it 't:angel' do

        end

        it 't:"legendary angel"' do

        end

        it 't:basic' do

        end

        it 't:"arcane instant"' do

        end
      end

      context "colors" do
        it 'c:w (Any card that is white)' do

        end

        it 'c:wu (Any card that is white or blue)' do

        end

        it 'c:wum (Any card that is white or blue, and multicolored)' do

        end

        it 'c!w (Cards that are only white)' do

        end

        it 'c!wu (Cards that are only white or blue, or both)' do

        end

        it 'c!wum (Cards that are only white and blue, and multicolored)' do

        end

        it 'c!wubrgm (Cards that are all five colors)' do

        end

        it 'c:m (Any multicolored card)' do

        end

        it 'c:l or c:c (Lands and colorless cards)' do

        end
      end

      context "color identity" do
        it 'ci:wu (Any card that is white or blue, but does not contain any black, red or green mana symbols)' do

        end
      end

      context "mana cost" do
        it 'mana=3G (Spells that cost exactly 3G, or split cards that can be cast with 3G)' do

        end

        it 'mana>=2WW (Spells that cost at least two white and two colorless mana)' do

        end

        it 'mana<GGGGGG (Spells that can be cast with strictly less than six green mana)' do

        end

        it 'mana>=2RR mana<=6RR (Spells that cost two red mana and between two and six colorless mana)' do

        end

        it 'mana>={2/R}' do

        end

        it 'mana>={W/U}' do

        end

        it 'mana>={UP}' do

        end
      end

      context "Power, Toughness, Converted Mana Cost" do
        it 'pow>=8' do

        end

        it 'tou<pow (All combinations are possible)' do

        end

        it 'cmc=7' do

        end

        it 'cmc>=*' do

        end
      end

      context "Rarity" do
        it 'r:mythic' do

        end

        it 'Format:' do

        end

        it 'f:standard (or block, extended, vintage, classic, legacy, modern, commander)' do

        end

        it 'banned:extended (or legal, restricted)' do

        end
      end

      context "Artist" do
        it 'a:"rk post"' do

        end
      end

      context "Edition" do
        it 'e:al/en (Uses the abbreviations that are listed on the sitemap)' do

        end

        it 'e:al,be (Cards that appear in Alpha or Beta)' do

        end

        it 'e:al+be (Cards that appear in Alpha and Beta)' do

        end

        it 'e:al,be -e:al+be (Cards that appear in Alpha or Beta but not in both editions)' do

        end

        it 'year<=1995 (Cards printed in 1995 and earlier)' do

        end
      end

      context "Is:" do
        it 'is:split, is:flip' do

        end

        it 'is:vanilla (Creatures with no card text)' do

        end

        it 'is:old, is:new, is:future (Old/new/future card face)' do

        end

        it 'is:timeshifted' do

        end

        it 'is:funny, not:funny (Unglued/Unhinged/Happy Holidays Promos)' do

        end

        it 'is:promo (Promotional cards)' do

        end

        it 'is:promo is:old (Promotional cards with the original card face)' do

        end

        it 'is:permanent, is:spell' do

        end

        it 'is:black-bordered, is:white-bordered, is:silver-bordered' do

        end

        it 'has:foil' do

        end
      end

      context "Language" do
        it 'l:de, l:it, l:jp (Uses the abbreviations that are listed on the sitemap)' do

        end
      end
    end
  end
end
