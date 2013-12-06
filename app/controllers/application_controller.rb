class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to (session[:previous_url] || root_path), :alert => exception.message
  end 

  after_filter :store_location

  def store_location
    # store last url - this is needed for post-login redirect to whatever the user last visited.
    # don't store ajax calls
    # don't redirect to any devise pages, or edit forms
    if ( !request.fullpath.match("\/my\/users") &&
        !request.fullpath.match("\/users\/[0-9]+\/edit") &&
        !request.fullpath.match("\/songs\/[0-9]+\/edit") &&
        !request.xhr? &&
        (request.format == "text/html" || request.content_type == "text/html")
        ) 
      session[:previous_url] = request.fullpath 
      session[:last_request_time] = Time.now.utc.to_i
    end
  end

  def proper_redirect_path_for(resource)
    session[:previous_url] || root_path
  end


  #these override devise things
  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end

  def after_sign_out_path_for(resource)
    session[:previous_url] || root_path
  end
  
end
