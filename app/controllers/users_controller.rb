class UsersController < ApplicationController
  before_action :require_login!, only: [:show]
  before_action :require_logout!, except: [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = 'User was successfully created'
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def show
    @created_events = current_user.events
    @past_events = current_user.invites.past
    @upcoming_events = current_user.invites.upcoming
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
