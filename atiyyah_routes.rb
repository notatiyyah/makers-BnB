require 'sinatra/base'
require './lib/property'
require './lib/booking'
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
    Property.list_by_availability(true).map(&:name).join(', ')
  end

  # get "/spaces/:id" do
    
  # end

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

  # get "/requests" do
    
  # end

  # get "/requests/:id" do
    
  # end

  run! if app_file == $0
end
