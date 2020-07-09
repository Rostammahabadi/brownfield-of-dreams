class RegistrationMailer < ApplicationMailer
  def inform(info, recipient)
    @user = info[:user]
    @message = info[:message]
    mail(to: recipient, subject: 'Register your account')
  end
end
