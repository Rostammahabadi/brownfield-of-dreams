class InviteController < ApplicationController
  def show
    redirect_to root_path unless current_user
  end

  def create
    user = "#{current_user.first_name} #{current_user.last_name}"
    user_hash = GithubDecorator.new(current_user).get_user_email(params[:github_handle])
    if user_hash[:email].nil?
      flash[:error] = "The Github user you selected doesn't have an email address associated with their account."
      redirect_to "/invite"
    else
      InviteNotifierMailer.invite(user_hash, user).deliver_now
      flash[:notice] = "Successfully sent invite!"
      redirect_to dashboard_path
    end
  end
end
