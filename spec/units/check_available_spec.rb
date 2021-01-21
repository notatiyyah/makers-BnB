require "check_available"

describe CheckAvailable do
  
  it "returns where available" do
    Booking.new({"user_id" => 1, "property_id" => 1, "start_date" => "2021-03-27", "end_date" => "2021-04-03"})
    dates = CheckAvailable.where_available(1)
    expect(dates.map{|range| range[:start_date]}).to eq ["2021-01-01", "2021-04-03", "2021-05-07"]
    expect(dates.map{|range| range[:end_date]}).to eq ["2021-03-27", "2021-05-03" ,"2021-12-31"]
  end

end