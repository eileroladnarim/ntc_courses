class InstructorsController < ApplicationController

def produceexcel
package = Axlsx::Package.new
workbook = package.workbook

workbook.styles do |s|
  heading = s.add_style alignment: {horizontal: :center}, b: true, sz: 14, bg_color: "0066CC", fg_color: "FF"
 orange_cell = s.add_style :bg_color => "FF9900", :fg_color => "FF", :sz => 10, :alignment => { :horizontal=> :center }
  blue_cell =  s.add_style  :bg_color => "508C8C", :fg_color => "FF", :sz => 10, :alignment => { :horizontal=> :center }


@instructors = Instructor.all
workbook.add_worksheet(name: "Instructor Sheet") do |sheet|
  sheet.add_row ["First Name","Middle Name","Last Name", "Birthdate"], style: heading
  @instructors.each do |s|
    sheet.add_row [s.first_name,s.middle_name,s.last_name,s.birth_date],:style => [orange_cell, blue_cell,orange_cell,blue_cell]
  end
sheet.column_widths 30, 30, 30 ,30
end
end
#package.serialize "Basic.xlsx"

outstrio = StringIO.new
package.use_shared_strings = true # Otherwise strings don't display in iWork Numbers
outstrio.write(package.to_stream.read)
outstrio.string
send_data outstrio.string, :filename=>"Instructors.xlsx"
end

 def show
    @instructor = Instructor.find(params[:id])
  end

def new
   @instructor = Instructor.new
  end
def create
   @instructor = Instructor.new(instructor_params)
    if @instructor.save
	flash[:success] = "Instructor successfully added."
	redirect_to root_url
    else
      render 'new'
    end
  end

  private

 def instructor_params
      params.require(:instructor).permit(:first_name, :middle_name, :last_name, :birth_date)
    end

end
