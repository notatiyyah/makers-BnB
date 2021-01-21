require_relative "database_connection"

class Availability

  @@to_obj = lambda do |availability_info|
    availability_info["add_to_db?"] = false
    Availability.new(availability_info)
  end

  def self.list
    DatabaseConnection.query("SELECT * FROM availability;").map(&@@to_obj)
  end

  def self.add(availability)
    if availability.availability_id.nil?
      DatabaseConnection.query("INSERT INTO availability (property_id, start_date, end_date)
      VALUES('#{availability.property_id}', '#{availability.start_date}', '#{availability.end_date}')")
    else
      DatabaseConnection.query("INSERT INTO availability
      VALUES('#{availability.availability_id}', '#{availability.property_id}', '#{availability.start_date}', '#{availability.end_date}')")
    end
  end

  attr_reader :availability_id, :property_id, :start_date, :end_date

  def initialize(info)
    @availability_id = info["availability_id"]
    @property_id = info["property_id"]
    @start_date = info["start_date"]
    @end_date = info["end_date"]
    Availability.add(self) if info["add_to_db?"].nil? || info["add_to_db?"] == true
  end

end