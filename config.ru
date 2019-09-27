require "bundler"
Bundler.require :default

require './app.rb'
require "./api/init.rb"

## CORS
require "rack/cors"
use Rack::Cors do
  allow do
    origins "*"
    resource "*", headers: :any, methods: [:get, :post, :options, :put, :delete]
  end
end

## Run the Sinatra app and Grape API
web = Rack::URLMap.new("/" => ToPostit::Site)
run Rack::Cascade.new [ToPostit::API, web]