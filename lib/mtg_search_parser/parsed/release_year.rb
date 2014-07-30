module MtgSearchParser
  module Parsed
    class ReleaseYear < Base
      attr_reader :operator, :year

      def initialize(operator, year)
        @operator = operator
        @year = year
      end

      def ==(o)
        o.class == self.class &&
          o.operator == operator &&
          o.year == year
      end
    end
  end
end
