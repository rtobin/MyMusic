class SessionsController < ApplicationController

  def new
    # go to login
    render :new
  end

  def create
    user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password]
    )

    unless user
      # bad credentials!
      # back to login
      flash.now[:errors] = ["Try again!"]
      render :new
    elsif !user.activated
      redirect_to root_url, alert: "You must activate your account first! Check your email."
    else
      # good credentials!
      # sign the user in
      log_in!(user) # new session_token
      redirect_to root_url
    end
  end

  def destroy
    log_out! # kills session_token
    redirect_to new_session_url
  end
end
