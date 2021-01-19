def set_up_test_env
  ENV["ENVIRONMENT"] = "testing"
  DatabaseConnection.connect
  ["properties", "bookings", "users"].each do |table_name|
    DatabaseConnection.query("TRUNCATE TABLE #{table_name} CASCADE")
  end
end

def add_user
  query_string = "INSERT INTO users (user_id, username, password)
  VALUES( '1', 'test_user', 'test_password' ) "
  DatabaseConnection.query(query_string)
end
