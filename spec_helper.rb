
require 'rack/test'
require 'rspec'
require 'ralyxa'

ENV['RACK_ENV'] = 'test'

RSpec.configure do |config|
  config.before :each do
    Ralyxa.configure do |config|
      config.validate_requests = false
    end
  end
end
