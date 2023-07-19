# app/controllers/api/v1/sessions_controller.rb
module Api
    class SessionsController < Devise::SessionsController
      def create
        user = User.find_by(email: params[:email])
        if user&.valid_password?(params[:password])
          user.reset_authentication_token!
          sign_in(user) # Iniciar sesión usando Devises
          render json: { name: user.name ,token: user.authentication_token }
          puts "hola"
        else
          render json: { error: 'Invalid email or password' }, status: :unauthorized
        end
      end

      def destroy
        puts "hola"
        puts current_user
        puts "chau"
        current_user.authentication_token = nil
        current_user.save
        head :no_content
        puts "hola"
        puts current_user.authentication_token
        render json: {  }
      end
    end
end
