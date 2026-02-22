class PasswordsController < ApplicationController
  def update
    if validate_current_password
      if current_user.update(
        password: password_params[:new_password],
        password_confirmation: password_params[:new_password_confirmation])
        render json: { message: "Successfully changed the password" }, status: :ok
      else
        render json: { erorrs: current_user.errors.full_messages }, status: :unprocessable_content
      end
    end
  end

  private

    def password_params
      params.require(:password_changes).permit(:current_password, :new_password, :new_password_confirmation)
    end

    def validate_current_password
      current_user.validate_current_password(password_params[:current_password])
    end
end
