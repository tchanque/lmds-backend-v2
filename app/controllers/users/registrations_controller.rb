class Users::RegistrationsController < Devise::RegistrationsController
    respond_to :json
  
    before_action :configure_sign_up_params, only: [:create]

    def create
      # Rails.logger.debug("Params: #{params.inspect}")
      # super
      # password = params[:password]
      build_resource(sign_up_params)
      resource.save
      yield resource if block_given?
      if resource.persisted?
        if resource.active_for_authentication?
          set_flash_message! :notice, :signed_up
          sign_up(resource_name, resource)
          # Appel de la méthode pour envoyer l'email de bienvenue avec le mot de passe
          send_welcome_email(resource, sign_up_params[:password])
          respond_with resource, location: after_sign_up_path_for(resource)
        else
          set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
          expire_data_after_sign_in!
          respond_with resource, location: after_inactive_sign_up_path_for(resource)
        end
      else
        clean_up_passwords resource
        set_minimum_password_length
        respond_with resource
      end
    end

    private

    def send_welcome_email(user, password)
      Rails.logger.info("Sending welcome email to #{user.email}")
      adapter = MailAdapter::BrevoAdapter.new
      adapter.send_now(user, password)
    rescue => e
      Rails.logger.error("Failed to send welcome email: #{e.message}")
    end
  
    def respond_with(resource, _opts = {})
    # Check if resource.pesisted? returns true (meaning the user was saved), then returns register_success, else returns register_failed
    # resource.persisted? ? register_success : register_failed
      register_success && return if resource.persisted?
  
      register_failed
    end
  
    def register_success
      render json: {
        message: 'Signed up sucessfully.',
        user: current_user
      }, status: :ok
    end
  
    def register_failed
      render json: { message: 'Something went wrong.' }, status: :unprocessable_entity
    end

    protected

    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :first_name, :last_name, :role, :subscription_end_date, :is_subscriber])
    end
  end