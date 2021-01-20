require_relative 'atiyyah_routes.rb'
require './lib/database_connection'
ENV["ENVIRONMENT"] = "testing"
DatabaseConnection.connect
run MakersBnBApp