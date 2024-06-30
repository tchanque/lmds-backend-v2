require 'sib-api-v3-sdk'

module MailAdapter
  class BrevoAdapter
    def send_now(user, password)
      api_instance.send_transac_email(email(user, password))
    end

    private

    def email(user, password)
      ::SibApiV3Sdk::SendSmtpEmail.new(
        {
          to: [{ email: user.email, name: user.first_name}],
          templateId: 1,
          params: {
            user_name: user.first_name,
            user_email: user.email,
            user_password: user.password
          }
        }
      )
    end

    def api_instance
      ::SibApiV3Sdk::TransactionalEmailsApi.new
    end

  end
end