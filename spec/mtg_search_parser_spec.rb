require 'spec_helper'

describe MtgSearchParser do
  describe ".parse" do
    it "parses a big long string of lots of tokens" do
      expect(MtgSearchParser.parse("\"Foo Bar\" o:Rule t:Type c:WU mana>=3G "\
                                  "pow<=10 tou=5 cmc>2 f:Modern a:\"Hank Hill\" "\
                                  "e:avr year=1999")).
        to eq([
          MtgSearchParser::Parsed::Name.new("Foo Bar"),
          MtgSearchParser::Parsed::RulesText.new("Rule"),
          MtgSearchParser::Parsed::CardType.new("Type"),
          MtgSearchParser::Parsed::AnyColor.new("WU"),
          MtgSearchParser::Parsed::ManaCost.new(">=", "3G"),
          MtgSearchParser::Parsed::PowerToughCompare.new("pow", "<=", "10"),
          MtgSearchParser::Parsed::PowerToughCompare.new("tou", "=", "5"),
          MtgSearchParser::Parsed::PowerToughCompare.new("cmc", ">", "2"),
          MtgSearchParser::Parsed::Legal.new("Modern"),
          MtgSearchParser::Parsed::Artist.new("Hank Hill"),
          MtgSearchParser::Parsed::Edition.new("avr"),
          MtgSearchParser::Parsed::ReleaseYear.new("=", "1999"),
      ])
    end

    it "groups items OR'd" do
      expect(MtgSearchParser.parse("t:angel OR t:demon")).
        to eq([
          MtgSearchParser::OrGroup.new([
            MtgSearchParser::Parsed::CardType.new("angel"),
            MtgSearchParser::Parsed::CardType.new("demon"),
          ])
        ])
    end
  end
end
