class UserMailer < ApplicationMailer
  default from: 'meddler@reciprocity.io'

  def match_email
    @user = params[:user]
    @user2 = params[:user2]
    @activity = params[:activity]

    email_with_name = %("#{@user.name}" <#{@user.email}>)

    mail(to: email_with_name, subject: 'You have a match on Reciprocity.io!')
  end
end
