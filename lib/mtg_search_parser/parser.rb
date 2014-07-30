module MtgSearchParser
  class Parser
    def parse(contents)
      case contents

      when /\Ac!([wubrgmlc]+)\z/i
        MtgSearchParser::Parsed::ExactColor.new($1)

      when /\Ac:([wubrgmlc]+)\z/i
        MtgSearchParser::Parsed::AnyColor.new($1)

      when /\Aci:([wubrgmlc]+)\z/i
        MtgSearchParser::Parsed::ColorIdentity.new($1)

      when /\At:"([^"]+)"\z/i, /\At:(.+)\z/i
        MtgSearchParser::Parsed::CardType.new($1)

      when /\Ao:"?([^"]+)"?\z/i
        MtgSearchParser::Parsed::RulesText.new($1)

      when /\Amana(=|>=|<=|>|<)(.+)\z/i
        MtgSearchParser::Parsed::ManaCost.new($1, $2)

      when /\A(pow|tou|cmc)(=|>=|<=|>|<)(pow|tou|cmc|\*|[0-9]+)\z/i
        MtgSearchParser::Parsed::PowerToughCompare.new($1, $2, $3)

      when /\Ar:(mythic|uncommon|common|rare|promo)\z/i
        MtgSearchParser::Parsed::Rarity.new($1)

      when /\Aa:"(.+)"\z/i, /\Aa:(.+)\z/i
        MtgSearchParser::Parsed::Artist.new($1)

      when /\Af:(standard|block|extended|vintage|classic|legacy|modern|commander)\z/i
        MtgSearchParser::Parsed::Legal.new($1)

      when /\Abanned:(standard|block|extended|vintage|classic|legacy|modern|commander)\z/i
        MtgSearchParser::Parsed::Banned.new($1)

      when /\Ae:(.+)\z/i
        MtgSearchParser::Parsed::Edition.new($1)

      when /\Al:(.+)\z/i
        MtgSearchParser::Parsed::Language.new($1)

      when /\Ayear(=|>=|<=|>|<)(.+)\z/i
        MtgSearchParser::Parsed::ReleaseYear.new($1, $2)

      when /\Ais:(.+)\z/i
        MtgSearchParser::Parsed::Quality.new($1)

      when /\A!(.+)\z/
        MtgSearchParser::Parsed::ExactName.new($1)
      when /\A"([^"]+)"\z/
        MtgSearchParser::Parsed::Name.new($1)
      else
        MtgSearchParser::Parsed::Name.new(contents)
      end
    end
  end
end
