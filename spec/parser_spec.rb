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
          expect(subject.parse("o:Flying")).
            to eq(Parsed::RulesText.new("Flying"))
        end

        it 'o:"First strike"' do
          expect(subject.parse('o:"First strike"')).
            to eq(Parsed::RulesText.new("First strike"))
        end

        it 'o:"add one mana of any color"' do
          expect(subject.parse('o:"add one mana of any color"')).
            to eq(Parsed::RulesText.new("add one mana of any color"))
        end

        it 'o:{T}' do
          expect(subject.parse('o:{T}')).
            to eq(Parsed::RulesText.new("{T}"))
        end

        it 'o:"whenever ~ deals combat damage"' do
          expect(subject.parse('o:"whenever ~ deals combat damage"')).
            to eq(Parsed::RulesText.new("whenever ~ deals combat damage"))
        end
      end

      context "types" do
        it 't:angel' do
          expect(subject.parse('t:angel')).
            to eq(Parsed::CardType.new("angel"))
        end

        it 't:"legendary angel"' do
          expect(subject.parse('t:"legendary angel"')).
            to eq(Parsed::CardType.new("legendary angel"))
        end

        it 't:basic' do
          expect(subject.parse('t:basic')).
            to eq(Parsed::CardType.new("basic"))
        end

        it 't:"arcane instant"' do
          expect(subject.parse('t:"arcane instant"')).
            to eq(Parsed::CardType.new("arcane instant"))
        end
      end

      context "colors" do
        it 'c:w (Any card that is white)' do
          expect(subject.parse('c:w')).
            to eq(Parsed::AnyColor.new("w"))
        end

        it 'c:wu (Any card that is white or blue)' do
          expect(subject.parse('c:wu')).
            to eq(Parsed::AnyColor.new("wu"))
        end

        it 'c:wum (Any card that is white or blue, and multicolored)' do
          expect(subject.parse('c:wum')).
            to eq(Parsed::AnyColor.new("wum"))
        end

        it 'c!w (Cards that are only white)' do
          expect(subject.parse('c!w')).
            to eq(Parsed::ExactColor.new("w"))
        end

        it 'c!wu (Cards that are only white or blue, or both)' do
          expect(subject.parse('c!wu')).
            to eq(Parsed::ExactColor.new("wu"))
        end

        it 'c!wum (Cards that are only white and blue, and multicolored)' do
          expect(subject.parse('c!wum')).
            to eq(Parsed::ExactColor.new("wum"))
        end

        it 'c!wubrgm (Cards that are all five colors)' do
          expect(subject.parse('c!wubrgm')).
            to eq(Parsed::ExactColor.new("wubrgm"))
        end

        it 'c:m (Any multicolored card)' do
          expect(subject.parse('c:m')).
            to eq(Parsed::AnyColor.new("m"))
        end

        it 'c:l (Land cards)' do
          expect(subject.parse('c:l')).
            to eq(Parsed::AnyColor.new("l"))
        end

        it 'c:c (colorless cards)' do
          expect(subject.parse('c:c')).
            to eq(Parsed::AnyColor.new("c"))
        end
      end

      context "color identity" do
        it 'ci:wu (Any card that is white or blue, but does not contain any black, red or green mana symbols)' do
          expect(subject.parse('ci:wu')).
            to eq(Parsed::ColorIdentity.new("wu"))
        end
      end

      context "mana cost" do
        it 'mana=3G (Spells that cost exactly 3G, or split cards that can be cast with 3G)' do
          expect(subject.parse('mana=3G')).
            to eq(Parsed::ManaCost.new("=", "3G"))
        end

        it 'mana>=2WW (Spells that cost at least two white and two colorless mana)' do
          expect(subject.parse('mana>=2WW')).
            to eq(Parsed::ManaCost.new(">=", "2WW"))
        end

        it 'mana<GGGGGG (Spells that can be cast with strictly less than six green mana)' do
          expect(subject.parse('mana<GGGGGG')).
            to eq(Parsed::ManaCost.new("<", "GGGGGG"))
        end

        it 'mana>={2/R}' do
          expect(subject.parse('mana>={2/R}')).
            to eq(Parsed::ManaCost.new(">=", "{2/R}"))
        end

        it 'mana>={W/U}' do
          expect(subject.parse('mana>={W/U}')).
            to eq(Parsed::ManaCost.new(">=", "{W/U}"))
        end

        it 'mana>={UP}' do
          expect(subject.parse('mana>={UP}')).
            to eq(Parsed::ManaCost.new(">=", "{UP}"))
        end
      end

      context "Power, Toughness, Converted Mana Cost" do
        it 'pow>=8' do
          expect(subject.parse('pow>=8')).
            to eq(Parsed::PowerToughCompare.new("pow", ">=", "8"))
        end

        it 'tou<pow (All combinations are possible)' do
          expect(subject.parse('tou<pow')).
            to eq(Parsed::PowerToughCompare.new("tou", "<", "pow"))
        end

        it 'pow>cmc (All combinations are possible)' do
          expect(subject.parse('pow>cmc')).
            to eq(Parsed::PowerToughCompare.new("pow", ">", "cmc"))
        end

        it 'cmc=7' do
          expect(subject.parse('cmc=7')).
            to eq(Parsed::PowerToughCompare.new("cmc", "=", "7"))
        end

        it 'cmc>=*' do
          expect(subject.parse('cmc>=*')).
            to eq(Parsed::PowerToughCompare.new("cmc", ">=", "*"))
        end
      end

      context "Rarity" do
        it 'r:mythic' do
          expect(subject.parse('r:mythic')).
            to eq(Parsed::Rarity.new("mythic"))
        end
      end

      context 'Format' do
        it 'f:standard (or block, extended, vintage, classic, legacy, modern, commander)' do
          expect(subject.parse('f:standard')).
            to eq(Parsed::Legal.new("standard"))
        end

        it 'banned:extended (or legal, restricted)' do
          expect(subject.parse('banned:extended')).
            to eq(Parsed::Banned.new("extended"))
        end
      end

      context "Artist" do
        it 'a:"rk post"' do
          expect(subject.parse('a:"rk post"')).
            to eq(Parsed::Artist.new("rk post"))
        end
      end

      context "Edition" do
        it 'e:al (Uses the abbreviations that are listed on the sitemap)' do
          expect(subject.parse('e:al')).
            to eq(Parsed::Edition.new("al"))
        end

        it 'e:al,be (Cards that appear in Alpha or Beta)' do
          expect(subject.parse('e:al,be')).
            to eq(Parsed::Edition.new("al,be"))
        end

        it 'e:al+be (Cards that appear in Alpha and Beta)' do
          expect(subject.parse('e:al+be')).
            to eq(Parsed::Edition.new("al+be"))
        end

        it 'year<=1995 (Cards printed in 1995 and earlier)' do
          expect(subject.parse('year<=1995')).
            to eq(Parsed::ReleaseYear.new("<=", "1995"))
        end
      end

      context "Is:" do
        %w[split vanilla old new future timeshifted funny promo permanent
            spell black-bordered white-bordered sliver-bordered foil].each do |quality|
          it "is:#{quality}" do
            expect(subject.parse("is:#{quality}")).
              to eq(Parsed::Quality.new(quality))
          end
        end
      end

      context "Language" do
        it 'l:de, l:it, l:jp (Uses the abbreviations that are listed on the sitemap)' do
          expect(subject.parse('l:de')).
            to eq(Parsed::Language.new("de"))
        end
      end
    end
  end
end
