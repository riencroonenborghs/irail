module Irail
  module Liveboard
    class Departure < ::Irail::Liveboard::InfoBase
      attr_accessor :id, :delay, :station, :time, :vehicle, :platform, :left

      def self.parse_hash(hash)        
        hash = super
        self.new(hash)
      end
    end # Departure < ::Irail::Liveboard::InfoBase
  end # module Liveboard
end # module Irail