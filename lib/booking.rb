require_relative "database_connection"

class Booking
  
  @@to_obj = lambda do |booking_info|
    booking_info["add_to_db?"] = false
    Booking.new(booking_info)
  end

  def self.list
    DatabaseConnection.query("SELECT * FROM bookings;").map(&@@to_obj)
  end

  def self.list_by_id(booking_id)
    DatabaseConnection.query("SELECT * FROM bookings WHERE booking_id = '#{booking_id}';").map(&@@to_obj)
end

  def self.list_by_user(user_id)
    DatabaseConnection.query("SELECT * FROM bookings WHERE user_id = '#{user_id}';").map(&@@to_obj)
  end

  def self.list_by_property(property_id)
    DatabaseConnection.query("SELECT * FROM bookings WHERE property_id = '#{property_id}';").map(&@@to_obj)
  end

  def self.list_by_owner(owner_id)
    DatabaseConnection.query("SELECT * FROM bookings 
      WHERE property_id IN(
        SELECT property_id FROM properties
        WHERE owned_by_id = '#{owner_id}')").map(&@@to_obj)
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

  def self.update(booking_id, new_booking)
    DatabaseConnection.query("UPDATE bookings 
    SET property_id = #{new_booking.property_id}, user_id = #{new_booking.user_id}
    WHERE booking_id = '#{booking_id}';")
  end

  def self.delete(booking_id)
    DatabaseConnection.query("DELETE FROM bookings WHERE booking_id = #{booking_id};")
  end

  attr_reader :booking_id, :user_id, :property_id

  def initialize(info)
    @booking_id = info["booking_id"]
    @user_id = info["user_id"]
    @property_id = info["property_id"]
    Booking.add(self) if info["add_to_db?"].nil? || info["add_to_db?"] == true
  end
end