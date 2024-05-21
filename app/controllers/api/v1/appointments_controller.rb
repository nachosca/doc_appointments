class Api::V1::AppointmentsController < Api::BaseController

  before_action :set_appointment

  # Endpoint to book a doctor's open slot
  def book
    if @appointment.available?
      @appointment.update(patient_id: params[:patient_id])
      render json: @appointment, status: :created
    else
      render json: { error: 'Appointment not available' }, status: :unprocessable_entity
    end
  end

  def update
    ActiveRecord::Base.transaction do
      @appointment.update!(patient_id: nil)

      new_appointment = Appointment.not_assigned.find(params[:new_appointment_id])
      if new_appointment
        new_appointment.update!(patient_id: params[:patient_id])
        render json: new_appointment, status: :ok
      else
        render json: { error: 'New appointment slot not available' }, status: :unprocessable_entity
        raise ActiveRecord::Rollback
      end
    end
  end


  def destroy
    if @appointment.update(patient_id: nil)
      render json: { message: 'Appointment cancelled' }, status: :ok
    else
      render json: { errors: @appointment.errors }, status: :unprocessable_entity
    end
  end

  private


  def set_appointment
    @appointment ||= Appointment.find(params[:id])
  end
end
