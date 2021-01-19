require "property"
require "database_helper"

describe Property do
  let(:name) {"testing_property"}
  let(:owner) {double("owner")}
  before do
    add_user
    allow(owner).to receive(:id).and_return(1)
  end

  describe "instance methods" do
    let(:property) {Property.new(name, owner)}

    it "initialises with property name and owner" do
      expect(property.name).to eq name
      expect(property.owner).to eq owner
    end

    it "sets is_available to true as default" do
      expect(property.is_available).to eq true
    end
    
    it "adds self to database when created" do
      Property.new(name, owner)
      all_property_names = Property.list_properties.map{|property| property["name"]}
      expect(all_property_names).to include(name)
    end

  end

  describe "class methods" do
    let(:owner) {double("owner")}
    before do
      2.times{ Property.new(name, owner) }
      Property.new(name, owner, false) 
      # 2 available properties and one unavailable
    end

    it "get all properties" do
      expect(Property.list_properties.ntuples).to eq 3
    end

    it "sort by owner" do
      expect(Property.list_properties_by_owner(1).ntuples).to eq 3
    end

    it "sort by availability" do
      expect(Property.list_properties_by_availability(true).ntuples).to eq 2
      expect(Property.list_properties_by_availability(false).ntuples).to eq 1
    end

    it "change availability" do
      available_property_id = DatabaseConnection.query("SELECT property_id FROM properties WHERE is_available = true LIMIT 1;").getvalue(0,0)
      Property.set_availability(available_property_id, false)
      expect(Property.list_properties_by_availability(true).ntuples).to eq 1
      expect(Property.list_properties_by_availability(false).ntuples).to eq 2
    end
  end

end