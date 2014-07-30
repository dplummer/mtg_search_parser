module MtgSearchParser
  class NotGroup
    attr_reader :token

    def initialize(token)
      @token = token
    end

    def ==(o)
      o.class == self.class && o.token == token
    end
  end
end
