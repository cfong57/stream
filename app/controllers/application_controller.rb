class ApplicationController < ActionController::Base
  protect_from_forgery
  after_filter :store_location

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end  

  def after_sign_in_path_for(resource)
    root_url
  end  

  def store_location
    # store last url - this is needed for post-login redirect to whatever the user last visited.
    # don't store ajax calls
    if(request.fullpath != "/users/sign_in" &&
        request.fullpath != "/users/sign_up" &&
        request.fullpath != "/users/password" &&
        !request.xhr? &&
        request.format == "text/html" || 
        request.content_type == "text/html") 
      session[:previous_url] = request.fullpath 
      session[:last_request_time] = Time.now.utc.to_i
    end
  end

  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end

  def after_update_path_for(resource)
    session[:previous_url] || root_path
  end

  def after_sign_out_path_for(resource)
    session[:previous_url] || root_path
  end

end
