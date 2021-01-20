require_relative "database_connection"

class Property

    @@to_obj = lambda do |property_info|
        property_info["add_to_db?"] = false
        Property.new(property_info)
    end
    # Converts row from properties table to object
    
    def self.list
        DatabaseConnection.query("SELECT * FROM properties;").map(&@@to_obj)
    end

    def self.list_by_id(property_id)
        DatabaseConnection.query("SELECT * FROM properties WHERE property_id = '#{property_id}';").map(&@@to_obj)
    end

    def self.list_by_owner(user_id)
        DatabaseConnection.query("SELECT * FROM properties WHERE owned_by_id = '#{user_id}';").map(&@@to_obj)
    end

    def self.list_by_availability(is_available)
        DatabaseConnection.query("SELECT * FROM properties WHERE is_available = #{is_available};").map(&@@to_obj)
    end

    def self.set_availability(property_id, is_available)
        DatabaseConnection.query("UPDATE properties SET is_available = #{is_available} WHERE property_id = '#{property_id}';")
    end

    def self.add(property)
        if property.property_id.nil?
            DatabaseConnection.query("INSERT INTO properties (name, owned_by_id, is_available ) 
            VALUES( '#{property.name}', '#{property.owner_id}', '#{property.is_available}' );")
        else
            DatabaseConnection.query("INSERT INTO properties (property_id, name, owned_by_id, is_available ) 
            VALUES( '#{property.property_id}', '#{property.name}', '#{property.owner_id}', '#{property.is_available}' );") 
        end
    end

    def self.update(property_id, new_property)
        DatabaseConnection.query("UPDATE properties 
        SET name = '#{new_property.name}',
        owned_by_id = '#{new_property.owner_id}',
        is_available = '#{new_property.is_available}'
        WHERE property_id = '#{property_id}';")
    end

    def self.delete(property_id)
        DatabaseConnection.query("DELETE FROM properties WHERE property_id = #{property_id};")
    end

    # ^ Class Methods 
    # v Instance methods

    attr_reader :property_id, :name, :owner_id, :is_available

    def initialize(info)
        @name = info["name"]
        @owner_id = info["owned_by_id"]
        @property_id = info["property_id"]
        @is_available = (info["is_available"] == false ? false : true)
        Property.add(self) if info["add_to_db?"].nil? || info["add_to_db?"] == true
    end
end