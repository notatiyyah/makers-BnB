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

def add_property(is_available=true)
  num_of_users = DatabaseConnection.query("SELECT COUNT(*) FROM users;").getvalue(0,0).to_i
  add_user if num_of_users == 0
  query_string = "INSERT INTO properties (name, owned_by_id, is_available ) 
  VALUES( 'test_property', '1', '#{is_available}' ) "
  DatabaseConnection.query(query_string)
end