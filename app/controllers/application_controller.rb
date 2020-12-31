class ApplicationController < ActionController::Base
  include ApplicationHelper

  def index
    render 'layouts/index'
  end

  def require_login!
    redirect_to new_session_path, alert: 'Log in to continue' unless user_signed_in?
  end

  def require_logout!
    return unless user_signed_in?

    flash[:notice] = "You're already logged in"
    redirect_to root_path
  end
end
