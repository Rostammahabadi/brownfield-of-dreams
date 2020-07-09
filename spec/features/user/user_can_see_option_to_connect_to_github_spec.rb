require 'rails_helper'

describe "As a user" do
  it "shows a link to connect to github on dashboard" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit '/dashboard'

    expect(page).to have_link("Connect to Github")
  end

  it "allows the user to login via github authorization" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      :provider => 'github',
      :uid => "60719241",
      :info => {:email => user.email, :nickname => "Rostammahabadi", :token => "123412341234"},
      :credentials => {:token => ENV['GITHUB_API_TOKEN_R']}
    })
    visit dashboard_path
    click_on "Connect to Github"
    user.reload
    expect(current_path).to eq(dashboard_path)
    expect(user.username).to eq("Rostammahabadi")
    expect(user.uid).to eq("60719241")
  end

end
