def set_up_test_env
  ENV["ENVIRONMENT"] = "testing"
  DatabaseConnection.connect
  ["properties", "bookings", "users"].each do |table_name|
    DatabaseConnection.query("DROP TABLE #{table_name} CASCADE;")
    DatabaseConnection.query("CREATE TABLE #{table_name} as (select * from #{table_name}_base);")
  end
end