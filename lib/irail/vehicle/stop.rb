module Irail
  module Vehicle
    class Stop < ::Irail::Base
      attr_accessor :number, :station, :time, :delay

      def self.parse_hash(hash)
        number  = hash['id'].to_i
        station = hash['station']
        time    = parse_unix_time(hash['time'])
        delay   = hash['delay'].to_i
        self.new(number: number, station: station, time: time, delay: delay)
      end
    end # Stop < ::Irail::Base
  end # module Vehicle
end # module Irail