module MtgSearchParser
  module Nodes
    class Node
      def blank?
        false
      end

      def ==(o)
        o.class == self.class
      end
    end
  end
end
