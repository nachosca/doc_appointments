Doctor.create([
  { name: 'Dr. Smith', specialty: 'Cardiology', appointment_duration: 20 },
  { name: 'Dr. Jones', specialty: 'Dermatology', appointment_duration: 15 }
])

Patient.create([
  { name: 'Mike Smith', email: 'mike@test.com', phone_number: '123123123' },
  { name: 'Carlos Sanchez', email: 'carlos@test.com', phone_number: '123321123' }
])

Doctor.find_each do |doctor|
  Availability.create([
    { doctor: doctor, day_of_week: 1, start_time: '09:00', end_time: '16:00' }, # Monday
    { doctor: doctor, day_of_week: 2, start_time: '09:00', end_time: '16:00' }, # Tuesday
    # Wednesday empty
    { doctor: doctor, day_of_week: 4, start_time: '09:00', end_time: '12:00' }, # Thursday
    # Friday empty
    { doctor: doctor, day_of_week: 6, start_time: '09:00', end_time: '13:00' }  # Saturday
  ])
end