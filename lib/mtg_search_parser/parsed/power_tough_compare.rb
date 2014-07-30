module MtgSearchParser
  module Parsed
    class PowerToughCompare < Base
      attr_reader :left, :op, :right

      def initialize(left, op, right)
        @left = left
        @op = op
        @right = right
      end

      def ==(o)
        o.class == self.class &&
          o.left == left &&
          o.op == op &&
          o.right == right
      end
    end
  end
end
