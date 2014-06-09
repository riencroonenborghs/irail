require 'spec_helper'
require 'net/http'

describe Irail::Http::Connection do
  it "should init http connection" do
    connection = Irail::Http::Connection.new
    connection.http.should_not be_nil
    connection.http.class.should == Net::HTTP
  end

  context "#path_with_params" do
    let(:connection) { Irail::Http::Connection.new }

    it "should build path with no params" do
      connection.send(:path_with_params, 'foo', {}).should == 'foo?'
    end

    it "should build path with params: ?" do
      connection.send(:path_with_params, 'foo', {'bar' => 'baz'}).should == 'foo?bar=baz'
    end

    it "should build path with params: &" do
      connection.send(:path_with_params, 'foo', {'bar' => 'baz', 'olaf' => 'polaf'}).should == 'foo?bar=baz&olaf=polaf'
    end

    it "should URL encode params" do
      connection.send(:path_with_params, 'foo', {'bar and baz' => 'polaf'}).should == 'foo?bar+and+baz=polaf'
    end
  end

  it "should send request and get response" do
    connection = Irail::Http::Connection.new
    ::Net::HTTP.any_instance.stub(:get).and_return(Struct.new(:body).new("{\"foo\":\"bar\"}"))
    response = connection.request('foo', {})
    response.should_not be_nil
    response.should == {'foo' => 'bar'}
  end
end
