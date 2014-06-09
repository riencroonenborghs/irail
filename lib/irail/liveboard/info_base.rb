module Irail
  module Liveboard
    class InfoBase < ::Irail::Base
      attr_accessor :id, :delay, :station, :time, :vehicle, :platform, :left

      def self.parse_hash(hash)        
        hash.delete('station')
        hash.delete('platform')

        station   = ::Irail::Station.send(:parse_hash, hash.delete('stationinfo'))
        platform  = ::Irail::Connection::Platform.parse_hash(hash.delete('platforminfo'))
        time      = parse_unix_time(hash.delete('time'))
        hash.merge(station: station, platform: platform, time: time)
      end
    end # class InfoBase < ::Irail::Base
  end # module Liveboard
end # module Irail