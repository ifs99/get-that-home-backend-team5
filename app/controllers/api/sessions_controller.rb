# app/controllers/api/v1/sessions_controller.rb
module Api
    class SessionsController < Devise::SessionsController

      before_action :authenticate_user!, only: [:destroy]

      def create
        user = User.find_by(email: params[:email])
        if user&.valid_password?(params[:password])
          user.reset_authentication_token!
          puts user_signed_in?
          sign_in(user) # Iniciar sesión usando Devises
          render json: { name: user.name ,token: user.authentication_token }
          puts "hola"
          puts user_signed_in?
        else
          render json: { error: 'Invalid email or password' }, status: :unauthorized
        end
      end

      def destroy
        Rails.logger.info("Cierre de sesión exitoso para el usuario: ")
        puts "hola"
        puts current_user
        puts "chau"
        sign_out(current_user)
        current_user.authentication_token = nil
        current_user.save
        
        head :no_content
        puts "hola"
        puts current_user.authentication_token
        if signed_out
          render json: { message: 'Cierre de sesión exitoso.' }, status: :ok
        else
          render json: { error: 'Error al cerrar sesión.' }, status: :unprocessable_entity
        end
      end
    end
end
