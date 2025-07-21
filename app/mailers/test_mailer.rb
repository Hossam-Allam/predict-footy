class TestMailer < ApplicationMailer
  default from: "predictfootynotis@gmail.com"

  def test_email
    mail(
      to: "hossamallam32@gmail.com",
      subject: "🚀 It works!"
    )
  end
end
