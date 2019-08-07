class ApplicationController < ActionController::Base

  helper_method :current_user, :logged_in?
  #why do we need this???

  def current_user
    @current_user ||= User.find_by(session_token: [:session_token])
  end

  def login(user)
    session[:session_token] = user.reset_session_token!
    #sets the browser's session token to the new one created by the model method
  end

  def logout
    @current_user.reset_session_token! if logged_in?
    session[:session_token] = nil
    @current_user = nil
    #sets browser session token to nil, sets database token to new secure one
  end

  def logged_in?
    !!current_user
    #returns true if current_user exists
  end

  def require_logged_in?
    redirect_to new_session_url unless logged_in?
    #WTF is going on here
    #this is to be used in the html template so they don't see certain things unless they're logged in. will redirect them to the login page.
  end

  def require_logged_out
    redirect_to users_url if logged_in?
    #if they try to go to the sign in page when they're already logged in?
  end

end
