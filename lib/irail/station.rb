module Irail
  class Station < Base
    attr_accessor :id, :location_x, :location_y, :standard_name, :name

    API_NAME = '/stations/'

    class << self

      def all
        parse_response(api_request.request(API_NAME))
      end

    private

      def parse_response(response)
        response['station'].map do |hash|
          parse_hash(hash)
        end
      end

      def parse_hash(hash)
        location_x    = hash.delete('locationX')
        location_y    = hash.delete('locationY')
        standard_name = hash.delete('standardname')
        self.new(hash.merge(location_x: location_x, location_y: location_y, standard_name: standard_name))
      end

    end # class << self
  end # class Station < Base
end # module Irail