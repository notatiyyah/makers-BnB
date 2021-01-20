require_relative "database_connection"

class Booking
  
  @@to_obj = lambda do |booking_info|
    booking_info["add_to_db?"] = false
    Booking.new(booking_info)
  end

  def self.list
    DatabaseConnection.query("SELECT * FROM bookings;").map(&@@to_obj)
  end

  def self.add(booking)
    if booking.booking_id.nil?
      DatabaseConnection.query("INSERT INTO bookings (property_id, user_id)
      VALUES (#{booking.property_id}, #{booking.user_id});")
    else
      DatabaseConnection.query("INSERT INTO bookings (booking_id, property_id, user_id)
      VALUES ( #{booking.booking_id} ,#{booking.property_id}, #{booking.user_id});")
    end
  end

  def self.delete(booking_id)
    DatabaseConnection.query("DELETE FROM bookings WHERE booking_id = #{booking_id};")
  end

  attr_reader :booking_id, :user_id, :property_id

  def initialize(info)
    @booking_id = info["booking_id"]
    @user_id = info["user_id"]
    @property_id = info["property_id"]
    Booking.add(self) unless info["add_to_db?"] == false
  end
end