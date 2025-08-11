class TestMailer < ApplicationMailer
  default from: "predictfootynotis@gmail.com"

  def test_email
    @user = params[:user]
    mail(
      to: @user.email,
      subject: "New Premier League season!!"
    )
  end
end
