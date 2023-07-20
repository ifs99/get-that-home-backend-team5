class InteractionsController < ApplicationController
  before_action :set_interaction, only: %i[ show edit update destroy ]

  # GET /interactions or /interactions.json
  # def index
  #   @interactions = Interaction.all
  # end
  def index_interactions
    key = interaction_params.keys.first
    value = interaction_params[key]
    interactions = Interaction.where(user_id: current_user.id,key.to_sym => value)
    render json: interactions
  end

  def create
    property_id = params[:property_id]
    
    new_interaction = current_user.interactions.new(interaction_params.merge(property_id: property_id))

    if new_interaction.save
      render json: new_interaction, status: :created
    else
      render json: new_interaction.errors, status: :unprocessable_entity
    end
  end

  def update_interaction
    property_id = params[:property_id]
    interaction1 = Interaction.find_by(user_id: current_user.id, property_id: property_id)
    if interaction1.update(interaction_params)
      render json: interaction1
    else
      render json: interaction1.errors, status: :unprocessable_entity
    end
  end

  def delete_interaction
    property_id = params[:property_id]
    interaction1 = Interaction.where(user_id: current_user.id, property_id: property_id,favorite: true)
    begin
      if interaction1
        interaction1.delete_all
        render json: { message: 'Interacción eliminada correctamente' }, status: :ok
      else
        render json: { error: 'Interacción no encontrada' }, status: :not_found
      end
    rescue StandardError => e
      render json: { error: 'Ocurrió un error al eliminar la interacción' }, status: :unprocessable_entity
    end
  end

  # # GET /interactions/1 or /interactions/1.json
  # def show
  # end

  # # GET /interactions/new
  # def new
  #   @interaction = Interaction.new
  # end

  # # GET /interactions/1/edit
  # def edit
  # end

  # # POST /interactions or /interactions.json
  # def create
  #   @interaction = Interaction.new(interaction_params)

  #   respond_to do |format|
  #     if @interaction.save
  #       format.html { redirect_to interaction_url(@interaction), notice: "Interaction was successfully created." }
  #       format.json { render :show, status: :created, location: @interaction }
  #     else
  #       format.html { render :new, status: :unprocessable_entity }
  #       format.json { render json: @interaction.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # PATCH/PUT /interactions/1 or /interactions/1.json
  # def update
  #   respond_to do |format|
  #     if @interaction.update(interaction_params)
  #       format.html { redirect_to interaction_url(@interaction), notice: "Interaction was successfully updated." }
  #       format.json { render :show, status: :ok, location: @interaction }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @interaction.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /interactions/1 or /interactions/1.json
  # def destroy
  #   @interaction.destroy

  #   respond_to do |format|
  #     format.html { redirect_to interactions_url, notice: "Interaction was successfully destroyed." }
  #     format.json { head :no_content }
  #   end
  # end

  # private
  #   # Use callbacks to share common setup or constraints between actions.
  #   def set_interaction
  #     @interaction = Interaction.find(params[:id])
  #   end

    # Only allow a list of trusted parameters through.
    def interaction_params
      params.require(:interaction).permit(:favorite, :contacted, :actived, :closed)
    end
end
