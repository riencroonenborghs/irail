module Irail
  module Liveboard
    class Liveboard < ::Irail::Base
      attr_accessor :station, :departures, :arrivals

      API_NAME = '/liveboard/'
      
      def self.departures(station_name, datetime)
        find(station_name, {date: datetime.strftime('%d%m%y'), time: datetime.strftime('%H%M'), arrdep: 'departure'})
      end

      def self.arrivals(station_name, datetime)
        find(station_name, {date: datetime.strftime('%d%m%y'), time: datetime.strftime('%H%M'), arrdep: 'arrival'})
      end

    private

      def self.find(station, options = {})
        options = {fast: true, station: station}.merge!(sanitize_options(options))
        parse_response(api_request.request(API_NAME, options))
      end

      def self.parse_response(response)
        station = ::Irail::Station.send(:parse_hash, response['stationinfo'])
        departures = response['departures']['departure'].map{|hash| ::Irail::Liveboard::Departure.parse_hash(hash) } if response['departures']
        arrivals = response['arrivals']['arrival'].map{|hash| ::Irail::Liveboard::Arrival.parse_hash(hash) } if response['arrivals']

        self.new(station: station, departures: departures, arrivals: arrivals)        
      end

      VALID_ARRDEP = ['departure', 'arrival']

      def self.sanitize_options(options)
        options.stringify_keys!
        id      = options.delete('id')  
        date    = options.delete('date')
        time    = options.delete('time')
        arrdep = options.delete('arrdep')

        raise ::Irail::Exception.new "#{options.keys.first} option is not valid" unless options.keys.empty?
        raise ::Irail::Exception.new "arrdep can only be '#{VALID_ARRDEP.join("' or '")}'" unless arrdep.nil? || VALID_ARRDEP.include?(arrdep)

        result = {}
        result.merge!(id: id) if id
        result.merge!(date: date) if date
        result.merge!(time: time) if time
        result.merge!(arrdep: arrdep) if arrdep
        result
      end
    end # class Liveboard
  end # module Liveboard
end  # module Irail