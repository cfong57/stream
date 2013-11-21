class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end 

  after_filter :store_location

  def store_location
    # store last url - this is needed for post-login redirect to whatever the user last visited.
    # don't store ajax calls
    if (request.fullpath != "/my/users/sign_in" &&
        request.fullpath != "/my/users/sign_up" &&
        request.fullpath != "/my/users/password" &&
        request.fullpath != "/my/users/edit" &&
        !request.xhr? &&
        (request.format == "text/html" || request.content_type == "text/html")
        ) 
      session[:previous_url] = request.fullpath 
      session[:last_request_time] = Time.now.utc.to_i
    end
  end

  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end

  def after_sign_out_path_for(resource)
    session[:previous_url] || root_path
  end

  def proper_after_update_path_for(resource)
    session[:previous_url] || root_path
  end
  
end
