require 'sinatra/base'

class App < Sinatra::Base

  get "/test" do
    'Testing infrastructure working!'
  end

  get "/" do
    erb :index
  end

  get "/spaces" do
    erb :spaces
  end

  get "/spaces/new" do
    erb :spaces_new
  end

  get "/requests" do
    erb :requests
  end

  run! if app_file == $0
end
