require 'sinatra/base'
require './lib/users'
require './lib/session'

class App < Sinatra::Base
  enable :sessions
  set :session_secret, 'super secret'


  get "/not-allowed" do
    "<p>You must log in or sign up to access this page.<p>
    <li>
    <ul><a href='/users/new'>Sign Up</a></ul>
    <ul><a href='/users/login'>Log In</a></ul>
    /<li>"
  end

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
    Users.create(email: params[:email], password: params[:password], first_name: params[:first_name], surname: params[:surname])
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
    session[:user_id] = 12
    "You have logged in!"
  end

  get '/session_works' do
    logged_in = Session.check(session[:user_id])
    if not logged_in
      redirect to "/users/new"
    else
      "you are on this page"
    end
  end

  get '/users/signed_out' do
    session[:user_id] = nil
    'im out'
  end


  run! if app_file == $0
end
