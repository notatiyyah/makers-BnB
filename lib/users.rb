require 'pg'

class Users

  def self.create(email:, password:)
    connection = PG.connect :dbname => 'makers_bnb'
    connection.exec("INSERT INTO users (username,password) VALUES ('#{email}','#{password}')");
  end

  def self.check(email:, password:)
    connection = PG.connect :dbname => 'makers_bnb'
    #connection.exec("SELECT CASE WHEN EXISTS (SELECT username FROM users where username = ('#{username}')) THEN 'TRUE' ELSE 'FALSE'");
    p connection.exec("SELECT COUNT (*) FROM users WHERE (username,password) = ('#{email}','#{password}')").getvalue(0,0).to_i
  end

end
