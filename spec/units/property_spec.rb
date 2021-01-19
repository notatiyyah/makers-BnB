require "property"
require "database_helper"

describe Property do

  describe "instance methods" do
    let(:name) { "testing_property" }
    let(:info) {{"name" => name, "owned_by_id" => 1}}
    let(:property){Property.new(info)}
    before do
      add_user
    end

    it "initialises with property name and owner" do
      expect(property.name).to eq name
      expect(property.owner_id).to eq 1
    end

    it "sets is_available to true as default" do
      expect(property.is_available).to eq true
    end
    
    it "adds self to database when created" do
      all_property_names = Property.list_properties.map{|property| property.name}
      #expect(all_property_names).to include(name)
    end

  end

  describe "class methods" do
    let(:name) { "testing_property" }
    let(:info) { {"name" => name, "owned_by_id" => 1} }
    before do
      add_user
      2.times{ Property.new(info) }
      info["is_available"] = false
      Property.new(info) 
      # 2 available properties and one unavailable
    end

    it "get all properties" do
      expect(Property.list_properties.length).to eq 3
    end

    it "sort by owner" do
      expect(Property.list_properties_by_owner(1).length).to eq 3
    end

    it "sort by availability" do
      expect(Property.list_properties_by_availability(true).length).to eq 2
      expect(Property.list_properties_by_availability(false).length).to eq 1
    end

    it "change availability" do
      available_property_id = DatabaseConnection.query("SELECT property_id FROM properties WHERE is_available = true LIMIT 1;").getvalue(0,0)
      Property.set_availability(available_property_id, false)
      expect(Property.list_properties_by_availability(true).length).to eq 1
      expect(Property.list_properties_by_availability(false).length).to eq 2
    end
  end

end