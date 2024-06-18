class Users::RegistrationsController < Devise::RegistrationsController
    respond_to :json
  
    before_action :configure_sign_up_params, only: [:create]

    def create
      Rails.logger.debug("Params: #{params.inspect}")
      super
    end

    private
  
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
      devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :first_name, :last_name, :role, :subscription_end_date])
    end
  end