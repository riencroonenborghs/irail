module Irail
  module Vehicle
    class Info < ::Irail::Base
      attr_accessor :location_x, :location_y, :name

      def self.parse_hash(hash)
        location_x  = hash['locationX']
        location_y  = hash['locationY']
        name        = hash['name']
        self.new(location_x: location_x, location_y: location_y, name: name)
      end
    end # Info < ::Irail::Base
  end # module Vehicle
end # module Irail