class ApplicationController < ActionController::API
  ALLOWED_USERS = [ GameDeveloper, GameTester ].freeze

  def encode_token(user)
    JWT.encode({ user_id: user.id, user_class: user.class }, ENV["JWT_SECRET_KEY"])
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
      user_class = token_data[:user_class].constantize
      unless ALLOWED_USERS.include?(user_class)
        Rails.logger.warn("Unexpected user_class in token: #{user_class}")
        return nil
      end

      @current_user ||= user_class.find_by(id: token_data["user_id"])
    end
  end

  def authenticate_user!
    render json: { error: "Unauthorized access. Please log in." }, status: :unauthorized unless current_user
  end
end
