class SkillsController < ApplicationController
  before_action :set_skill, only: %i[ show update destroy ]

  # GET /skills
  def index
    @skills = Skill.all

    render json: @skills
  end

  # GET /skills/1
  def show
    render json: @skill
  end

  # POST /skills
  def create
    user = User.find(skill_params[:musician_id])
    instrument = Instrument.find_by(name: skill_params[:instrument_name])

    @skill = Skill.new(
      musician_id: user.id,
      instrument: instrument,
      level: skill_params[:level]
    )

    if @skill.save
      render json: @skill, status: :created, location: @skill
    else
      render json: @skill.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /skills/1
  def update
    if @skill.update(skill_params)
      render json: @skill
    else
      render json: @skill.errors, status: :unprocessable_entity
    end
  end

  # DELETE /skills/1
  def destroy
    @skill.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_skill
      @skill = Skill.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def skill_params
      params.require(:skill).permit(:musician_id, :instrument_name, :level)
    end
end
