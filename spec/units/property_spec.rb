require "property"
require "database_helper"

describe Property do

  it "get all properties" do
    expect(Property.list_properties.ntuples).to eq 0
  end

  it "sort by owner" do
    2.times{ add_property }
    expect(Property.list_properties_by_owner(1).ntuples).to eq 2
  end

end