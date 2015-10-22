class CountersController < ApplicationController
  def update
    current_user.counter = params[:user][:counter]
    current_user.save!
    redirect_to usr_url
  end
end
