class EventLog < ApplicationRecord
  belongs_to :loggable, polymorphic: true
  belongs_to :game_developer, optional: true

  validates :action, presence: true

  def formatted_changes
    changes_data.transform_values do |value|
      if value.is_a?(Array) && value.size == 2
        old, new = value
        { old: old, new: new }
      else
        value
      end
    end
  end
end
