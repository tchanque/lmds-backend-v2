class EventsController < ApplicationController
  before_action :set_event, only: %i[show update destroy]
  before_action :authorize_user, only: %i[update destroy]
  before_action :authenticate_admin_or_professor, only: %i[create]
  
  def index
    @events = Event.includes(event_instruments: { instrument: {}, attendances: :attendee }).all

    render json: @events.as_json(include: {
      event_instruments: {
        include: {
          instrument: {},
          attendances: {
            include: :attendee
          }
        },
        only: [:level, :available_spots, :total_spots, :id]
      } 
    }, methods: :event_picture_url)
  end

  def show
    render json: @event.as_json(include: {
      event_instruments: {
        include: {
          instrument: {},
          attendances: {
            include: :attendee
          }
        },
        only: [:level, :available_spots, :total_spots, :id]
      }
    }, methods: :event_picture_url)
  end

  def create
    @event = Event.new(event_params)
    @event.creator_id = current_user.id

    if @event.save
      if params[:event_picture].present?
        @event.event_picture.attach(params[:event_picture])
      end
      render json: @event, status: :created, location: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  def update
    if @event.update(event_params)
      if params[:event_picture].present?
        @event.event_picture.attach(params[:event_picture])
      end
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
      params.require(:event).permit(:category, :title, :price, :start_date, :end_date, :location, :description, :event_picture)
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
