require_relative "database_connection"

class Property

    def self.list_properties
        DatabaseConnection.query("SELECT * FROM properties;")
    end

    def self.list_properties_by_owner(user_id)
        DatabaseConnection.query("SELECT * FROM properties WHERE owned_by_id = '#{user_id}';")
    end

end