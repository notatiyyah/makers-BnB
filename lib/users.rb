require 'pg'

class Users

  def self.create(username:, password:)
    connection = PG.connect :dbname => 'makers_bnb'
    connection.exec("INSERT INTO users (username,password) VALUES ('#{username}','#{password}')");
  end
end
