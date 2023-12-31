class SessionsController < ApplicationController
  skip_before_action :require_login!, only: :create

  def create
    user = User.valid_login?(params[:email], params[:password])
    if user
      puts user.name
      user.update_token
      render json: { token: user.token, type_user: user.type_user, name: user.name, email: user.email }
    else
      render_unauthorized('Incorrect email or password')
    end
  end

  def destroy
    current_user.invalidate_token
    head :ok
  end
end