class DoctorAppointmentsManager
  attr_accessor :doctor

  def initialize(doctor)
    self.doctor = doctor
  end

  #iterate each day for the following 4 months
  #if there's availability for the day_of_week, call create_appointments_for_availability
  def create_appointments_for_doctor
    start_date = Date.today
    end_date = (start_date + 3.months).end_of_month

    (start_date..end_date).each do |date|
      day_of_week = date.wday
      availabilities = doctor.availabilities.for_day(day_of_week)

      availabilities.each do |availability|
        create_appointments_for_availability(date, availability)
      end
    end
  end

  #create appointments for a specific dates using the doctor's start_time, end_time and appointment_duration
  def create_appointments_for_availability(date, availability)
    appointment_duration = doctor.appointment_duration.minutes
    start_time = availability.start_time
    end_time = availability.end_time

    while start_time < end_time
      appointment_start = Time.zone.parse("#{date} #{start_time.strftime("%H:%M")}")
      appointment_end = Time.zone.parse("#{date} #{start_time.strftime("%H:%M")}") + appointment_duration

      create_appointment(doctor, appointment_start, appointment_end) if !appointment_exists?(doctor, appointment_start, appointment_end)

      start_time += appointment_duration
    end
  end

  def appointment_exists?(doctor, start_time, end_time)
    Appointment.exists?(doctor: doctor, start_time: start_time, end_time: end_time)
  end

  def create_appointment(doctor, start_time, end_time)
    doctor.appointments.create!(
      start_time: start_time,
      end_time: end_time)
  end
  
end



