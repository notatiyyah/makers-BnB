def set_up_test_env
  ENV["ENVIRONMENT"] = "testing"
  DatabaseConnection.connect
  ["properties", "bookings", "users"].each do |table_name|
    DatabaseConnection.query("TRUNCATE TABLE #{table_name} CASCADE")
    add_user
  end
end

def add_user
  begin
    DatabaseConnection.query("INSERT INTO users (user_id, username, password)
    VALUES( '1', 'test_user', 'test_password' ) ")
  rescue PG::UniqueViolation
    DatabaseConnection.query("INSERT INTO users (username, password)
    VALUES('test_user', 'test_password' ) ")
  end
end

def add_properties
  2.times{ Property.new(info) }
  info["is_available"] = false
  Property.new(info) 
  # 2 available properties and one unavailable
end
