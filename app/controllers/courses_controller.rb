class CoursesController < ApplicationController
  skip_before_action :require_user, only: [:index]
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, except: [:index, :show]

  def index
    @courses = Course.paginate(page: params[:page], per_page: 2)
  end

  def show

  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      flash[:green] = "New course successfully created"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit

  end

  def update
    if @course.update(course_params)
      flash[:green] = "The update have been successfully"
      redirect_to root_path
    else
      render 'edit'
    end    
  end

  def destroy
    @course.destroy
    flash[:red] = "Course have been deleted"
    redirect_to root_path
  end

  private

  def course_params
    params.require(:course).permit(:short_name, :name, :description)
  end

  def set_course
    @course = Course.find(params[:id])
  end

  def require_admin
    if logged_in? and !current_user.admin?
      flash[:red] = "Only Admins can do this"
      redirect_to root_path
    end
  end
end