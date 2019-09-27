module ToPostit
  Kaminari::Hooks.init

  require "./settings.rb"

  ## Configuration
  Dir.glob("./config/*.rb") { |file| require file }

  ## Import models
  Dir.glob("./api/models/*.rb") {|file| require file}

  ## Import Entities
  Dir.glob("./api/entities/*.rb") { |file| require file }

  class API < Grape::API
    version 'v1', using: :path
    use Rack::JSONP

    content_type :json, "application/json"
    default_format :json

    ## Import models
    Dir.glob("./api/resources/*.rb") { |file| require file }

    mount ToPostit::Resources::Phrases
  end
end