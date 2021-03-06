class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def activation_email(user)
    @user = user
    mail(to: user.email, subject: "Welcome to MyMusic! Please activate your account.")
  end
end
