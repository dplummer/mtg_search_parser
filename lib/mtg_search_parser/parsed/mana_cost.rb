module MtgSearchParser
  module Parsed
    class ManaCost < Base
      attr_reader :operator, :mana_cost

      def initialize(operator, mana_cost)
        @operator = operator
        @mana_cost = mana_cost
      end

      def ==(o)
        o.class == self.class &&
          o.operator == operator &&
          o.mana_cost == mana_cost
      end
    end
  end
end
