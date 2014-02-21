class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter { |c| Authorization.current_user = c.current_user }

  def current_user
    User.find(session[:user_id]) unless session[:user_id].nil?
  end
  
  protected

  def permission_denied
    flash[:notice] = "Error 404. Page does not exist."
    redirect_to root_url
  end

  def authorize
    unless User.find_by_id(session[:user_id])
    redirect_to :controller => 'store' , :action => 'sign_in'
    end
  end

  def authorize_manager
    unless User.find_by_id(session[:user_id])
    redirect_to :controller => 'manage' , :action => 'sign_in'
    end
  end

  def require_login
    flash[:notice] = "You must first log in or sign up."
    redirect_to :controller => 'store' if current_user.nil?
  end


end
