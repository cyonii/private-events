module ApplicationHelper
  def flash_class
    return 'success' if flash[:notice]
    return 'danger' if flash[:alert]
  end

  def flash_message
    render 'layouts/flash_message' if flash.present?
  end

  def user_signed_in?
    return true if session[:user_id]

    false
  end

  def current_user
    return User.find(session[:user_id]) if user_signed_in?

    nil
  end
end
