class Api::V1::SubmissionsController < ApplicationController
  def index
    if current_user.nil?
      render json: { error: "Current_user not found. Try logging in again" }, status: :unauthorized
      return
    end

    render json: {
      data: {
        submissions: current_user.submissions,
        message: "Successfully loaded submissions of #{current_user.studio_name}"
      }
    }, status: :ok
  end

  def show
    submission = Submission.find_by(s_id: params[:id])

    if submission.nil?
      render json: { error: "Submission was not found in the database" }, status: :not_found
      return
    end

    render json: {
      data: {
        submission: submission,
        message: "Successfully loaded submission"
      }
    }, status: :ok
  end

  # def create
  # end

  # def update
  # end

  # def destroy
  # end

  private

    def submission_params
      params.permit(
        :title,
        :s_id,
        :description,
        :genre,
        :platforms,
        :demo_url,
        :status,
        :version)
    end
end
