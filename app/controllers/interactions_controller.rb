class InteractionsController < ApplicationController
  before_action :require_login!, only: %i[ update]

  def index_favorite
  interactions = current_user.interactions.where(favorite:true)
    render json: interactions
  end

  def create_favorite
   property = Property.find(params[:id])
   interaction = current_user.interactions.new(property_id: property.id, favorite:true)

    if interaction.save
     render json: interaction, status: :created
    else
     render json: { errors: interaction.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update_favorite
    property = Property.find(params[:id])
    interaction = current_user.interactions.find_by(property_id: property.id)

    if interaction.update(favorite:false)
      render json: interaction
    else
      render json: { errors: interaction.errors.full_messages }, status: :unprocessable_entity
    end

  end

  def index_contacted
    interactions = current_user.interactions.where(contacted:true)
    render json: interactions
  end

  def create_contacted
   property = Property.find(params[:id])
   interaction = current_user.interactions.new(property_id: property.id, contacted:true)

    if interaction.save
     render json: interaction, status: :created
    else
     render json: { errors: interaction.errors.full_messages }, status: :unprocessable_entity
    end
  end

end




  

