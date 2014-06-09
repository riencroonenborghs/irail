require 'spec_helper'

describe Irail::Liveboard::Liveboard do
  context "#find" do
    it "should handle wrong option" do
      expect { Irail::Liveboard::Liveboard.send(:find, 'station', {foo: 'bar'}) }.to raise_error(Irail::Exception, "foo option is not valid")
    end

    it "should handle wrong arrdep" do
      expect { Irail::Liveboard::Liveboard.send(:find, 'station', {arrdep: 'bar'}) }.to raise_error(Irail::Exception, "arrdep can only be 'departure' or 'arrival'")
    end
  end

  let(:liveboard_departure_json) { JSON.parse(File.read("#{File.dirname(__FILE__)}/../../../data/liveboard_departure.json")) }
  let(:liveboard_arrival_json) { JSON.parse(File.read("#{File.dirname(__FILE__)}/../../../data/liveboard_arrival.json")) }
  let(:station) { 'station' }
  let(:datetime) { Time.now }


  it "should return departures" do
    Irail::Http::ApiRequest.any_instance.stub(:request).and_return(liveboard_departure_json)
    liveboard = Irail::Liveboard::Liveboard.departures(station, datetime)
    liveboard.should_not be_nil
    liveboard.arrivals.should be_nil
    liveboard.departures.size.should == 3
    departure = liveboard.departures.first
    departure.delay.should == '0'
    departure.left.should == '0'
    departure.platform.should_not be_nil
    departure.platform.name.should == '3'    
    departure.station.should_not be_nil
    departure.station.name.should == 'Antwerpen-Centraal [NMBS/SNCB]'
    departure.time.should == Time.parse('2014-06-09 18:24:00 +1200')
    departure.vehicle.should == "BE.NMBS.IR2929"
    liveboard.station.should_not be_nil
    liveboard.station.name.should == "Diest"
  end

  it "should return arrivals" do
    Irail::Http::ApiRequest.any_instance.stub(:request).and_return(liveboard_arrival_json)
    liveboard = Irail::Liveboard::Liveboard.arrivals(station, datetime)
    liveboard.should_not be_nil
    liveboard.departures.should be_nil
    liveboard.arrivals.size.should == 3
    arrival = liveboard.arrivals.first
    arrival.delay.should == '0'
    arrival.left.should == '0'
    arrival.platform.should_not be_nil
    arrival.platform.name.should == '3'    
    arrival.station.should_not be_nil
    arrival.station.name.should == ''
    arrival.time.should == Time.parse('2014-06-09 18:34:00 +1200')
    arrival.vehicle.should == "BE.NMBS.IR2907"
    liveboard.station.should_not be_nil
    liveboard.station.name.should == "Diest"
  end
end