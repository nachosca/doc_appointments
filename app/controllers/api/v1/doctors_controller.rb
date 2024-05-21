class Api::V1::DoctorsController < Api::BaseController
  before_action :validate_filters, only: :availability
  before_action :find_doctor

  def working_hours
    render json: @doctor.weekly_schedule
  end


  def availability
    # Set default start date to today if it's empty
    from_date = params[:from_date] ? Date.parse(params[:from_date]) : Date.today

    # Apply filters
    appointments = @doctor.appointments.not_assigned.where("start_time >= ?", from_date)

    availabilities = appointments.page(params[:page]).per(params[:per_page] || 10)

    render json: {
      availabilities: availabilities,
      meta: pagination_meta(availabilities)
    }
  end


  private

  def find_doctor
    @doctor ||= Doctor.find(params[:id])
  end

  def pagination_meta(results)
    {
      current_page: results.current_page,
      next_page: results.next_page,
      prev_page: results.prev_page,
      total_pages: results.total_pages,
      total_count: results.total_count
    }
  end

  def validate_filters
    begin
      if params[:from_date].present?
        date = Date.parse(params[:from_date])
        render json: { error: "Date cannot be in the past" }, status: :unprocessable_entity if date < Date.today
      end
    rescue Exception => e
      render json: { error: "Invalid date or time format. #{e}" }, status: :unprocessable_entity
    end
  end
  
end
