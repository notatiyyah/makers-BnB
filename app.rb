require 'sinatra/base'
require './lib/session'

class App < Sinatra::Base
  enable :sessions

  get "/test" do
    'Testing infrastructure working!'
  end

  get "/" do
    erb :index
  end

  get "/login" do
    erb :login
  end

  get "/test_login" do
    session[:user_id] = 12
  end

  get "/spaces" do
    logged_in = Session.check(session[:user_id])
    if not logged_in
      redirect to "/"
    end
    erb :spaces
  end

  get "/spaces/new" do
    logged_in = Session.check(session[:user_id])
    if not logged_in
      redirect to "/"
    end
    erb :spaces_new
  end

  get "/requests" do
    logged_in = Session.check(session[:user_id])
    if not logged_in
      redirect to "/"
    end
    erb :requests
  end

  get "/spaces/:id" do
    logged_in = Session.check(session[:user_id])
    if not logged_in
      redirect to "/"
    end
    @id = params[:id]
    erb :calendar
  end

  get "/requests_list" do
    logged_in = Session.check(session[:user_id])
    if not logged_in
      redirect to "/"
    end
    erb :requests_list
  end

  run! if app_file == $0
end
