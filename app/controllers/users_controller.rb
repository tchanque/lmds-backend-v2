class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[show update destroy]
  before_action :authorize_user, only: %i[update destroy]

  def index
  end

  def show
  end

  def update
  end

  def destroy
  end

  private
  
  def set_user
    @user = User.find(params[:id])
  end

  def authorize_user
    unless current_user.id == @user.id
      render json: { error: "Action non autorisée" }, status: :unauthorized
    end
  end
end

