class Api::V1::AuthController < ApplicationController
  def developer_login
    login_with_user_class(GameDeveloper)
  end

  def tester_login
    login_with_user_class(GameTester)
  end

  private

    def login_params
      params.require(:auth).permit(:email, :password)
    end

    def login_with_user_class(user_class)
      user = user_class.find_by(email: login_params[:email])

    if user&.authenticate(login_params[:password])
      token = encode_token(user)
      render json: {
        email: user.email,
        token: token
      }, status: :accepted
    else
      render json: { errors: [ "Invalid email or password" ] }, status: :unauthorized
    end
    end
end
