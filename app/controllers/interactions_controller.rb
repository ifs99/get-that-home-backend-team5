class InteractionsController < ApplicationController
  before_action :set_interaction, only: %i[ show edit update destroy ]


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

    # Only allow a list of trusted parameters through.
    def interaction_params
      params.require(:interaction).permit(:favorite, :contacted, :actived, :closed)
    end
end
