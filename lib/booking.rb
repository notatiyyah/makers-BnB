require_relative "database_connection"

class Booking

  def self.list
    DatabaseConnection.query("SELECT * FROM bookings;").map{|booking_info| Booking.new(booking_info)}
  end

  def self.add(booking)
    DatabaseConnection.query("INSERT INTO bookings (property_id, user_id)
    VALUES (#{booking.property_id}, #{booking.user_id});")
  end

  attr_reader :booking_id, :user_id, :property_id

  def initialize(info)
    @booking_id = info["booking_id"]
    @user_id = info["user_id"]
    @property_id = info["property_id"]
  end
end