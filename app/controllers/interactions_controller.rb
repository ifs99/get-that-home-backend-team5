class InteractionsController < ApplicationController
  before_action :require_login!, only: %i[ update]

 #GET /favorites favoritos del current user
  def index_favorite
  interactions = current_user.interactions.where(favorite:true)

    properties = interactions.map do |interaction|
      Property.find_by(id: interaction.property_id)
    end
    render json: properties
  end

  #POST /favorites/:id -> id property
  def create_favorite
   property = Property.find(params[:id])
   interaction = current_user.interactions.new(property_id: property.id, favorite:true)

    if interaction.save
     render json: interaction, status: :created
    else
     render json: { errors: interaction.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # patch    '/favorites/:id'

  def update_favorite
    property = Property.find(params[:id])
    interaction = current_user.interactions.find_by(property_id: property.id)

    if interaction.update(favorite:false)
      render json: interaction
    else
      render json: { errors: interaction.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # delete '/favorites/:id'
  def delete_favorite
    property = Property.find(params[:id])
    interaction = current_user.interactions.where(property_id: property.id)
    interaction.destroy_all
  end


  # post '/contacted/:id'
  def index_contacted
    interactions = current_user.interactions.where(contacted:true)
    properties = interactions.map do |interaction|
      Property.find_by(id: interaction.property_id)
    end
    render json: properties
  end

  # get '/contacted'
  def create_contacted
   property = Property.find(params[:id])
   interaction = current_user.interactions.new(property_id: property.id, contacted:true)

    if interaction.save
     render json: interaction, status: :created
    else
     render json: { errors: interaction.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # Landlord -> actived and closed

  # GET /actived
  def index_actived
    interactions = current_user.interactions.where(actived: true)
    properties = interactions.map do |interaction|
      Property.find_by(id: interaction.property_id)
     end
    render json: properties
  end

  #PATCH /actived/:id id->property
  def update_actived
    property = Property.find(params[:id])
    interaction = current_user.interactions.find_by(property_id: property.id)
    if interaction.update(interaction_params)
      render json: interaction
    else
      render json: { errors: interaction.errors.full_messages }, status: :unprocessable_entity
    end
  end


  # GET /closed
  def index_closed
    interactions = current_user.interactions.where(closed: true)

    properties = interactions.map do |interaction|
      Property.find_by(id: interaction.property_id)
     end
    render json: properties
  end


private 
  def interaction_params
    params.require(:interaction).permit(:actived, :closed)
  end

end




  

