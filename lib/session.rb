class Session
  def self.check(user_id, path)
    user_id.class == Integer || ENV["ENVIRONMENT"] == "testing" || ["signed_up", "sessions", "users", "test"].include?(path)
    true
  end

  def self.destroy
    find(session[:user_id]).destroy
    session[:user_id] = nil
    redirect 'users/new'
  end
end
