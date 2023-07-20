class UsersController < ApplicationController
  skip_before_action :require_login!, only: :create
  # GET /users or /users.json
  def index
    @users = User.all
  end

 
  def create
    user = User.new(user_params)

    if user.save
      render json: user, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end

  end

  
    def user_params
      params.permit(:email, :name, :password, :type_user, :phone, :created_at, :updated_at, :token)
    end
end
