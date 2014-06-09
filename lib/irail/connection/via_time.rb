module Irail
  module Connection
    class ViaTime < ::Irail::Base
      attr_accessor :time, :platform

      def self.parse_hash(hash)
        hash.delete('platform')
        platform = ::Irail::Connection::Platform.parse_hash(hash.delete('platforminfo'))

        self.new(platform: platform, time: parse_unix_time(hash['time']))
      end
    end # class ViaTime < ::Irail::Base
  end # module Connection
end # module Irail