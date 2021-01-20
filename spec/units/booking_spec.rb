require 'booking'

describe Booking do
  let(:info) {{ "user_id" => 1, "property_id" => 1 }}
  
  it "takes in a hash and stores details as instance variables" do
    new_booking = Booking.new(info)
    expect(new_booking.user_id).to eq 1
  end

end