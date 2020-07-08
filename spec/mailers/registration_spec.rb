require "rails_helper"

RSpec.describe RegistrationMailer, type: :mailer do
  it 'The inform action sends an activation email' do
    user = create(:user)
    recipient = "iro@fire.com"
    email_info =  {
                    user: user,
                    message: "Visit here to activate your account."
                  }
    email = RegistrationMailer.inform(email_info, recipient)
    expect(email.to).to eq([recipient])
    expect(email.body.encoded).to match("Visit here to activate your account.")
    expect(email.body.encoded).to match("http://localhost:3000/users/#{user.id}/activate")
  end
end
