class StudentCoursesController < ApplicationController

  def create
    course_to_add = Course.find(params[:course_id])
    unless current_user.courses.include?(course_to_add)
      StudentCourse.create(course: course_to_add, student: current_user)
      flash[:green] = "#{course_to_add.name} was added"
      redirect_to current_user
    else
      flash[:red] = "there was something wrong"
      redirect_to root_path
    end
  end

end