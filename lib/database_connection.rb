require 'pg'

class DatabaseConnection

  @@conn = PG.connect( dbname: "makers_bnb")

  def self.connect
    @@conn = PG.connect( dbname: "makers_bnb#{ ENV["ENVIRONMENT"] == "testing" ? "_testing" : ""}" )
    @@conn.set_notice_processor{|result|} if ENV["ENVIRONMENT"] == "testing"
  end

  def self.db
    @@conn.db
  end

  def self.query(query_string)
    @@conn.exec(query_string)
  end

end