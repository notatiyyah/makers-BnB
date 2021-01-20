require 'sinatra/base'
require './lib/property'
require './lib/booking'
require './lib/database_connection'
## This contains backend functionality & doesn't interfere with webpages

class MakersBnBApp < Sinatra::Base

  get "/test" do
    'Testing infrastructure working!'
  end

  get "/" do
    "Sign Up"
  end

  # get "/sessions/new" do
    
  # end

  get "/spaces" do
    properties = Property.list_by_availability(true)
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
      <input type='hidden' name='owned_by_id' value='1'>
    </form>"
  end

  post "/spaces/new" do
    Property.new(params)
    redirect "/spaces"
  end


  get "/spaces/:property_id" do
    available_properties = Property.list_by_availability(true).map(&:property_id)
    if available_properties.include?(params[:property_id])
      "<form method='post'>
        <input type='hidden' name='user_id' value='1'>
        <input type='hidden' name='property_id' value='#{params[:property_id]}'>
        <input type='submit' name='request' value='Book place'>
      </form>"
    end
  end

  post "/spaces/:property_id" do
    Booking.new(params)
    Property.set_availability(params["property_id"], false)
    "submitted"
  end

  get "/requests" do
    sent_requests = Booking.list_by_owner(1)
    p sent_requests
    output = ["Requests I've made", "<li>"]
    sent_requests.each do |booking|
      property = Property.list_by_id(booking.property_id)[0]
      output << "<ul><a href='/spaces/#{property.property_id}'>#{property.name}</a></ul>"
    end
    output << "</li>"
    return output

  end

  # get "/requests/:id" do
    
  # end

  run! if app_file == $0
end
