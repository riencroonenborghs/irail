module Irail
  class Base
    def initialize(hash = {})
      hash.each_pair do |k,v|
        send("#{k}=", v) if respond_to?(k)
      end
    end

    def self.api_request
      ::Irail::Http::ApiRequest.instance
    end

    def self.parse_unix_time(time)
      time = time.to_i unless time.is_a?(Fixnum)
      Time.at(time)
    end

  end # class Base
end # module Irail