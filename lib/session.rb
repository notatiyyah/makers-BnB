class Session
  def self.check(user_id)
    if user_id.class == Integer and user_id
      return true
    end
    return false
  end
end
