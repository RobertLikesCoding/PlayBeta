class Api::V1::GameTestersController < ApplicationController
  before_action :authenticate_user!, except: [ :create, :index ]

  def index
  end

  def show
    if current_user
      render json: {
        id: current_user.id,
        email: current_user.email,
        birthdate: current_user.birthdate,
        gender: current_user.gender
      }, status: :ok
    end
  end

  def create
    game_tester = GameTester.new(signup_params)

    if game_tester.save
      acces_token = encode_token(game_tester)

      render json: {
        user_id: game_tester.id,
        token: acces_token
      }, status: :created
    else
      render json: { errors: game_tester.errors.full_messages }, status: :unprocessable_content
    end
  end

  def update
    if current_user.update(tester_params)
      render json: { message: "Successfully updated user data" }, status: :ok
    else
      render json: { errors: current_user.errors.full_messages }, status: :unprocessable_content
    end
  end

  def delete
  end

  private

    def signup_params
      params.require(:signup_payload).permit(:email, :password, :password_confirmation, :birthdate)
    end

    def tester_params
      params.require(:game_tester).permit(:email, :birthdate, :gender, :avatar)
    end
end
