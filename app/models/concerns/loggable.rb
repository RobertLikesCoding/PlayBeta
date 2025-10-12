module Loggable
  extend ActiveSupport::Concern

  included do
    after_create :log_create_event
    after_update :log_update_event
    after_delete :log_delete_event
  end

  private

    def log_create_event
      EventLog.new(
        loggable: self,
        action: "created",
        changes_data: saved_changes
        )
    end

    def log_update_event
      return if saved_changes.blank?

      EventLog.new(
        loggable: self,
        action: "updated",
        changes_data: saved_changes
        )
    end

    def log_delete_event
      EventLog.new(
        loggable: self,
        action: "deleted",
        changes_data: saved_changes
        )
    end
end
