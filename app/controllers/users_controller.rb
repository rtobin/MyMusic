class UsersController < ApplicationController


  def create
    @user = User.new(user_params)
    if @user.save
      log_in!(@user)
      redirect_to user_url
    else
      render :new
    end
  end

  def new
    @user = User.new
    render :new
  end

  def show
    unless current_user
      redirect_to new_session_url
      return
    end

    @user = current_user
    render :show
  end

  private
  def user_params
    self.params.require(:user).permit(:email, :password)
  end
end
