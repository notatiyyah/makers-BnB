def set_up_test_env
  ENV["ENVIRONMENT"] = "testing"
  DatabaseConnection.connect
  ["properties", "bookings", "users"].each do |table_name|
    DatabaseConnection.query("TRUNCATE TABLE #{table_name} CASCADE")
  end
end