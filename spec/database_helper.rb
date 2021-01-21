require "./lib/property"

def set_up_test_env
  ENV["ENVIRONMENT"] = "testing"
  DatabaseConnection.connect
  ["users", "properties", "bookings", "availability"].each do |table_name|
    DatabaseConnection.query("TRUNCATE TABLE #{table_name} CASCADE;")
    DatabaseConnection.query("INSERT INTO #{table_name} (SELECT * FROM #{table_name}_base);")
  end
end