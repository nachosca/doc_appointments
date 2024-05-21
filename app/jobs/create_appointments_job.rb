class CreateAppointmentsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Doctor.find_each do |doctor|
      appointments_manager = DoctorAppointmentsManager.new(doctor)
      appointments_manager.create_appointments_for_doctor
    end
  end

end
