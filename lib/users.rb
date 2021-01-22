require_relative "database_connection"

class Users

  def self.create(email:, password:, first_name:, surname:)
    DatabaseConnection.query("INSERT INTO users (username,password,first_name,surname) VALUES ('#{email}','#{password}','#{first_name}','#{surname}')")
  end

  def self.check(email:, password:)
    DatabaseConnection.query("SELECT COUNT (*) FROM users WHERE (username,password) = ('#{email}','#{password}')").getvalue(0,0).to_i
  end

  def self.all(first_name:)
    DatabaseConnection.query("SELECT first_name FROM users")
  end

  def self.single_user(first_name:)
    DatabaseConnection.query("SELECT * FROM users WHERE (first_name) = ('#{first_name}')")
  end

  def self.single_user_id(user_id:)
    DatabaseConnection.query("SELECT * FROM users WHERE (user_id) = ('#{user_id}')")
  end

  def self.sign_in_id(email:)
    DatabaseConnection.query("SELECT user_id FROM users WHERE username = '#{email}'").getvalue(0,0)
  end
end
