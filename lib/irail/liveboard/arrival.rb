module Irail
  module Liveboard
    class Arrival < ::Irail::Liveboard::InfoBase
      attr_accessor :id, :delay, :station, :time, :vehicle, :platform, :left

      def self.parse_hash(hash)        
        hash = super
        self.new(hash)
      end
    end # class Arrival < ::Irail::Liveboard::InfoBase
  end # module Liveboard
end # module Irail