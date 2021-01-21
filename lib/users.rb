require 'pg'

class Users

  def self.create(email:, password:, first_name:, surname:)
    connection = PG.connect :dbname => 'makers_bnb'
    connection.exec("INSERT INTO users (username,password,first_name,surname) VALUES ('#{email}','#{password}','#{first_name}','#{surname}')");
  end

  def self.check(email:, password:)
    connection = PG.connect :dbname => 'makers_bnb'
    #connection.exec("SELECT CASE WHEN EXISTS (SELECT username FROM users where username = ('#{username}')) THEN 'TRUE' ELSE 'FALSE'");
    p connection.exec("SELECT COUNT (*) FROM users WHERE (username,password) = ('#{email}','#{password}')").getvalue(0,0).to_i
  end

  def self.all(first_name:)
    connection = PG.connect :dbname => 'makers_bnb'
    connection.exec("SELECT first_name FROM users")
  end

  def self.single_user(first_name:)
    connection = PG.connect :dbname => 'makers_bnb'
    connection.exec("SELECT * FROM users WHERE (first_name) = ('#{first_name}')")
  end

  def self.single_user_id(id:)
    connection = PG.connect :dbname => 'makers_bnb'
    connection.exec("SELECT * FROM users where (user_id) = ('#{user_id}')")
  end
end
