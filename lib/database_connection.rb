require 'pg'

class DatabaseConnection

  @@conn = nil

  def self.connect
    @@conn = PG.connect( dbname: ENV["ENVIRONMENT"] == "testing" ? "makers_bnb_testing" : "makers_bnb" )
  end

  def self.db
    @@conn.db
  end

end