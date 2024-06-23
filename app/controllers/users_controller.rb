class UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy ]
  before_action :authenticate_user!, only: %i[show update destroy]
  before_action :authorize_user, only: %i[update destroy]

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
    })
  end

  def show
    @user = User.includes(skills: :instrument).find(params[:id])

    render json: @user.as_json(include: {
      skills: {
        include: {
          instrument: {
            only: [:name]
          }
        },
        only: [:level]
      }
    })
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
      })
    else
      render json: { message: 'Failed to update user.', errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
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
    params.require(:user).permit(:first_name, :last_name, :description)
  end
end

