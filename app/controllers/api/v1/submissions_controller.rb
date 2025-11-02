class Api::V1::SubmissionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_submission, only: [ :show, :update, :destroy ]

  def index
    render json: {
      submissions: current_user.submissions,
      message: "Successfully loaded submissions of #{current_user.studio_name}"
    }, status: :ok
  end

  def show
    render json: {
      submission: @submission,
      message: "Successfully loaded submission"
    }, status: :ok
  end

  def create
    submission = current_user.submissions.new(submission_params)

    if submission.save
      render json: { message: "Successfully created new submission", submission: submission }, status: :ok
    else
      render json: {
        message: "Failed to create submission",
        errors: submission.errors.full_messages
        }, status: :unprocessable_content
    end
  end

  def update
    if @submission.update(submission_params)
      render json: { message: "Successfully updated submission", submission: @submission }, status: :ok
    else
      render json: {
        message: "Failed to update submission",
        errors: @submission.errors.full_messages
      }, status: :unprocessable_content
    end
  end

  def destroy
    if @submission.destroy
      return render json: { message: "Successfully deleted submission" }, status: :ok
    end

    render json: { message: "Deletion of submission failed" }, status: :unprocessable_content
  end

  private

    def submission_params
      params.require(:submission).permit(
        :title,
        :description,
        :demo_url,
        :status,
        :version,
        genre: [],
        platforms: []
      )
    end

    def set_submission
      @submission = current_user.submissions.find_by(s_id: params[:s_id])

      render json: { message: "Submission not found" }, status: :not_found if @submission.nil?
    end
end
