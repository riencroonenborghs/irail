require 'spec_helper'

describe Irail::Base do
  class Foo < ::Irail::Base
    attr_accessor :foo, :bar
  end

  context "#new" do
    it "should init easily" do
      foo = Foo.new(foo: 'olaf', bar: 'polaf')
      foo.foo.should == 'olaf'
      foo.bar.should == 'polaf'
    end

    it "should ignore params" do
      foo = Foo.new(foo: 'olaf', baz: 'polaf')
      foo.foo.should == 'olaf'
      foo.bar.should be_nil
    end
  end

  it "should return api request instance" do
    api_request = Foo.api_request
    api_request.should_not be_nil
    api_request.class.should == ::Irail::Http::ApiRequest

    another_api_request = Foo.api_request
    another_api_request.should == api_request
  end
end
