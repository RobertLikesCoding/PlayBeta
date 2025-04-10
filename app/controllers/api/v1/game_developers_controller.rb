class Api::V1::GameDevelopersController < ApplicationController
  skip_before_action :authorized, only: [ :create ]
  rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid_record

  def create
    game_developer = GameDeveloper.new(game_developer_params)
    @token = encode_token(game_developer: game_developer)

    render json: {
      studio_name: game_developer.studio_name,
      # location: game_developer.location,
      # bio: game_developer.bio,
      # website: game_developer.website,
      token: @token
    }, status: :created
  end

  def signup
  end

  def me
    render json: current_user, status: :ok
  end

  private

  def game_developer_params
    params.require(:game_developer).permit(:email, :password, :password_confirmation, :bio, :website, :studio_name, :location)
  end

  def handle_invalid_record(exception)
    render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
  end
end
