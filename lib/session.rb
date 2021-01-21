class Session
  def self.check(user_id)
    if user_id.class == Integer and user_id
      return true
    end
    return false
  end

  def self.destroy
    find(session[:user_id]).destroy
    session[:user_id] = nil
    redirect 'users/new'
  end
end
