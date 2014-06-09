require 'spec_helper'

describe Irail::Vehicle::Vehicle do
  let(:vehicle_json) { JSON.parse(File.read("#{File.dirname(__FILE__)}/../../../data/vehicle.json")) }
  let(:id) { 'id' }

  it "should return vehicle" do
    Irail::Http::ApiRequest.any_instance.stub(:request).and_return(vehicle_json)
    vehicle = Irail::Vehicle::Vehicle.find(id)
    vehicle.vehicle.should == 'BE.NMBS.IC1843'
    vehicle.info.should_not be_nil
    vehicle.info.location_x.should == '0'
    vehicle.info.location_y.should == '0'
    vehicle.info.name.should == 'BE.NMBS.IC1843'
    vehicle.stops.should_not be_nil
    vehicle.stops.size.should == 8
    stop = vehicle.stops.first
    stop.number.should == 0
    stop.station.should == 'Antwerp (Antwerpen)-Centraal'
    stop.time.should == Time.parse('2014-06-10 07:35:00 +1200')
    stop.delay.should == 0
  end
end