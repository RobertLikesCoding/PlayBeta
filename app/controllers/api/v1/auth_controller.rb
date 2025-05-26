class Api::V1::AuthController < ApplicationController
  skip_before_action :authorized, only: [ :login ]

  def login
    @user = GameDeveloper.find_by(email: login_params[:email])

    # Check if the user exists and authenticate
    if @user&.authenticate(login_params[:password])
      @token = encode_token(@user.id)
      render json: {
        email: @user.email,
        token: @token
      }, status: :accepted
    else
      # Generic error message for both cases
      render json: { errors: [ "Invalid email or password" ] }, status: :unauthorized
    end
  end

  private

  def login_params
    params.require(:auth).permit(:email, :password)
  end
end
