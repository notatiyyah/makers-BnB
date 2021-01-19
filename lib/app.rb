require 'sinatra/base'
require_relative "users"

class App < Sinatra::Base

  get "/test" do
    'Testing infrastructure working!'
  end

  get '/users/users' do
    'you have signed in'
  end

  get "/users/new" do
    erb :'index'
  end

  post '/users/users' do
    Users.create(username: params[:username], password: params[:password])
    redirect '/users/users'
  end

#  post '/makers_bnb' do
#    Users.create(username: params[:username], password: params[:password])
#    redirect '/listings'
#  end

  run! if app_file == $0
end
