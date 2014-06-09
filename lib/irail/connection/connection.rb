module Irail
  module Connection
    class Connection < Base
      attr_accessor :id, :departure, :arrival, :duration, :vias

      API_NAME = '/connections/'

      def self.departures(from, to, datetime)
        find(from, to, {date: datetime.strftime('%d%m%y'), time: datetime.strftime('%H%M'), time_sel: 'depart'})
      end

      def self.arrivals(from, to, datetime)
        find(from, to, {date: datetime.strftime('%d%m%y'), time: datetime.strftime('%H%M'), time_sel: 'arrive'})
      end

    private

      def self.find(from, to, options = {})
        options = {from: from, to: to}.merge!(sanitize_options(options))
        parse_response(api_request.request(API_NAME, options))
      end

      def self.parse_response(response)
        response['connection'].map do |hash|
          departure = ::Irail::Connection::Departure.parse_hash(hash.delete('departure'))
          arrival   = ::Irail::Connection::Arrival.parse_hash(hash.delete('arrival'))
          vias      = hash.delete('vias')['via'].map{|via_hash| ::Irail::Connection::Via.parse_hash(via_hash)}
          self.new(hash.merge(departure: departure, arrival: arrival, vias: vias))          
        end
      end

      VALID_TIME_SEL = ['depart', 'arrive']
      VALID_TYPE_OF_TRANSPORT = ['train', 'bus', 'taxi']

      def self.sanitize_options(options)        
        options.stringify_keys!
        date              = options.delete('date')
        time              = options.delete('time')
        time_sel          = options.delete('time_sel')

        # type_of_transport = options.delete('type_of_transport')

        raise ::Irail::Exception.new "#{options.keys.first} option is not valid" unless options.keys.empty?
        raise ::Irail::Exception.new "time_sel can only be '#{VALID_TIME_SEL.join("' or '")}'" unless time_sel.nil? || VALID_TIME_SEL.include?(time_sel)
        # raise ::Irail::Exception.new "type_of_transport can only be '#{VALID_TYPE_OF_TRANSPORT.join("' or '")}'" unless type_of_transport.nil? || VALID_TYPE_OF_TRANSPORT.include?(type_of_transport)

        result = {}
        result.merge!(date: date) if date
        result.merge!(time: time) if time
        result.merge!('timeSel' => time_sel) if time_sel
        # result.merge!('typeOfTransport' => type_of_transport) if type_of_transport
        result
      end
    end # class Connection
  end # module Connection
end  # module Irail