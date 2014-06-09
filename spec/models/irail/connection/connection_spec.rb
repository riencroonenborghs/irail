require 'spec_helper'

describe Irail::Connection::Connection do
  context "#find" do
    it "should handle wrong option" do
      expect { Irail::Connection::Connection.send(:find, 'from', 'to', {foo: 'bar'}) }.to raise_error(Irail::Exception, "foo option is not valid")
    end

    it "should handle wrong time_sel" do
      expect { Irail::Connection::Connection.send(:find, 'from', 'to', {time_sel: 'bar'}) }.to raise_error(Irail::Exception, "time_sel can only be 'depart' or 'arrive'")
    end
  end

  let(:connection_departure_json) { JSON.parse(File.read("#{File.dirname(__FILE__)}/../../../data/connection_departure.json")) }
  let(:connection_arrival_json) { JSON.parse(File.read("#{File.dirname(__FILE__)}/../../../data/connection_arrival.json")) }
  let(:from) { 'from' }
  let(:to) { 'to' }
  let(:datetime) { Time.now }


  it "should return departures" do
    Irail::Http::ApiRequest.any_instance.stub(:request).and_return(connection_departure_json)
    connections = Irail::Connection::Connection.departures(from, to, datetime)
    connections.should_not be_nil
    connections.size.should == 6
    connection = connections.first
    connection.arrival.should_not be_nil
    connection.arrival.delay.should == '0'
    connection.arrival.direction.should_not be_nil
    connection.arrival.direction.name.should == 'Ostend'
    connection.arrival.platform.should_not be_nil
    connection.arrival.platform.name.should == '5'    
    connection.arrival.station.should_not be_nil
    connection.arrival.station.name.should == 'Ostend'
    connection.departure.should_not be_nil
    connection.departure.delay.should == '0'
    connection.departure.direction.should_not be_nil
    connection.departure.direction.name.should == 'Antwerp Central'
    connection.departure.platform.should_not be_nil
    connection.departure.platform.name.should == '3'    
    connection.departure.station.should_not be_nil
    connection.departure.station.name.should == 'Diest'
    connection.duration.should == '9960'
    connection.vias.should_not be_nil
    connection.vias.size.should == 1
    via = connection.vias.first
    via.arrival.should_not be_nil
    via.arrival.platform.should_not be_nil
    via.arrival.platform.name.should == '8'
    via.arrival.time.should == Time.parse('2014-06-09 19:13:00 +1200')
    via.departure.should_not be_nil
    via.departure.platform.should_not be_nil
    via.departure.platform.name.should == '6'
    via.departure.time.should == Time.parse('2014-06-09 19:41:00 +1200')
    via.direction.should_not be_nil
    via.direction.name.should == 'Antwerp Central'
    via.station.should_not be_nil
    via.station.name.should == 'Antwerp Berchem'
    via.time_between.should == '1680'
  end

  it "should return arrivals" do
    Irail::Http::ApiRequest.any_instance.stub(:request).and_return(connection_arrival_json)
    connections = Irail::Connection::Connection.arrivals(from, to, datetime)
    connections.should_not be_nil
    connections.size.should == 7
    connection = connections.first
    connection.arrival.should_not be_nil
    connection.arrival.delay.should == '0'
    connection.arrival.direction.should_not be_nil
    connection.arrival.direction.name.should == 'Ostend'
    connection.arrival.platform.should_not be_nil
    connection.arrival.platform.name.should == '4'    
    connection.arrival.station.should_not be_nil
    connection.arrival.station.name.should == 'Ostend'
    connection.departure.should_not be_nil
    connection.departure.delay.should == '0'
    connection.departure.direction.should_not be_nil
    connection.departure.direction.name.should == 'Antwerp Central'
    connection.departure.platform.should_not be_nil
    connection.departure.platform.name.should == '3'    
    connection.departure.station.should_not be_nil
    connection.departure.station.name.should == 'Diest'
    connection.duration.should == '9720'
    connection.vias.should_not be_nil
    connection.vias.size.should == 3
    via = connection.vias.first
    via.arrival.should_not be_nil
    via.arrival.platform.should_not be_nil
    via.arrival.platform.name.should == '2'
    via.arrival.time.should == Time.parse('2014-06-09 04:37:00 +1200')
    via.departure.should_not be_nil
    via.departure.platform.should_not be_nil
    via.departure.platform.name.should == '1'
    via.departure.time.should == Time.parse('2014-06-09 04:41:00 +1200')
    via.direction.should_not be_nil
    via.direction.name.should == 'Antwerp Central'
    via.station.should_not be_nil
    via.station.name.should == 'Aarschot'
    via.time_between.should == '240'
  end
end