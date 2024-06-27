class UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy change_password ]
  before_action :authenticate_user!, only: %i[show update destroy change_password]
  before_action :authorize_user, only: %i[update destroy change_password]

  def index
    @users = User.includes(skills: :instrument).all

    render json: @users.as_json(include: {
      skills: {
        include: {
          instrument: {
            only: [:name]
          }
        },
        only: [:level]
      }
    }, methods: :profile_picture_url)
  end

  def show
    render json: @user.as_json(include: {
      skills: {
        include: {
          instrument: {
            only: [:name]
          }
        },
        only: [:level]
      }
    }, methods: :profile_picture_url)
  end

  def update
    if @user.update(user_params)
      render json: @user.as_json(include: {
        skills: {
          include: {
            instrument: {
              only: [:name]
            }
          },
          only: [:level]
        }
      }, methods: :profile_picture_url)
    else
      render json: { message: 'Failed to update user.', errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH /users/:id/change_password
  def change_password
    if @user.update_with_password(password_params)
      render json: { message: 'Password updated successfully' }, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # # RESEND EMAIL /users/:id/send_welcome_email
  # def resend_welcome_email
  #   @user = User.find(params[:id])
  #   @user.send_welcome_email
  #   render json: { success: true, message: 'Email de bienvenue renvoyé avec succès' }, status: :ok
  # rescue ActiveRecord::RecordNotFound => e
  #   render json: { success: false, message: "Utilisateur non trouvé" }, status: :not_found
  # rescue StandardError => e
  #   render json: { success: false, message: "Erreur lors de l'envoi de l'email : #{e.message}" }, status: :unprocessable_entity
  # end

  def destroy
    @user.destroy
  end

  private
  
  def set_user
    @user = User.find(params[:id])
  end

  def authorize_user
    unless current_user.role == "Admin" || current_user.id == @user.id
      render json: { error: "Action non autorisée" }, status: :unauthorized
    end
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :description, :profile_picture)
  end

  def password_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end
end

