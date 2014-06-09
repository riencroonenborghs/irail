require 'spec_helper'
require 'net/http'

describe Irail::Http::ApiRequest do
  it "should request json formatted response" do
    ::Net::HTTP.any_instance.should_receive(:get).with('/foo/?format=json')
    ::Net::HTTP.any_instance.stub(:get).and_return(Struct.new(:body).new("{\"foo\":\"bar\"}"))
    ::Irail::Http::ApiRequest.instance.request('/foo/')
  end  
end
