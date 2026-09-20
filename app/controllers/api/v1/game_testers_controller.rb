class Api::V1::GameTestersController < ApplicationController
  before_action :authenticate_user!, except: [ :create, :index ]

  def index
  end

  def show
    render json: { data: tester_json(current_user) }, status: :ok
  end

  def create
    game_tester = GameTester.new(signup_params)

    if game_tester.save
      access_token = encode_token(game_tester)

      render json: {
        data: {
          id: game_tester.id,
          token: access_token
        },
        message: "Successfully created user"
      }, status: :created
    else
      render json: { errors: game_tester.errors.full_messages }, status: :unprocessable_content
    end
  end

  def update
    if current_user.update(tester_params)
      render json: {
        data: tester_json(current_user),
        message: "Successfully updated user"
      }, status: :ok
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
      params.require(:game_tester).permit(:email, :birthdate, :gender, :avatar, :username)
    end

    def tester_json(tester)
      tester.slice(:id, :email, :birthdate, :gender, :username)
    end
end
