module Loggable
  extend ActiveSupport::Concern

  included do
    after_commit :log_create_event, on: :create
    after_commit :log_update_event, on: :update
    after_commit :log_delete_event, on: :destroy
  end

  private

    def create_event_log(action, changes_data)
      begin
        EventLog.create!(
          loggable: self,
          action:,
          changes_data:
        )
      rescue => e
        Rails.logger.error(
          "EventLog failed in #{self.class.name}##{__method__}: #{e.class} - #{e.message}\n#{e.backtrace.join("\n")}"
          )
      end
    end

    def log_create_event
      create_event_log("create", previous_changes)
    end

    def log_update_event
      create_event_log("update", previous_changes.except("updated_at"))
    end

    def log_delete_event
      begin
        EventLog.create!(
          loggable_type: self.class.name,
          loggable_id: self.id,
          action: "deleted",
          changes_data: previous_changes
        )
      rescue => e
        Rails.logger.error(
          "EventLog failed in #{self.class.name}##{__method__}: #{e.class} - #{e.message}\n#{e.backtrace.join("\n")}"
          )
      end
    end
end
