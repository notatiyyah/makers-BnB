require 'pg'

class DatabaseConnection

  @@conn = PG.connect( dbname: "makers_bnb")

  def self.connect
    @@conn = PG.connect( dbname: ENV["ENVIRONMENT"] == "testing" ? "makers_bnb_testing" : "makers_bnb" )
  end

  def self.db
    @@conn.db
  end

  def self.query(query_string)
    @@conn.exec(query_string)
  end

end