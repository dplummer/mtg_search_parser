module MtgSearchParser
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
              completed_tokens << Nodes::LeftParen.new
            when ')'
              completed_tokens << Nodes::RightParen.new
            when '-'
              completed_tokens << Nodes::Not.new
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
            completed_tokens << Nodes::Query.new(current_letters)
            state = :blank
            current_letters = ""
          end
        when :term
          case letter
          when '"'
            current_letters << letter
            state = :quoted_term
          when /^\s*$/
            completed_tokens << complete_node(current_letters)
            state = :blank
            current_letters = ""
          when ')'
            completed_tokens << complete_node(current_letters) << Nodes::RightParen.new
            state = :blank
            current_letters = ""
          else
            current_letters << letter
          end
        end
      end

      completed_tokens << Nodes::Query.new(current_letters)

      completed_tokens.reject(&:blank?)
    end

    def blank?(letter)
      letter =~ /^\s*$/
    end

    def complete_node(letters)
      case letters.downcase
      when 'and'
        Nodes::And.new
      when 'or'
        Nodes::Or.new
      when 'not'
        Nodes::Not.new
      else
        Nodes::Query.new(letters)
      end
    end
  end
end
