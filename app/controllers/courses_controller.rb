class CoursesController < ApplicationController

def produceexcel
package = Axlsx::Package.new
workbook = package.workbook
@courses = Course.all
workbook.add_worksheet(name: "Basic work sheet") do |sheet|
  sheet.add_row ["Course Name", "Description"]
  @courses.each do |s|
    sheet.add_row [s.name,s.description]
  end
end

workbook.styles do |s|
  heading = s.add_style alignment: {horizontal: :center}, b: true, sz: 18, bg_color: "0066CC", fg_color: "FF"
end
package.serialize "Basic.xlsx"
end


  def show
    @course = Course.find(params[:id])
  end

def new
   @course = Course.new
  end
def create
   @course = Course.new(course_params)
    if @course.save
	flash[:success] = "Course successfully added."
	redirect_to root_url
    else
      render 'new'
    end
  end

  private

 def course_params
      params.require(:course).permit(:name, :description)
    end

end
