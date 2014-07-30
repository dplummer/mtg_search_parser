module MtgSearchParser
  module Parsed
    class Base
      attr_reader :contents

      def initialize(contents)
        @contents = contents
      end

      def ==(o)
        o.class == self.class && o.contents == contents
      end
    end
  end
end
