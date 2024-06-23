class PublicationsController < ApplicationController
  before_action :set_publication, only: %i[show update destroy]
  before_action :authorize_user, only: %i[create update destroy] 

  # GET /publications
  def index
    @publications = Publication.all

    render json: @publications
  end

  # GET /publications/1
  def show
    render json: @publication
  end

  # POST /publications
  def create
    @publication = Publication.new(publication_params)

    if @publication.save
      render json: @publication, status: :created, location: @publication
    else
      render json: @publication.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /publications/1
  def update
    if @publication.update(publication_params)
      render json: @publication
    else
      render json: @publication.errors, status: :unprocessable_entity
    end
  end

  # DELETE /publications/1
  def destroy
    @publication.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_publication
      @publication = Publication.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def publication_params
      params.require(:publication).permit(:creator_id, :title, :description, :to_display)
    end

    def authorize_user
      unless current_user.role == "Admin"
        render json: { error: "Action non autorisée" }, status: :unauthorized
      end
    end
end
