class Availability < ApplicationRecord
  belongs_to :doctor
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :day_of_week, inclusion: { in: 0..6 } # 0: Sunday, 1: Monday, ..., 6: Saturday

  # Scopes to filter availabilities
  scope :for_day, ->(day) { where(day_of_week: day) }

  def formatted_start_time
    start_time.strftime("%H:%M")
  end

  def formatted_end_time
    end_time.strftime("%H:%M")
  end

end
