module Irail
  module Vehicle
    class Vehicle < ::Irail::Base
      attr_accessor :vehicle, :info, :stops

      API_NAME = '/vehicle/'
      
      def self.find(id)
        options = {id: id, fast: true}
        parse_response(api_request.request(API_NAME, options))
      end

    private

      def self.parse_response(response)
        vehicle = response['vehicle']
        info    =  ::Irail::Vehicle::Info.send(:parse_hash, response['vehicleinfo'])
        stops   = response['stops']['stop'].map {|hash| ::Irail::Vehicle::Stop.send(:parse_hash, hash) }
        self.new(vehicle: vehicle, info: info, stops: stops)        
      end
      
    end # class Vehicle
  end # module Vehicle
end  # module Irail