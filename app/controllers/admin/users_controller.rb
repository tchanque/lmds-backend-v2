# class Admin::UsersController < ApplicationController
#   before_action :authenticate_user!, only: %i[show update destroy]
#   before_action :authenticate_admin

#   def index
#   end

#   def show
#   end

#   def update
#   end

#   def destroy
#   end

#   private
#     # Use callbacks to share common setup or constraints between actions.
#     def set_user
#       @user = User.find(params[:id])
#     end

#     def authenticate_admin
#       unless current_user.role == "Admin"
#         render json: { error: "Accès non autorisé" }, status: :unauthorized
#       end
#     end

# end