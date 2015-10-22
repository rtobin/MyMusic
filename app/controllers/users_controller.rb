class UsersController < ApplicationController

  before_action :require_log_in!, except: [:create, :new]

  def create
    @user = User.new(user_params)
    if @user.save
      flash.notice = "Welcome!"
      log_in!(@user)
      redirect_to user_url
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

  # The callback we defined requires that a user be logged in to
  # look at a users#show page. However, it does not enforce that user
  # A may not look at user B's
  # show page. Write a new filter in the UsersController to do this.
  # def require_log_in_auth!
  #
  #   redirect_to new_session_url unless
  # end

  private
  def user_params
    self.params.require(:user).permit(:email, :password)
  end
end
