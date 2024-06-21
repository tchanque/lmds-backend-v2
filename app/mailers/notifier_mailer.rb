class NotifierMailer < ApplicationMailer
  def simple_message(recipient) 
    mail(
      to: recipient,
      subject: "Test Mailer"
    )
  end
end
