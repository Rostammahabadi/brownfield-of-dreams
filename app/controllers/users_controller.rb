class UsersController < ApplicationController
  def show
    return unless current_user.token

    github_decorator = GithubDecorator.new(current_user)
    @users_repos = github_decorator.list_five_repos
    @user_followers = github_decorator.followers
    @user_following = github_decorator.following
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
