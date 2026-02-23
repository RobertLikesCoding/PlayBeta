class Api::V1::PasswordsController < ApplicationController
  before_action :authenticate_user!

  def update
    unless valid_current_password?
      render json: { errors: current_user.errors.full_messages }, status: :unauthorized and return
    end

      if current_user.update(
        password: password_params[:new_password],
        password_confirmation: password_params[:new_password_confirmation])
        render json: { message: "Successfully changed the password" }, status: :ok
      else
        render json: { errors: current_user.errors.full_messages }, status: :unprocessable_content
      end
  end

  private

    def password_params
      params.require(:password_changes).permit(:current_password, :new_password, :new_password_confirmation)
    end

    def valid_current_password?
      current_user.validate_current_password(password_params[:current_password])
    end
end
