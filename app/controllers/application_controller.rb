class ApplicationController < ActionController::API
  before_action :authorized

  def encode_token(user_id)
    JWT.encode({ user_id: user_id }, ENV["JWT_SECRET_KEY"])
  end

  def decode_token
    header = request.headers["Authorization"]
    return nil unless header

    token = header.split(" ")[1]
    return nil unless token

      begin
        # for testing use a seperate secret
        decoded = JWT.decode(token, ENV["JWT_SECRET_KEY"], { algorithm: "HS256" })[0]
        HashWithIndifferentAccess.new(decoded)
      rescue JWT::DecodeError => e
        Rails.logger.error("JWT Decode Error: #{e.message}")
        nil
      end
  end

  def current_user
    token_data = decode_token
    if token_data
      @current_user ||= GameDeveloper.find_by(id: token_data["user_id"])
    end
  end

  def authorized
    render json: { error: "Unauthorized access. Please log in." }, status: :unauthorized unless current_user
  end
end
