class GithubDecorator
  def initialize(user)
    @user = user
    github_service
  end

  def github_service
    @github_service ||= GithubService.new(@user)
  end

  def get_user_email(username)
    user_info = @github_service.user_email(username)
    { name: user_info[:name], email: user_info[:email] }
  end

  def list_five_repos
    repos = @github_service.user_repos
    repos[0..4].map do |repo|
      UserRepository.new(
        {
          name: repo[:name],
          html_url: repo[:html_url]
        }
      )
    end
  end

  def followers
    followers = @github_service.user_followers
    followers.map do |follower|
      GithubRelations.new(
        {
          handle: follower[:login],
          url: follower[:html_url]
        }
      )
    end
  end

  def following
    followed_users = @github_service.user_following
    followed_users.map do |followed_user|
      GithubRelations.new(
        {
          handle: followed_user[:login],
          url: followed_user[:html_url]
        }
      )
    end
  end
end
