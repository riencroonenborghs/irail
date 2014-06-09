module Irail
  module Connection
    class Arrival < InfoBase
      def self.parse_hash(hash)       
        hash = super
        self.new(hash)
      end
    end # class Arrival < InfoBase
  end # module Connection
end # module Irail