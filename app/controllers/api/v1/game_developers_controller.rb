class Api::V1::GameDevelopersController < ApplicationController
  before_action :authenticate_user!, except: [ :create, :index ]

  def index
    game_developers = GameDeveloper.all
    render json: game_developers.as_json(except: [ :password_digest ]), status: :ok
  end

  def show
    if current_user
      render json: {
        data: developer_json(current_user)
      }, status: :ok
    end
  end

  def create
    user = GameDeveloper.new(signup_params)
    if user.save
      access_token = encode_token(user)

      render json: {
        data: {
          user_id: user.id,
          token: access_token
        },
        message: "Successfully created user"
      }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_content
    end
  end

  def update
    if current_user.update(profile_params)
      render json: {
        data: developer_json(current_user),
        message: "Successfully updated user data"
      }, status: :ok
    else
      render json: { errors: current_user.errors.full_messages }, status: :unprocessable_content
    end
  end


  private

    def signup_params
      params.require(:signup_payload).permit(:email, :password, :password_confirmation)
    end

    def profile_params
      params.require(:game_developer)
            .permit(:email, :bio, :website, :location, :studio_name, :avatar)
    end

    def developer_json(developer)
      developer.slice(
        :id,
        :email,
        :bio,
        :website,
        :location,
        :studio_name
      )
    end
end
