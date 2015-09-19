module SessionsHelper


  # creates a session-cookie where the user_id gets stored in (encrypted)
  # so the user stays logged in
  def log_in(user)
    session[:user_id]= user.id
  end

  # creates cookies that the user can stay logged in over usual session time
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end


  # returns the current user if he has a session or the cookies to get logged in
  def current_user
    if(user_id = session[:user_id])
      @current_user ||= User.find_by(id: session[:user_id])
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # deletes the cookies of the user
  def forget (user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  #checks if the user is logged in
  def logged_in?
    !current_user.nil?
  end

  # if a user logs out his cookies and session data will be deleted on server-side
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end


end
