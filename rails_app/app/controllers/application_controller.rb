# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details


  # Scrub sensitive parameters from your log
  filter_parameter_logging :password

  helper_method :current_user

  before_filter :set_auth_current_user

  # Disable layout rendering when ajax call
  layout proc{ |c| c.request.xhr? ? false : "application" }

  private

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  def set_auth_current_user
    Authorization.current_user = current_user
  end

  def permission_denied
    flash[:error] = "Desole! Tu n'as pas les droits necessaires pour effectuer cette action."
    redirect_to root_url
  end


end
