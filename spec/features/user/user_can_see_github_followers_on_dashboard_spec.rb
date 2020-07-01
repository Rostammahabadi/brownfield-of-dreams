require 'rails_helper'

describe 'As a registered user' do
  describe 'When I visit the dashboard' do
    it 'I see a section titled followers' do
      user = create(:user, token:  ENV["GITHUB_API_TOKEN_R"])

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'

      expect(page).to have_content("Followers")
    end

    it 'I see a list of all of my followers' do
      user = create(:user, token:  ENV["GITHUB_API_TOKEN_R"])

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'

      within('#github-followers') do
        expect(page).to have_content("rickbacci")
        expect(page).to have_content("HughBerriez")
      end
    end

    it 'I dont see a followers section if I dont have an access token' do
      user create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'

      expect(page).to_not have_content("Followers")
      expect(page).to_not have_content("Github")
      expect(page).to_not have_content("rickbacci")
      expect(page).to_not have_content("HughBerriez")
    end

    it 'Followers names link to their Github profile' do
      user = create(:user, token:  ENV["GITHUB_API_TOKEN_R"])

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'

      within('#github-followers') do
        expect(page).to have_link("rickbacci", :href => "https://github.com/rickbacci")
        expect(page).to have_link("HughBerriez", :href => "https://github.com/HughBerriez")
      end
    end
  end
end
