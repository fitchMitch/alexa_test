require 'sinatra'
require 'sinatra/reloader'
require 'ralyxa'
require 'sinatra/json'
require 'json'
class Logger
  # Make Rack::CommonLogger accept a Logger instance
  # without raising undefined method `write' for #<Logger:0x007fc12db61778>
  # makes a method alias using symbols

  alias :write :<<
end

post '/' do
  content_type :json
  Ralyxa::Skill.handle(request)
end
