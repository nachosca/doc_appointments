class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient, optional: true

  validates :start_time, presence: true
  validates :end_time, presence: true

  scope :not_assigned, -> { where(patient_id: nil) }

  def formatted_start_time
    start_time.strftime("%H:%M")
  end

  def formatted_end_time
    end_time.strftime("%H:%M")
  end

  def available?
    patient.blank?
  end
end
