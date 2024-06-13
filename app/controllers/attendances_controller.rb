class AttendancesController < ApplicationController
  before_action :set_attendance, only: %i[ show update destroy ]

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
    @attendance.destroy!
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
end
