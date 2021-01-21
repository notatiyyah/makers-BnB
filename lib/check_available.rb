require_relative "database_connection"
require_relative "availability"
require_relative "booking"

class CheckAvailable

  def self.where_available(property_id)
    booked = Booking.list_by_property(property_id)
    avail_range = Availability.list_by_property_id(property_id)
    intersection = []
    avail_range.each{|range| intersection << get_available(range, booked)}
    intersection
  end

  def self.get_available(range, dates)
    available = []
    available << {start_date: range.start_date, end_date: dates[0].start_date}

    index = 0
    loop do 
      break if  dates[index+1].nil? || dates[index+1].start_date > range.end_date
      available << {start_date: dates[index].end_date, end_date: dates[index+1].start_date}
      index += 1
    end

    available << {start_date: dates[-1].end_date, end_date: range.end_date}
    available
  end

end


