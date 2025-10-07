class Api::V1::GameDevelopersController < ApplicationController
  before_action :authenticate_user!, except: [ :create, :index ]

  def index
    game_developers = GameDeveloper.all
    render json: game_developers.as_json(except: [ :password_digest ]), status: :ok
  end

  def show
    if current_user
      render json: {
        id: current_user.id,
        email: current_user.email,
        bio: current_user.bio,
        website: current_user.website,
        location: current_user.location,
        studio_name: current_user.studio_name
      }, status: :ok
    end
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
      render json: { errors: user.errors.full_messages }, status: :unprocessable_content
    end
  end

  def update
    if current_user.update(user_params)
      render json: { message: "Successfully updated user data" }, status: :ok
    else
      render json: { errors: current_user.errors.full_messages }, status: :unprocessable_content
    end
  end


  private

    def user_params
      params.require(:game_developer)
        .permit(:email, :password, :password_confirmation, :bio, :website, :location, :studio_name, :avatar)
    end
end
