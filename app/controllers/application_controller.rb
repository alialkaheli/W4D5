class ApplicationController < ActionController::Base
  
  helper_method :current_user, :logged_in?
  
  def logout 
    current_user.reset_session_token! if logged_in?
    session[:session_token] = nil 
  end 
  
  def login(user)
    @current_user = user 
    session[:session_token] = user.session_token 
    
  end 
  
  def logged_in? 
    !!current_user
  end 
  
  def current_user 
    return nil unless session[:session_token]
    @current_user ||= User.find_by(session_token: session[:session_token])
  end 
end
