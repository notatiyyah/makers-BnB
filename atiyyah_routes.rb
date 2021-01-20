require 'sinatra/base'

## This contains backend functionality & doesn't interfere with webpages

class MakersBnBApp < Sinatra::Base

  get "/test" do
    'Testing infrastructure working!'
  end

  get "/" do
    "<h1>Sign Up</h1>"
  end

  # get "/sessions/new" do
    
  # end

  # get "/spaces" do
    
  # end

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
