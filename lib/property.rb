require_relative "database_connection"

class Property

    @@to_obj = lambda do |property_info|
        property_info["add_to_db"] = false
        Property.new(property_info)
    end
    # Converts row from properties table to object
    
    def self.list_properties
        DatabaseConnection.query("SELECT * FROM properties;").map(&@@to_obj)
    end

    def self.list_properties_by_owner(user_id)
        DatabaseConnection.query("SELECT * FROM properties WHERE owned_by_id = '#{user_id}';").map(&@@to_obj)
    end

    def self.list_properties_by_availability(is_available)
        DatabaseConnection.query("SELECT * FROM properties WHERE is_available = #{is_available};").map(&@@to_obj)
    end

    def self.set_availability(property_id, is_available)
        DatabaseConnection.query("UPDATE properties SET is_available = #{is_available} WHERE property_id = '#{property_id}';")
    end

    def self.add_property(property)
        DatabaseConnection.query("INSERT INTO properties (name, owned_by_id, is_available ) 
        VALUES( '#{property.name}', '#{property.owner_id}', '#{property.is_available}' );")
    end

    # ^ Class Methods 
    # v Instance methods

    attr_reader :id, :name, :owner_id, :is_available

    def initialize(info)
        @name = info["name"]
        @owner_id = info["owned_by_id"]
        @id = info["id"]
        @is_available = (info["is_available"] == false ? false : true)
        Property.add_property(self) unless info["add_to_db?"] == false
    end
end