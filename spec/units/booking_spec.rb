require 'booking'

describe Booking do
  let(:info) {{ "user_id" => 1, "property_id" => 1 }}

  it "takes in a hash and stores details as instance variables" do
    new_booking = Booking.new(info)
    expect(new_booking.user_id).to eq 1
  end

  it "gets all bookings from the db" do
    expect(Booking.list.length).to eq 0
  end

  it "adds a booking to the db" do
    new_booking = Booking.new(info)
    Booking.add(new_booking)
    expect(Booking.list.map(&:user_id)).to include("1")
    expect(Booking.list.map(&:property_id)).to include("1")
  end

end