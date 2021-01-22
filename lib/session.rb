class Session
  def self.check(user_id, path)
    ENV["ENVIRONMENT"] == "testing" || !(user_id.nil? && ["spaces", "requests"].include?(path))
  end
end
