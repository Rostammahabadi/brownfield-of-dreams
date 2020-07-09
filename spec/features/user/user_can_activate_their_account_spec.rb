require 'rails_helper'

describe 'As a non-activated user' do

  before :each do
    @email = 'jimbob@aol.com'
    @first_name = 'Jim'
    @last_name = 'Bob'
    @password = 'password'
    password_confirmation = 'password'

    visit '/'

    click_on 'Sign In'

    expect(current_path).to eq(login_path)

    click_on 'Sign up now.'

    expect(current_path).to eq(new_user_path)

    fill_in 'user[email]', with: @email
    fill_in 'user[first_name]', with: @first_name
    fill_in 'user[last_name]', with: @last_name
    fill_in 'user[password]', with: @password
    fill_in 'user[password_confirmation]', with: @password

  end

  it 'I should receive an email to activate my account after registering' do

    email_count = ActionMailer::Base.deliveries.count

    click_on'Create Account'

    expect(ActionMailer::Base.deliveries.count).to eq(email_count + 1)
  end

  it 'Clicking the link in the email will activate my account' do

  end
end
