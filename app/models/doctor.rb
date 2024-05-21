class Doctor < ApplicationRecord
  has_many :availabilities
  has_many :appointments
  

  def weekly_schedule
    schedule = {}
    (0..6).each do |day|
      daily_availabilities = availabilities.for_day(day)
      daily_slots = daily_availabilities.map do |availability|
        {
          start_time: availability.formatted_start_time,
          end_time: availability.formatted_end_time
        }
      end
      schedule[Date::DAYNAMES[day]] = daily_slots
    end
    schedule
  end
  
end
