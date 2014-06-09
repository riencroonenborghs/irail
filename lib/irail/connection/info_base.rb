module Irail
  module Connection
    class InfoBase < ::Irail::Base
      attr_accessor :delay, :station, :time, :vehicle, :platform, :direction

      def self.parse_hash(hash)        
        hash.delete('station')
        hash.delete('platform')

        station   = ::Irail::Station.send(:parse_hash, hash.delete('stationinfo'))
        platform  = Platform.parse_hash(hash.delete('platforminfo'))
        direction = ::Irail::Station.send(:parse_hash, hash.delete('direction'))
        time      = parse_unix_time(hash.delete('time'))
        hash.merge(station: station, direction: direction, platform: platform, time: time)
      end
    end # class InfoBase < ::Irail::Base
  end # module Connection
end # module Irail