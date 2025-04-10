class ApplicationController < ActionController::API
  before_action :authorized

  SECRET_KEY = Rails.application.credentials.jwt_secret_key

  def encode_token(user)
    payload = {
      user_id: user.id,
      user_type: user.class.name
    }

    JWT.encode(payload, SECRET_KEY)
  end

  def decode_token
    header = request.headers["Authorization"]
      if header
          token = header.split(" ")[1]
          begin
              decoded = JWT.decode(token, SECRET_KEY, { algorithm: "HS256" })[0]
              HashWithIndifferentAccess.new(decoded)
          rescue JWT::DecodeError => e
            Rails.logger.error("JWT Decode Error: #{e.message}")
          end
      end
    nil
  end

  def current_user
    if decode_token
      user_id = decode_token[0]["user_id"]
      user_type = decode_token[0]["user_type"]
      begin
        user_model = user_type.constantize  # Convert the user_type string to the actual class (e.g., "GameDeveloper" => GameDeveloper)
        @user = user_model.find_by(id: user_id)
      rescue NameError => e
        Rails.logger.error("Invalid user type: #{e.message}")
        @user = nil
      end
      @user
    end
  end

  def authorized
    unless !!current_user
      render json: { message: "Please log in" }, status: :unauthorized
    end
  end
end
