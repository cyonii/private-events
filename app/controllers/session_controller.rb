class SessionController < ApplicationController
  before_action :require_logout!, except: [:destroy]

  def new; end

  def create
    if !params[:email].empty? and (user = User.find_by(email: params[:email]))
      session[:user_id] = user.id
      flash[:notice] = 'Signed in successfully'
      redirect_to root_path
    else
      flash[:alert] = 'User with email not found'
      render :new
    end
  end

  def destroy
    session.clear
    flash[:notice] = 'Signed out successfully'
    redirect_to root_path
  end
end
