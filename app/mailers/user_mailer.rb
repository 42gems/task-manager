class UserMailer < ActionMailer::Base
  default from: "42gems@example.com"

  def send_invite(project, user)
    @project = project
    @user = user
    mail(to: @user.email, subject: 'Invitation to the project').deliver
  end
end
