class CoursesController < ApplicationController
def produceexcel
package = Axlsx::Package.new
workbook = package.workbook

workbook.styles do |s|
  heading = s.add_style alignment: {horizontal: :center}, b: true, sz: 14, bg_color: "0066CC", fg_color: "FF"
 orange_cell = s.add_style :bg_color => "FF9900", :fg_color => "FF", :sz => 10, :alignment => { :horizontal=> :center }
  blue_cell =  s.add_style  :bg_color => "508C8C", :fg_color => "FF", :sz => 10, :alignment => { :horizontal=> :center }


@courses = Course.all
workbook.add_worksheet(name: "Basic work sheet") do |sheet|
  sheet.add_row ["Course Name", "Description"], style: heading,:widths => 'auto_width'
  @courses.each do |s|
    sheet.add_row [s.name,s.description],:style => [orange_cell, blue_cell],:widths => 'auto_width'
  end
sheet.column_widths 50, 50
end
end
#package.serialize "Basic.xlsx"

outstrio = StringIO.new
package.use_shared_strings = true # Otherwise strings don't display in iWork Numbers
outstrio.write(package.to_stream.read)
outstrio.string
send_data outstrio.string, :filename=>"Courses.xlsx"

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
