class AttendancesController < ApplicationController
  before_action :set_attendance, only: %i[ show update destroy ]
  after_action :decrement_available_spots, only: %i[create]
  after_action :increment_available_spots, only: %i[destroy]

  # GET /attendances
  def index
    @attendances = Attendance.all
    render json: @attendances
  end

  # GET /attendances/1
  def show
    render json: @attendance
  end

  # POST /attendances
  def create
    @attendance = Attendance.new(attendance_params)

    if @attendance.save
      render json: @attendance, status: :created, location: @attendance
    else
      render json: @attendance.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /attendances/1
  def update
    if @attendance.update(attendance_params)
      render json: @attendance
    else
      render json: @attendance.errors, status: :unprocessable_entity
    end
  end

  # DELETE /attendances/1
  def destroy

    @attendance.destroy
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_attendance
      @attendance = Attendance.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def attendance_params
      params.require(:attendance).permit(:attendee_id, :event_id, :is_pending, :event_instrument_id)
    end

    # Decrement the available spots for an event instrument
    #
    # This method retrieves the event instrument associated with the attendance
    # and decrements the available spots by 1. The minimum available spots is 0.
    #
    # @return [void]
    def decrement_available_spots
      # Retrieve the event instrument associated with the attendance
      event_instrument = EventInstrument.find(@attendance.event_instrument_id)

      # Calculate the new available spots by subtracting 1 from the current available spots
      # and ensuring that the minimum available spots is 0
      new_available_spots = [event_instrument.available_spots - 1, 0].max

      # Update the event instrument with the new available spots
      event_instrument.update(available_spots: new_available_spots)
    end

    # Increment the available spots for an event instrument
    #
    # This method checks if the attendance is pending and if so, it decrements
    # the available spots for the event instrument. If all the pending
    # attendances are processed, it increments the available spots.
    #
    # @return [void]
    def increment_available_spots
      # Check if the attendance is pending
      if @attendance.is_pending == false # 0 = false. 1 = true. The front end sends true or false which is 1 or 0.
        event_instrument = EventInstrument.find(@attendance.event_instrument_id)

        # Find all the pending attendances for the event instrument
        pending_attendances = event_instrument.attendances.where(is_pending: true).order(:created_at)

        if pending_attendances.any?
          # Update the oldest pending attendance to remove it from the waiting list
          oldest_pending_attendance = pending_attendances.first
          oldest_pending_attendance.update(is_pending: false)
        else
          # Increment the available spots for the event instrument
          new_available_spots = [event_instrument.available_spots + 1, event_instrument.total_spots].min
          event_instrument.update(available_spots: new_available_spots)
        end
      end
    end
end
