class EventLog < ApplicationRecord
  belongs_to :loggable, polymorphic: true
  belongs_to :game_developer, optional: true

  validates :action, presence: true

  def formatted_changes
    changes_data.transform_values do |(old, new)|
      { old: old, new: new }
    end
  end
end
