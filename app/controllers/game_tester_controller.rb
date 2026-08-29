class GameTesterController < ApplicationController
  before_action :authenticate_user!, except: [ :create, :index ]

  def index
  end

  def show
  end

  def create
    game_tester = GameTester.new(signup_params)

    if game_tester.save
      acces_token = encode_token(game_tester)

      render json: {
        user_id: user.id,
        token: acces_token
      }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_content
    end
  end

  def update
  end

  def delete
  end

  private

    def signup_params
      params.require(:game_tester).permit(:email, :password, :password_confirmation, :gender, :age)
    end
end
