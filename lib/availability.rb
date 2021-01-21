require_relative "database_connection"

class Availability
  def initialize(info)
    @availability_id = info["availability_id"]
    @property_id = info["property_id"]
    @start_date = info["start_date"]
    @end_date = info["end_date"]
  end
end