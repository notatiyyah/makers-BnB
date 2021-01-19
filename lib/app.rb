require 'sinatra/base'
require_relative "users"

class App < Sinatra::Base

  get "/test" do
    'Testing infrastructure working!'
  end

  get '/users/signed_up' do
    'You have signed in!'
  end

  get "/users/new" do
    erb :'index'
  end

  post '/users/signed_up' do
    Users.create(username: params[:username], password: params[:password])
    redirect '/users/signed_up'
  end

  get '/users/login' do
   erb :'sign_in'
  end

  post '/users/logged_in' do
    @user = Users.check(username: params[:username])
    if @user == 0
      redirect '/users/new'
    else
      redirect '/users/logged_in'
    end
  end

  get '/users/logged_in' do
    "you have logged_in"
  end

  run! if app_file == $0
end
