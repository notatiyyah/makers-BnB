require 'sinatra/base'
require './lib/users'

class App < Sinatra::Base

  get "/test" do
    'Testing infrastructure working!'
  end

  get '/users/signed_up' do
    'You have signed up!'
  end

  get "/users/new" do
    erb :'index'
  end

  post '/signed_up' do
    Users.create(email: params[:email], password: params[:password])
    redirect '/users/signed_up'
  end

  get '/users/login' do
   erb :'login'
  end

  post '/logged_in' do
    @user = Users.check(email: params[:email], password: params[:password])
    if @user == 0
      redirect '/users/new'
    else
      redirect '/users/logged_in'
    end
  end

  get '/users/logged_in' do
    "You have logged in!"
  end

  run! if app_file == $0
end
