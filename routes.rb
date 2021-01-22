require 'sinatra'
require 'sinatra/flash'
require 'sinatra/base'
require './lib/property'
require './lib/booking'
require './lib/users'
require './lib/session'
require './lib/availability'
require './lib/database_connection'

class MakersBnBApp < Sinatra::Base
  enable :sessions
  set :session_secret, 'super secret'
  register Sinatra::Flash

  before do
    logged_in = Session.check(session[:user_id], request.path_info.split('/')[1])
    redirect to "/" unless logged_in
    @logged_in = session[:user_id]
    # Only allows user on certain pages if they aren't signed in
  end

  get "/debug/test" do  #debug
    'Testing infrastructure working!'
  end

  get '/debug/log_in' do #debug
    session[:user_id] = 1 if ENV["ENVIRONMENT"] == "testing"
  end

  # user routes

  get "/" do
    erb :index
  end

  post '/sign_up' do
    Users.create(email: params[:email], password: params[:password], first_name: params[:first_name], surname: params[:surname])
    flash[:sign_up_message] = 'You have signed up!'
    redirect "/sessions/new"
  end

  get '/sessions/new' do
   erb :login
  end

  post '/sessions/log_in' do
    user = Users.check(email: params[:email], password: params[:password])
    if user == 0
      flash[:warning] = "Incorrect Username or Password"
      redirect '/'
    else
      session[:user_id] = DatabaseConnection.query("SELECT user_id FROM users WHERE username = '#{params[:email]}'").getvalue(0,0)
      flash[:sign_in_message] = "You have logged in with '#{params[:email]}'"
      redirect "/spaces"
    end
  end

  get '/sessions/log_out' do
    session[:user_id] = nil
    p "USERID"
    p session[:user_id]
    flash[:sign_out_message] = "You have logged out"
    redirect "/"
  end

  # spaces routes

  get "/spaces" do
    if params[:property_ids] == "" || params[:property_ids].nil?
      @properties = Property.list
    else
      @properties = []
      property_ids = params[:property_ids].slice(1,params[:property_ids].length-2).split(",").map{ |property_id| @properties.concat Property.list_by_id(property_id) }
      @start_date = params[:start_date]
      @end_date = params[:end_date]
    end
    erb :spaces
  end

  post "/spaces" do
    begin
      property_ids = Availability.list_by_availability(params["start_date"], params["end_date"]).map(&:property_id)
      redirect "/spaces?property_ids=#{property_ids}"
    rescue PG::InvalidDatetimeFormat
    rescue NoMethodError
      redirect "/spaces?property_ids=#{property_ids}"
    end
  end

  get "/spaces/new" do
    @user_id = session[:user_id]
    erb :spaces_new
  end

  post "/spaces/new" do
    Property.new(params)
    flash[:new_space] = "Listing Added!"
    redirect "/spaces"
  end

  get "/spaces/:property_id" do
    @user_id = session[:user_id]
    begin
      @property = Property.list_by_id(params[:property_id])[0]
      @user_has_submitted_request = Booking.list_by_user(@user_id).map(&:property_id).include? @property.property_id
    rescue NoMethodError => exception
      @exception = exception
    end
    erb :calendar
  end

  post "/spaces/:property_id" do
    p params
    params["start_date"] = "2021-01-01"
    params["end_date"] = "2021-01-02"
    Booking.new(params)
    flash[:new_booking] = "Booking Submitted"
    #NOT DONE
    redirect "/spaces/#{params[:property_id]}"
  end

  # requests routes

  get "/requests" do
    sent_requests = Booking.list_by_user(1)
    #output = ["Requests I've made", "<li>"]
    @sent_requests = []
    sent_requests.each{ |booking| @sent_requests <<  Property.list_by_id(booking.property_id)[0] }
    #output << "<ul><a href='/spaces/#{property.property_id}' id='sent_requests'>#{property.name}</a></ul>"

    #output << "</li> Requests I've received"
    received_requests = Booking.list_by_owner(1)
    @received_requests = []
    received_requests.each{ |booking| @received_requests << Property.list_by_id(booking.property_id)[0] }
    #output << "<ul><a href='/requests/#{booking.booking_id}' id='received_requests'>#{property.name}</a></ul>"
    #erb NOT DONE YET
  end

  get "/requests/:booking_id" do
    @this_booking = Booking.list_by_id(params[:booking_id])[0]
    @requestee = Users.single_user_id(user_id: @this_booking.user_id)[0]
    @this_property = Property.list_by_id(@this_booking.property_id)[0]
    @other_bookings = Booking.list_by_property(@this_property.property_id)
    @there_are_other_bookings = @other_bookings.length > 1 || !(@other_bookings.length == 1 && @other_bookings.map(&:booking_id).include?(@this_booking.booking_id))
    erb :requests
  end

  run! if app_file == $0
end
