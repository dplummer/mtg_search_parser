module MtgSearchParser
  module Nodes
    class Query < Node
      attr_reader :contents

      def initialize(contents)
        @contents = contents
      end

      def blank?
        contents =~ /^\s*$/
      end

      def ==(o)
        super && o.contents == contents
      end
    end
  end
end
