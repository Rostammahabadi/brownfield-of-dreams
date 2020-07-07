class ActivationController < ApplicationController

  def show
    @user = User.find(params[:user_id])
    @user.activate if @user.activated? == false
  end
end
