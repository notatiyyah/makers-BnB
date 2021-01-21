require 'sinatra/base'
require './lib/property'
require './lib/booking'
require './lib/users'
require './lib/session'
require './lib/database_connection'

class MakersBnBApp < Sinatra::Base
  enable :sessions
  set :session_secret, 'super secret'

  before do
    logged_in = Session.check(session[:user_id], request.path_info.split('/')[1])
    redirect to "/users/new" unless logged_in
    # Only allows user on certain pages if they aren't signed in
  end

  # debug routes START HERE
  get "/test" do
    'Testing infrastructure working!'
  end

  get '/session_works' do
    "you are on this page"
  end
  # debug routes END HERE

  get '/users/signed_up' do
    'You have signed up!'
  end

  get "/users/new" do
    erb :index
  end

  post '/signed_up' do
    Users.create(email: params[:email], password: params[:password], first_name: params[:first_name], surname: params[:surname])
    redirect '/users/signed_up'
  end

  get '/users/login' do
   erb :login
  end

  post '/logged_in' do
    user = Users.check(email: params[:email], password: params[:password])
    if user == 0
      redirect '/users/new'
    else
      session[:user_id] = DatabaseConnection.query("SELECT user_id FROM users WHERE username = '#{params[:email]}'").getvalue(0,0)
      redirect '/users/logged_in'
    end
  end

  get '/users/logged_in' do
    session[:user_id] = 1 if ENV["ENVIRONMENT"] == "testing"
    "You have logged in!"
  end

  get '/users/signed_out' do
    session[:user_id] = nil
    'im out'
  end

  get "/spaces" do
    properties = Property.list
    output = ["<li>"]
    properties.each do |property|
      output << "<ul><a href='/spaces/#{property.property_id}'>#{property.name}</a></ul>"
    end
    output << "</li>"
    return output
  end

  get "/spaces/new" do
    "<form method='post'>
      <input type='text' name='name'>
      <input type='submit' value='Submit'>
      <input type='hidden' name='owned_by_id' value='#{session[:user_id]}'>
    </form>"
  end

  post "/spaces/new" do
    Property.new(params)
    redirect "/spaces"
  end

  get "/spaces/:property_id" do
    properties = Property.list.map(&:property_id)
    if properties.include?(params[:property_id])
      output = []
      output << "<form method='post'>
        <input type='hidden' name='user_id' value='#{session[:user_id]}'>
        <input type='hidden' name='property_id' value='#{params[:property_id]}'>"
      output << "<input type='submit' name='request' value='Book place'>" unless Booking.list_by_user(session[:user_id]).map(&:property_id).include? params[:property_id]
      output << "</form>"
      return output
    end
  end

  post "/spaces/:property_id" do
    params["start_date"] = "2021-01-01"
    params["end_date"] = "2021-01-02"
    Booking.new(params)
    "submitted"
  end

  get "/requests" do
    sent_requests = Booking.list_by_user(1)
    output = ["Requests I've made", "<li>"]
    sent_requests.each do |booking|
      property = Property.list_by_id(booking.property_id)[0]
      output << "<ul><a href='/spaces/#{property.property_id}' id='sent_requests'>#{property.name}</a></ul>"
    end

    output << "</li> Requests I've received"
    received_requests = Booking.list_by_owner(1)
    received_requests.each do |booking|
      property = Property.list_by_id(booking.property_id)[0]
      output << "<ul><a href='/requests/#{booking.booking_id}' id='received_requests'>#{property.name}</a></ul>"
    end
    return output
  end

  get "/requests/:booking_id" do
    this_booking = Booking.list_by_id(params[:booking_id])[0]
    this_property = Property.list_by_id(this_booking.property_id)[0]
    output = []
    output << "<h1>Request for '#{this_property.name}'</h1>
    <p>From: #{this_booking.user_id}</p>
    <h2>Other requests for this Space</h2>"
    other_bookings = Booking.list_by_property(this_property.property_id).map
    other_bookings.each do |booking|
      if booking.booking_id != params[:booking_id]
        output << "<ul><a href='/requests/#{booking.booking_id}' id='received_requests'>#{booking.user_id}</a></ul>"
      end
    end
    return output
  end

  run! if app_file == $0
end
