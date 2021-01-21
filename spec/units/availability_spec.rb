require 'availability'

describe Availability do
  let(:info){{"property_id" => 1, "start_date" => '01-02-21', "end_date" => '05-02-21'}}
  
  it "take in hash and save values to variables" do
    times = Availability.new(info)
    expect(times.property_id).to eq 1
    expect(times.start_date).to eq '01-02-21'
  end

  it "return all availabilities" do
    expect(Availability.list.length).to eq 1
  end

end