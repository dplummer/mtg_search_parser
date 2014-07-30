module MtgSearchParser
  class Parser
    def parse(contents)
      case contents

      ## Edition code
      #when /\Ae:([a-z0-9,+]+)(\/[a-z]{1,2})?\z/i
      #  scope = edition_query(scope, $1)

      ## color
      #when /c(!|:)([wubrgmlc]+)/i
      #  comparitor = $1
      #  values = $2.downcase

      #  scope = color(scope, comparitor, values)

      ## types
      #when /\At:"([^"]+)"\z/i, /\At:(.+)\z/i
      #  type = $1
      #  scope = card_type_query(scope, type)

      ## card text
      #when /\Ao:"?([^"]+)"?\z/i
      #  scope = text_query(scope, $1)

      ## mana cost
      #when /\Amana=(.+)\z/i
      #  scope = exact_mana_cost_query(scope, $1)

      # name
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
