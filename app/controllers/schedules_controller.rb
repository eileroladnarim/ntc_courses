class SchedulesController < ApplicationController
  def show
    @schedule = Schedule.find(params[:id])
  end

def new
   @schedule = Schedule.new
  end
def create
   @schedule = Schedule.new(schedule_params)
    if @schedule.save
	flash[:success] = "Schedule successfully added."
	redirect_to root_url
    else
      render 'new'
    end
  end

  private

 def schedule_params
      params.require(:schedule).permit(:courses, :instructor, :training_manager, :actual_number_of_days, :schedule_type, :available_slots, :start_date, :end_date)
    end

end
