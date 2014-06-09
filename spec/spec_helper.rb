Bundler.require :default, :test
require 'rspec/core'
require 'rspec/rails/adapters'
require 'rspec/expectations'

Dir[File.dirname(__FILE__) + '/support/**/*.rb'].each { |f| require f }

RSpec.configure do |config|
  config.before do
  end
end
