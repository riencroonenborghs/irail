module Irail
  module Connection
    class Platform < ::Irail::Base
      attr_accessor :name, :normal

      def self.parse_hash(hash)
        self.new(hash)
      end
    end # class Platform < ::Irail::Base
  end # module Connection
end # module Irail