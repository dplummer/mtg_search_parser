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

require "mtg_search_parser/not_group"
require "mtg_search_parser/or_group"

require "mtg_search_parser/parser"
require "mtg_search_parser/lexer"


module MtgSearchParser
  def self.parse(string, max_count = Float::INFINITY)
    tokens = Lexer.new.lex(string)
    ParseExecutor.new.parse(tokens)
  end

  class ParseExecutor
    attr_reader :parser

    def initialize
      @parser = MtgSearchParser::Parser.new
    end

    def parse(tokens, max_count = Float::INFINITY)
      token_count = 0
      parsed = []

      while token = tokens.shift
        token_count += 1

        case token
        when MtgSearchParser::Nodes::RightParen
          break
        when MtgSearchParser::Nodes::LeftParen
          parsed << parse(tokens)
        when MtgSearchParser::Nodes::Query
          parsed << parser.parse(token.contents)
        when MtgSearchParser::Nodes::Or
          parsed << MtgSearchParser::OrGroup.new([parsed.pop] + parse(tokens, 1))
        when MtgSearchParser::Nodes::Not
          parsed << MtgSearchParser::NotGroup.new(parse(tokens, 1))
        else
          parsed << token
        end

        if token_count == max_count
          break
        end
      end

      smart_flatten(parsed)
    end

    private

    def smart_flatten(array)
      if array.length == 1 && array.first.is_a?(Array)
        array.first
      else
        array
      end
    end
  end
end
