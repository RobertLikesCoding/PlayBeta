module Loggable
  extend ActiveSupport::Concern

  included do
    after_commit :log_create_event, on: :create
    after_commit :log_update_event, on: :update
    after_commit :log_delete_event, on: :destroy
  end

  private

    def log_create_event
      EventLog.create(
        loggable: self,
        action: "created",
        changes_data: previous_changes
        )
    end

    def log_update_event
      return if previous_changes.blank?

      EventLog.create(
        loggable: self,
        action: "updated",
        changes_data: previous_changes.except("updated_at")
        )
    end

    def log_delete_event
      EventLog.create(
        loggable: self,
        action: "deleted",
        changes_data: previous_changes
        )
    end
end
