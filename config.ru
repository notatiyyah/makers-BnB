require_relative 'rayhan_app.rb'
require './lib/database_connection'
require './spec/database_helper.rb'

ENV["ENVIRONMENT"] = "testing"
set_up_test_env
DatabaseConnection.connect
run App
