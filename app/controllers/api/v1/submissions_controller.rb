class Api::V1::SubmissionsController < ApplicationController
  def index
    if current_user.nil?
      render json: { error: "Current_user not found. Try logging in again" }, status: :unauthorized
      return
    end

    render json: {
      submissions: current_user.submissions,
      message: "Successfully loaded submissions of #{current_user.studio_name}"
    }, status: :ok
  end

  def show
    submission = Submission.find_by(s_id: params[:s_id])

    if submission.nil?
      render json: { error: "Submission was not found in the database" }, status: :not_found
      return
    end

    render json: {
      submission: submission,
      message: "Successfully loaded submission"
    }, status: :ok
  end

  def create
    submission = current_user.submissions.new(submission_params)

    if submission.save!
      render json: { message: "Successfully created new submission", submission: submission }, status: :ok
    else
      render json: {
        message: "Failed to create submission",
        errors: submission.errors.full_messages
        }, status: :unprocessable_entity
    end
  end

  def update
    submission = Submission.find_by(s_id: params[:s_id])
    return render json: { message: "Submission not found" }, status: :not_found if submission.nil?

    if submission.update!(submission_params)
      render json: { message: "Successfully updated submission", submission: submission }, status: :ok
    else
      render json: {
        message: "Failed to update submission",
        errors: submission.errors.full_messages
      }, status: unprocessable_entity
    end
  end

  # def destroy
  # end

  private

    def submission_params
      params.require(:submission).permit(
        :title,
        :description,
        :genre,
        :platforms,
        :demo_url,
        :status,
        :version
      )
    end
end
