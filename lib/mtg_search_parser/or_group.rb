module MtgSearchParser
  class OrGroup
    attr_reader :tokens

    def initialize(tokens)
      @tokens = tokens
    end

    def ==(o)
      o.class == self.class && o.tokens == tokens
    end
  end
end
