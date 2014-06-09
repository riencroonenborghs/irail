module Irail
  module Connection
    class Via < ::Irail::Base
      attr_accessor :id, :arrival, :departure, :time_between, :station, :vehicle, :direction

      def self.parse_hash(hash)
        hash.delete('station')

        arrival   = ViaTime.parse_hash(hash.delete('arrival'))
        departure = ViaTime.parse_hash(hash.delete('departure'))
        station   = ::Irail::Station.send(:parse_hash, hash.delete('stationinfo'))
        direction = ::Irail::Station.send(:parse_hash, hash.delete('direction'))
        hash['time_between'] = hash.delete('timeBetween')

        self.new(hash.merge(arrival: arrival, departure: departure, station: station, direction: direction))
      end
    end # class Via < ::Irail::Base
  end # module Connection
end # module Irail