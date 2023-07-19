# app/controllers/api/users_controller.rb
class Api::UsersController < ApiController
    def index
      render json: User.all
    end
  
    def create
      user = User.new(user_params)
      user.reset_authentication_token! # Generar el token

      if user.save
        render json: { id: user.id, name: user.name, phone: user.phone, created_at: user.created_at, updated_at: user.updated_at, email: user.email ,token: user.authentication_token }, status: :created
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    private
  
    def user_params
      params.permit(:name, :email, :phone, :type_user, :password, :password_confirmation)
    end
    def generate_authentication_token
        user.reset_authentication_token!
      end
    
  end
  