require_relative 'atiyyah_routes.rb'
require './lib/database_connection'
require './spec/database_helper.rb'

ENV["ENVIRONMENT"] = "testing"
set_up_test_env
DatabaseConnection.connect
run MakersBnBApp