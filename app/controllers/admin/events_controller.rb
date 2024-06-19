class Admin::EventsController < ApplicationController
  before_action :set_event, only: %i[show update destroy]
  before_action :authorize_user, only: %i[update destroy]
  before_action :authenticate_admin_or_professor
  
  def index
    @events = Event.all

    render json: @events
  end

  def show
    render json: @event
  end

  def create
    @event = Event.new(event_params)
    @event.creator_id = current_user.id

    if @event.save
      render json: @event, status: :created, location: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  def update
    if @event.update(event_params)
      render json: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:category, :title, :price, :start_date, :end_date, :location, :description)
    end

    def authenticate_admin_or_professor
      unless current_user.role == "Admin" || current_user.role == "Professeur"
        render json: { error: "Accès non autorisé" }, status: :unauthorized
      end
    end

    def authorize_user
      unless current_user.role == "Admin" || (current_user.role == "Professeur" && current_user.id == @event.creator_id)
        render json: { error: "Action non autorisée" }, status: :unauthorized
      end
    end
end
