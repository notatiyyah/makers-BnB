require 'booking'
require 'property'

describe Booking do
  let(:info) {{ "user_id" => 1, "property_id" => 1 }}
  let!(:new_booking) { Booking.new(info) }

  it "takes in a hash and stores details as instance variables" do
    expect(new_booking.user_id).to eq 1
  end

  it "adds self to db" do
    expect(Booking.list.map(&:user_id)).to include("1")
    expect(Booking.list.map(&:property_id)).to include("1")
  end

  it "gets all bookings from the db" do
    expect(Booking.list.length).to eq 2
  end

  it "adds a booking to the db" do
    info["booking_id"] = 11111
    info["add_to_db?"] = false
    Booking.add(Booking.new(info))
    expect(Booking.list.map(&:booking_id)).to include("11111")
  end

  it "deletes a booking from the db" do
    info["booking_id"] = 9999
    Booking.new(info)
    expect(Booking.list.map(&:booking_id)).to include("9999")
    Booking.delete(9999)
    expect(Booking.list.map(&:booking_id)).not_to include("9999")
  end

  it "edits a booking" do
    booking_id = DatabaseConnection.query("SELECT booking_id FROM bookings LIMIT 1;").getvalue(0,0)
    Property.new({"id" => 2, "name" => "new_property", "owned_by_id" => 1})
    info["property_id"] = 2
    info["add_to_db"] = false
    Booking.update(booking_id, Booking.new(info)) 
    expect(Booking.list.map(&:property_id)).to include("2")
  end

  it "get by id" do
    expect(Booking.list_by_id(1).length).to eq 1
  end

  it "list by user_id (ie renter)" do
    expect(Booking.list_by_user(1).length).to eq 2
  end

  it "list by property" do
    expect(Booking.list_by_property(1).length).to eq 2
  end

  it "list by owner" do
    expect(Booking.list_by_owner(1).length).to eq 2
  end

end