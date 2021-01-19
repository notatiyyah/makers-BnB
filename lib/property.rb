require_relative "database_connection"

class Property

    def self.list_properties
        DatabaseConnection.query("SELECT * FROM properties")
    end

end