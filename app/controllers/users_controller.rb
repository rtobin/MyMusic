class UsersController < ApplicationController


  def create
  end

  def new
  end

  def show
  end

  private
  def user_params
    self.params.require(:user).permit(:email, :password)
  end
end
