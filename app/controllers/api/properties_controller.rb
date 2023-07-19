class Api::PropertiesController < ApiController
  def index
    render json: Property.all
  end

  def show
    property = Property.find(params[:id])
    render json: property
    
  end
end