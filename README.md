
# README

## Doctor Appointments App:

The objective of this app is to offer the doctor's available slots to the patients so they can schedule an appointment, avoiding overlapping and having control of the bookings.

Pre requisites to run this app:
- Having installed Ruby
- Executing 'bundle install'

Optional:
- To reset the database and load the seeds execute: `rake db:drop && rake db:create && rake db:migrate && rake db:seed`
- After resetting the database, you'll have to run the rails console and execute the Job with this command: `CreateAppointmentsJob.perform_now`
- This job generates the appointment slots for the doctors for the following 4 months

Running the app:
- Execute `rails s` to start the server.
- With postman or any other app, hit the endpoints.
- You can find the file 'postman_collection.json', where you can import it into postman

## Models

 - Doctor:
 Contains the doctor's information, name, appointment_duration, list of availabilities, list of appointments (slots)
 - Patient:
 Contains the patient information, name, email, phone_number, list of appointments (bookings)
 - Availability
 Associated with the doctor's day availability, it contains day_of_week, where 0: Sunday, 1: Monday, ..., 6: Saturday,  start_time, end_time, to contemplate the doctor's working hours and days of week so Appointments can be created later
 - Appointment
 An appointment is generated for each slot of working day and time based on the doctor's availability. A patient can book an appointment and be assigned for it.
 

## List of endpoints

 - Working hours
GET
*{host}/api/v1/doctors/:id/working_hours*
This endpoint returns the working hours of a doctor using the param :id in the url


* Doctor availability
GET
*{host}/api/v1/doctors/:id/availability?page=1*
This endpoint returns the doctor's paginated availability.
Optional params: 
from_date (YYYY-MM-DD), filters from the chosen date onwards
page (number), brings the number of the paginated page, default 1
per_page (number), amount of records brought in page, default 10


* Create appointment
POST
*{host}/api/v1/appointments/:id/book*
Params:
{
    "patient_id": 2
}
This endpoint associates a patient with an appointment (:id). You can retreive the appointment id from the Doctor Availability endpoint.



* Update Appointment
PATCH
*{host}/api/v1/appointments/:id*
Params:
{
    "patient_id": 1,
    "new_appointment_id": 2
}
This endpoint changes a patient's booking from one appointment to another.


* Working hours
DELETE
{host}/api/v1/appointments/:id
This endpoint deletes the association of a patient with the appointment, which makes it it free.



**Jobs:**

 - CreateAppointmentsJob:
The objective of this Job is to generate all the future slots(appointments) for each doctor based on it's availability (working days and hours) and appointment duration, for the following 4 months. It's supposed to be executed at the beginning of each month so it generates new availabities. It checks if the slot is already created before creating a new one so there's no overlapping.


**#ToDo's**

- Implement devise for patients registration
- Implement configatron gem to manage ENV variables
- Create specs in models and controllers
- Dockerize the app
- Schedule the CreateAppointmentsJob to be executed every month.
- Send email when booking is created
- Send email when booking is updated
- Send email when booking is cancelled
- Endpoint to display the daily agenda for each doctor
- Implement activeadmin gem for the receptionist so they can handle doctor's agenda
- Implement newrelic to identify areas where performance can improve
