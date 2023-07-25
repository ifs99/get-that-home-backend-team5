class PropertiesController < ApplicationController
  before_action :require_login!, only: %i[ show edit create update destroy ]
  # before_action :set_property, only: %i[ show edit update destroy ]

  # GET /properties or /properties.json
  def index
    render json: Property.all

  end

  # POST /properties -> create property
  def create
    new_property = current_user.properties.new(property_params)
    interaction1 = new_property.interactions.new(actived: true,user_id: current_user.id)

    if new_property.save
      interaction1.save
      render json: new_property, status: :created
    else
      render json: new_property.errors, status: :unprocessable_entity
    end
    
  end


  # GET /properties/id -> property id
  def show
    begin
      property1 = Property.find(params[:id])
      render json: property1
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Property with ID=#{params[:id]} not found" }, status: :not_found
    end
  end

  # PATCH /properties/id -> property id
  def update
    begin
      property1 = Property.find(params[:id])
      if property1.update(property_params)
        render json: property1
      else
        render json: property1.errors, status: :unprocessable_entity
      end
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Property with ID=#{params[:id]} not found" }, status: :not_found
    end
  end

  # def update
  #   property1 = Property.find(params[:id])
  #   if current_user.properties.ids.include?(params[:id].to_i) && property1.update(property_params)
  #     render json: property1
  #   else
  #     if !current_user.properties.ids.include?(params[:id].to_i) 
  #       render json: {"error": "The property does not belong to the current user"}
  #     else
  #       render json: property1.errors, status: :unprocessable_entity
  #     end
  #   end
  # end

  #DELETE /properties/id -> property id
  def destroy
    begin
      property1 = Property.find(params[:id])
      property1.interactions.destroy_all
      property1.destroy
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Property with ID=#{params[:id]} not found" }, status: :not_found
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  # def set_category
  #   @category = current_user.categories.find(params[:id])
  # end

  # Only allow a trusted parameter "white list" through.
  def property_params
    params.require(:property).permit(:operation_type, :location, :price, :property_type, :maintanance,:bathroom,:petfriendly,:bedroom,:area,:description,:name_image)
  end
end