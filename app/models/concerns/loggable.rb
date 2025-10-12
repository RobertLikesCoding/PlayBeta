module Loggable
  extend ActiveSupport::Concern

  included do
    after_commit :log_create_event, on: :create
    after_commit :log_update_event, on: :update
    after_commit :log_delete_event, on: :destroy
  end

  private

    def log_create_event
      begin
        EventLog.create!(
          loggable: self,
          action: "created",
          changes_data: previous_changes
        )
      rescue => e
        Rails.logger.error("Failed to create EventLog for create: #{e.message}")
      end
    end

    def log_update_event
      return if previous_changes.blank?

      begin
        EventLog.create!(
          loggable: self,
          action: "updated",
          changes_data: previous_changes.except("updated_at")
        )
      rescue => e
        Rails.logger.error("Failed to create EventLog for update: #{e.message}")
      end
    end

    def log_delete_event
      begin
        EventLog.create!(
          loggable: self,
          action: "deleted",
          changes_data: previous_changes
        )
      rescue => e
        Rails.logger.error("Failed to create EventLog for delete: #{e.message}")
      end
    end
end
