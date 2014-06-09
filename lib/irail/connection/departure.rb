module Irail
  module Connection
    class Departure < InfoBase
      def self.parse_hash(hash)       
        hash = super
        self.new(hash)
      end
    end # class Departure < InfoBase
  end # module Connection
end # module Irail