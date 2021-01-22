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

    def self.add(property)
        query_string = "INSERT INTO properties (#{ property.property_id.nil? ? "" : "property_id,"} name, owned_by_id, description, price) 
        VALUES(#{ property.property_id.nil? ? "" : "#{property.property_id},"} '#{property.name}', '#{property.owner_id}', '#{property.description}', '#{property.price}');"
        DatabaseConnection.query(query_string)
    end

    def self.update(property_id, new_property)
        DatabaseConnection.query("UPDATE properties 
        SET name = '#{new_property.name}',
        owned_by_id = '#{new_property.owner_id}',
        description = '#{new_property.description}',
        price = #{new_property.price}
        WHERE property_id = '#{property_id}';")
    end

    def self.delete(property_id)
        DatabaseConnection.query("DELETE FROM properties WHERE property_id = #{property_id};")
    end

    # ^ Class Methods 
    # v Instance methods

    attr_reader :property_id, :name, :owner_id, :description, :price
    def initialize(info)
        @name = info["name"]
        @owner_id = info["owned_by_id"]
        @property_id = info["property_id"]
        @description = info["description"]
        @price = info["price"]
        Property.add(self) if info["add_to_db?"].nil? || info["add_to_db?"] == true
    end
end