class GithubRelations
  attr_reader :handle, :url
  def initialize(user_data)
    @handle = user_data[:handle]
    @url = user_data[:url]
  end
end
