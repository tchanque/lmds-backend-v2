class EventInstrumentsController < ApplicationController
  before_action :set_event_instrument, only: %i[ show update destroy ]

  # GET /event_instruments
  def index
    @event_instruments = EventInstrument.all

    render json: @event_instruments
  end

  # GET /event_instruments/1
  def show
    render json: @event_instrument
  end

  # POST /event_instruments
  def create
    @event_instrument = EventInstrument.new(event_instrument_params)

    if @event_instrument.save
      render json: @event_instrument, status: :created, location: @event_instrument
    else
      render json: @event_instrument.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /event_instruments/1
  def update
    if @event_instrument.update(event_instrument_params)
      render json: @event_instrument
    else
      render json: @event_instrument.errors, status: :unprocessable_entity
    end
  end

  # DELETE /event_instruments/1
  def destroy
    @event_instrument.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event_instrument
      @event_instrument = EventInstrument.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_instrument_params
      params.require(:event_instrument).permit(:event_id, :instrument_id, :total_spots, :available_spots, :level)
    end
end
