require "property"
require "database_helper"

describe Property do

  describe "instance methods" do
    let(:name) { "testing_property" }
    let(:info) {{"name" => name, "owned_by_id" => 1}}
    let!(:property){Property.new(info)}

    it "initialises with property name and owner" do
      expect(property.name).to eq name
      expect(property.owner_id).to eq 1
    end
    
    it "adds self to database when created" do
      all_property_names = Property.list.map(&:name)
      expect(all_property_names).to include(name)
    end

  end

  describe "class methods" do
    let(:info) { {"name" => "testing_property", "owned_by_id" => 1} }

    it "get all properties" do
      expect(Property.list.length).to eq 3
    end

    it "get by id" do
      expect(Property.list_by_id(1).length).to eq 1
    end

    it "sort by owner" do
      expect(Property.list_by_owner(1).length).to eq 3
    end

    it "add property" do
      info["name"] = "new_property"
      info["add_to_db"] = false
      new_property = Property.new(info)
      Property.add(new_property)
      all_property_names = Property.list.map(&:name)
      expect(all_property_names).to include("new_property")
    end

    it "edit property" do
      property_id = DatabaseConnection.query("SELECT property_id FROM properties LIMIT 1;").getvalue(0,0)
      old_property_name = DatabaseConnection.query("SELECT name FROM properties WHERE property_id = #{property_id};").getvalue(0,0)
      old_num = Property.list.map(&:name).count(old_property_name)
      info["name"] = "different property"
      info["add_to_db"] = false
      Property.update(property_id, Property.new(info)) 
      expect(Property.list.map(&:name)).to include("different property")
      expect(Property.list.map(&:name).count(old_property_name)).not_to eq old_num
    end

    it "delete property" do
      property_id = DatabaseConnection.query("SELECT property_id FROM properties LIMIT 1;").getvalue(0,0)
      old_property_name = DatabaseConnection.query("SELECT name FROM properties WHERE property_id = #{property_id};").getvalue(0,0)
      old_num = Property.list.map(&:name).count(old_property_name)
      Property.delete(property_id)
      expect(Property.list.map(&:name).count(old_property_name)).not_to eq old_num
    end

  end

end
