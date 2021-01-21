require "check_available"

describe CheckAvailable do
  
  it "returns where available" do
    dates = CheckAvailable.where_available(1)
    expect(dates[0][0][:start_date]).to eq "2021-01-01"
  end

end