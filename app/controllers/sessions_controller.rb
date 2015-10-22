class SessionsController < ApplicationController

  def new
    # go to login
    render :new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password]
    )

    unless @user
      # bad credentials!
      # back to login
      flash.now[:errors] = ["Try again!"]
      render :new
    else
      # good credentials!
      # sign the user in
      log_in!(@user) # new session_token
      redirect_to user_url
    end
  end

  def destroy
    log_out! # kills session_token
    redirect_to new_session_url
  end
end
