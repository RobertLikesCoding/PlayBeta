class Api::V1::GameDevelopersController < ApplicationController
  skip_before_action :authorized, only: [ :create, :index ]

def index
  game_developers = GameDeveloper.all
  render json: game_developers.as_json(except: [ :password_digest ]), status: :ok
end

  def create
    user = GameDeveloper.new(user_params)
    if user.save
      @token = encode_token(user.id)

      render json: {
        user_id: user.id,
        token: @token
      }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def me
    render json: {
      id: current_user.id,
      email: current_user.email,
      bio: current_user.bio
    }, status: :ok
  end

  private

  def user_params
    params.require(:game_developer).permit(:email, :password, :password_confirmation)
  end
end
