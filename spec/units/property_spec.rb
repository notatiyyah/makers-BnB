require "property"
require "database_helper"

describe Property do
  before do
    2.times{ add_property(true) }
    add_property(false)
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