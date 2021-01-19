require "property"

describe Property do

  it "get all properties" do
    expect(Property.list_properties.ntuples).to eq 0
  end

end