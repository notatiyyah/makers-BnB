require 'sinatra/base'

class App < Sinatra::Base

  get "/test" do
    'Testing infrastructure working!'
  end

  get "/" do
    erb :index
  end

  get "/login" do
    erb :login
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

  get "/spaces/:id" do
    @id = params[:id]
    erb :calendar
  end

  get "/requests_list" do
    erb :requests_list
  end

  run! if app_file == $0
end
