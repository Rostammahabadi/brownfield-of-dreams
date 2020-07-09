class InviteNotifierMailer < ApplicationMailer
  def invite(info, user)
    @user = user
    @recipient_email = info[:email]
    @friend = info[:name]
    mail(to: @recipient_email, subject: "#{user} is sending you an invite!")
  end
end
