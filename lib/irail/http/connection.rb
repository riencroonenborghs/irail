module Irail
  module Http
    class Connection
      attr_reader :http

      def initialize
        @http = Net::HTTP.new(API_BASE_URI, 80) 
      end

      def request(path, params = {})
        path          = path_with_params(path, params)   
        debug("API Request: #{path}")     
        response      = http.get(path)
        json_response = JSON.parse(response.body)
        parse_and_raise_error(json_response) if json_response.keys.include?('error')
        json_response  
      end

    private

      API_BASE_URI = "api.irail.be"

      def parse_and_raise_error(response)
        raise ::Irail::Exception.new(response['message'])
      end

      def path_with_params(path, params)
        encoded_params = URI.encode_www_form(params)
        [path, encoded_params].join("?")
      end

      def debug(message)
        puts "DEBUG::#{Time.now} :: #{message}"
      end

    end # class Connection
  end # module Http
end # module Irail