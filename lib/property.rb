require_relative "database_connection"

class Property

    def self.list_properties
        DatabaseConnection.query("SELECT * FROM properties;")
    end

    def self.list_properties_by_owner(user_id)
        DatabaseConnection.query("SELECT * FROM properties WHERE owned_by_id = '#{user_id}';")
    end

    def self.list_properties_by_availability(is_available)
        DatabaseConnection.query("SELECT * FROM properties WHERE is_available = #{is_available};")
    end

    def self.set_availability(property_id, is_available)
        DatabaseConnection.query("UPDATE properties SET is_available = #{is_available} WHERE property_id = '#{property_id}';")
    end

    # ^ Class Methods 
    # v Instance methods

    attr_reader :name, :owner

    def initialize(name, owner)
        @name = name
        @owner = owner
        DatabaseConnection.query("INSERT INTO properties (name, owned_by_id, is_available ) VALUES( '#{name}', '#{owner.id}', 'true' ) ")
        p "finished query"
    end

end