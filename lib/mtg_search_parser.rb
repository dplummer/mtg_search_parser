module MtgSearchParser
end

require "mtg_search_parser/version"
require "mtg_search_parser/nodes/node"
require "mtg_search_parser/nodes/and"
require "mtg_search_parser/nodes/left_paren"
require "mtg_search_parser/nodes/not"
require "mtg_search_parser/nodes/or"
require "mtg_search_parser/nodes/query"
require "mtg_search_parser/nodes/right_paren"

require "mtg_search_parser/parsed/base"
require "mtg_search_parser/parsed/exact_name"
require "mtg_search_parser/parsed/name"
require "mtg_search_parser/parsed/rules_text"
require "mtg_search_parser/parsed/card_type"
require "mtg_search_parser/parsed/any_color"
require "mtg_search_parser/parsed/exact_color"
require "mtg_search_parser/parsed/color_identity"
require "mtg_search_parser/parsed/mana_cost"
require "mtg_search_parser/parsed/power_tough_compare"
require "mtg_search_parser/parsed/legal"
require "mtg_search_parser/parsed/banned"
require "mtg_search_parser/parsed/artist"
require "mtg_search_parser/parsed/rarity"
require "mtg_search_parser/parsed/edition"
require "mtg_search_parser/parsed/release_year"
require "mtg_search_parser/parsed/language"
require "mtg_search_parser/parsed/quality"

require "mtg_search_parser/or_group"

require "mtg_search_parser/parser"
require "mtg_search_parser/lexer"


module MtgSearchParser
  def self.parse(string)
    parser = MtgSearchParser::Parser.new

    tokens = Lexer.new.lex(string)
    parsed = []

    while token = tokens.shift
      case token
      when MtgSearchParser::Nodes::Query
        parsed << parser.parse(token.contents)
      when MtgSearchParser::Nodes::Or
        next_token = tokens.shift
        if next_token
          parsed << MtgSearchParser::OrGroup.new([parsed.pop,
                                                  parser.parse(next_token.contents)])
        end
      else
        parsed << token
      end
    end

    parsed
  end
end
