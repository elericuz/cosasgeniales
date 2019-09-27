module ToPostit
  class Site < Sinatra::Application
    get '/' do
      "holi :P"
    end
  end
end