module MtgSearchParser
  class Node
    def blank?
      false
    end

    def ==(o)
      o.class = self.class
    end
  end

  class QueryNode < Node
    attr_reader :contents

    def initialize(contents)
      @contents = contents
    end

    def blank?
      contents =~ /^\s*$/
    end

    def ==(o)
      o.class == QueryNode && o.contents == contents
    end
  end

  AndNode        = Class.new(Node)
  OrNode         = Class.new(Node)
  LeftParenNode  = Class.new(Node)
  RightParenNode = Class.new(Node)

  class Lexer
    def lex(string)
      state = :blank
      current_letters = ""
      completed_tokens = []

      string.each_char do |letter|
        case state
        when :blank
          if !blank?(letter)
            case letter
            when '('
              completed_tokens << LeftParenNode.new
            when ')'
              completed_tokens << RightParenNode.new
            else
              current_letters << letter
              if letter == '"'
                state = :quoted_term
              elsif letter == '!'
                state = :exact_name
              else
                state = :term
              end
            end
          end
        when :exact_name
          current_letters << letter
        when :quoted_term
          current_letters << letter
          if letter == '"'
            completed_tokens << QueryNode.new(current_letters)
            state = :blank
            current_letters = ""
          end
        when :term
          if letter == '"'
            current_letters << letter
            state = :quoted_term
          elsif blank?(letter)
            completed_tokens << QueryNode.new(current_letters)
            state = :blank
            current_letters = ""
          else
            current_letters << letter
          end
        end
      end

      completed_tokens << QueryNode.new(current_letters)

      completed_tokens.reject(&:blank?)
    end

    def blank?(letter)
      letter =~ /^\s*$/
    end
  end
end
