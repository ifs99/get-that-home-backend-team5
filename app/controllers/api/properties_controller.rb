class Api::PropertiesController < ApiController
  # before_action :authenticate_user!, only: [:index]
  def index
    render json: Property.all
  end

  def show
    property = Property.find(params[:id])
    render json: property
    
  end
end