class UsersController < ApplicationController

  before_action :require_log_in!, except: [:create, :new]

  def create
    @user = User.new(user_params)
    if @user.save
      #UserMailer.activation_email(@user).deliver!
      flash[:notice] =
        "Successfully created your account! Click here."

      redirect_to user_url(@user.id)
    else
      flash.now[:errors] = @user.errors.full_messages
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

  def activate
    @user = User.find_by_activation_token(params[:activation_token])
    @user.activate!
    login_user!(@user)
    flash[:notice] = "Successfully activated your account!"
    redirect_to root_url
  end

  private
  def user_params
    self.params.require(:user).permit(:email, :password)
  end
end
