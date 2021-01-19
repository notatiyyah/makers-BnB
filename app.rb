require 'sinatra/base'

class App < Sinatra::Base

  get "/test" do
    'Testing infrastructure working!'
  end

  get "/" do
    erb :index
  end

  run! if app_file == $0
end
