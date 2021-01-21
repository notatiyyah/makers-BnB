require_relative "database_connection"

class Availability

  @@to_obj = lambda {|availability_info| Availability.new(availability_info) }

  def self.list
    DatabaseConnection.query("SELECT * FROM availability;").map(&@@to_obj)
  end

  attr_reader :availability_id, :property_id, :start_date, :end_date

  def initialize(info)
    @availability_id = info["availability_id"]
    @property_id = info["property_id"]
    @start_date = info["start_date"]
    @end_date = info["end_date"]
  end

end