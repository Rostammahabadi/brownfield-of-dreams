require 'rails_helper'

describe 'As a user' do
  describe 'When I visit my dashboard' do
    it 'I see a link to send an invite' do
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'

      expect(page).to have_link('Send an Invite')
    end

    it 'When I click the link I am taken to a form to enter a github handle' do
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'

      click_on 'Send an Invite'

      expect(current_path).to eq('/invite')
    end

    it 'When I fill in the form with a valid github handle, I send out an email invitation' do
      user = create(:user, token:  ENV["GITHUB_API_TOKEN_R"])

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'

      click_on 'Send an Invite'

      fill_in :github_handle, with: "judithpillado"
      click_on 'Send Invite'

      expect(page).to have_content("Successfully sent invite!")
    end

    it 'If the github user does not have an email associated with their account, I am notified' do
      user = create(:user, token:  ENV["GITHUB_API_TOKEN_R"])

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'

      click_on 'Send an Invite'

      fill_in :github_handle, with: "takeller"
      click_on 'Send Invite'

      expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")

    end
  end
end
