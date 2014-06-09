require 'spec_helper'

describe Irail::Station do
  let(:station_hash) { {'id' => 'id', 'locationX' => 'locationX', 'locationY' => 'locationY', 'standardname' => 'standardname', 'name' => 'name'} }
  let(:station2_hash) { {'id' => 'id2', 'locationX' => 'locationX2', 'locationY' => 'locationY2', 'standardname' => 'standardname2', 'name' => 'name2'} }
  let(:hash_response) { {'station' => [station_hash, station2_hash]}  }

  it "should parse JSON response" do
    stations = ::Irail::Station.send(:parse_response, hash_response)
    stations.size.should == 2

    station = stations.shift
    station.id.should == 'id'
    station.location_x.should == 'locationX'
    station.location_y.should == 'locationY'
    station.standard_name.should == 'standardname'
    station.name.should == 'name'

    station = stations.shift
    station.id.should == 'id2'
    station.location_x.should == 'locationX2'
    station.location_y.should == 'locationY2'
    station.standard_name.should == 'standardname2'
    station.name.should == 'name2'
  end

  it "should parse one hash station" do
    station = ::Irail::Station.send(:parse_hash, station_hash)
    station.id.should == 'id'
    station.location_x.should == 'locationX'
    station.location_y.should == 'locationY'
    station.standard_name.should == 'standardname'
    station.name.should == 'name'
  end

  it "should find all stations" do
    ::Irail::Http::ApiRequest.any_instance.should_receive(:request).with('/stations/')
    ::Irail::Http::ApiRequest.any_instance.stub(:request).and_return(hash_response)

    stations = ::Irail::Station.all
    stations.size.should == 2

    station = stations.shift
    station.id.should == 'id'
    station.location_x.should == 'locationX'
    station.location_y.should == 'locationY'
    station.standard_name.should == 'standardname'
    station.name.should == 'name'

    station = stations.shift
    station.id.should == 'id2'
    station.location_x.should == 'locationX2'
    station.location_y.should == 'locationY2'
    station.standard_name.should == 'standardname2'
    station.name.should == 'name2'
  end

end
