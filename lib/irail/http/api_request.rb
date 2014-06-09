module Irail
  module Http
    class ApiRequest < Connection
      include ::Singleton

      def request(path, params = {})
        params = {format: 'json'}.merge!(params)
        super
      end

    end # class ApiRequest
  end # module Http
end # module Irail