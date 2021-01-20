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
    Property.list_by_availability(true).map(&:name).join(',')
  end

  # get "/spaces/new" do
    
  # end

  # get "/spaces/:id" do
    
  # end

  # get "/requests" do
    
  # end

  # get "/requests/:id" do
    
  # end

  run! if app_file == $0
end
