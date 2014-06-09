require 'net/http'
require 'uri'
require 'singleton'
require 'json'

require File.join(File.dirname(__FILE__), 'hash.rb')
require File.join(File.dirname(__FILE__), 'irail', 'http', 'connection.rb')
require File.join(File.dirname(__FILE__), 'irail', 'http', 'api_request.rb')
require File.join(File.dirname(__FILE__), 'irail', 'base.rb')
require File.join(File.dirname(__FILE__), 'irail', 'station.rb')
require File.join(File.dirname(__FILE__), 'irail', 'connection', 'connection.rb')
require File.join(File.dirname(__FILE__), 'irail', 'connection', 'info_base.rb')
require File.join(File.dirname(__FILE__), 'irail', 'connection', 'departure.rb')
require File.join(File.dirname(__FILE__), 'irail', 'connection', 'arrival.rb')
require File.join(File.dirname(__FILE__), 'irail', 'connection', 'platform.rb')
require File.join(File.dirname(__FILE__), 'irail', 'connection', 'via_time.rb')
require File.join(File.dirname(__FILE__), 'irail', 'connection', 'via.rb')
require File.join(File.dirname(__FILE__), 'irail', 'liveboard', 'liveboard.rb')
require File.join(File.dirname(__FILE__), 'irail', 'liveboard', 'info_base.rb')
require File.join(File.dirname(__FILE__), 'irail', 'liveboard', 'departure.rb')
require File.join(File.dirname(__FILE__), 'irail', 'liveboard', 'arrival.rb')
require File.join(File.dirname(__FILE__), 'irail', 'vehicle', 'vehicle.rb')
require File.join(File.dirname(__FILE__), 'irail', 'vehicle', 'info.rb')
require File.join(File.dirname(__FILE__), 'irail', 'vehicle', 'stop.rb')

module Irail
  class Exception < ::Exception; end
end