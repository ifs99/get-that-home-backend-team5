class PropertiesController < ApplicationController
  before_action :require_login!, only: %i[ show edit create update destroy ]
  before_action :set_property, only: %i[ show edit update destroy ]

  # GET /properties or /properties.json
  def index
    puts "current_userrrr"
    puts current_user
    render json: Property.all

  end

  def create
    new_property = current_user.properties.new(property_params)

    if new_property.save
      render json: new_property, status: :created
    else
      render json: new_property.errors, status: :unprocessable_entity
    end
    
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = current_user.categories.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def property_params
    params.require(:property).permit(:operation_type, :location, :price, :property_type, :maintanance,:bathroom,:petfriendly,:bedroom,:area,:description)
  end
end

#   # GET /properties/1 or /properties/1.json
#   def show
#   end

#   # GET /properties/new
#   def new
#     @property = Property.new
#   end

#   # GET /properties/1/edit
#   def edit
#   end

#   # POST /properties or /properties.json
#   def create
#     @property = Property.new(property_params)

#     respond_to do |format|
#       if @property.save
#         format.html { redirect_to property_url(@property), notice: "Property was successfully created." }
#         format.json { render :show, status: :created, location: @property }
#       else
#         format.html { render :new, status: :unprocessable_entity }
#         format.json { render json: @property.errors, status: :unprocessable_entity }
#       end
#     end
#   end

#   # PATCH/PUT /properties/1 or /properties/1.json
#   def update
#     respond_to do |format|
#       if @property.update(property_params)
#         format.html { redirect_to property_url(@property), notice: "Property was successfully updated." }
#         format.json { render :show, status: :ok, location: @property }
#       else
#         format.html { render :edit, status: :unprocessable_entity }
#         format.json { render json: @property.errors, status: :unprocessable_entity }
#       end
#     end
#   end

#   # DELETE /properties/1 or /properties/1.json
#   def destroy
#     @property.destroy

#     respond_to do |format|
#       format.html { redirect_to properties_url, notice: "Property was successfully destroyed." }
#       format.json { head :no_content }
#     end
#   end

#   private
#     # Use callbacks to share common setup or constraints between actions.
#     def set_property
#       @property = Property.find(params[:id])
#     end

#     # Only allow a list of trusted parameters through.
#     def property_params
#       params.require(:property).permit(:operation_type, :location, :price, :property_type, :maintanance, :bathroom, :petfriendly, :bedroom, :area, :description, :user_id)
#     end
# end
