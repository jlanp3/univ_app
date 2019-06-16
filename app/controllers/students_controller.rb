class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]

  def index
    @students = Student.all
  end

  def show
    
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      flash[:green] = "You have successfully created your account"
      redirect_to @student
    else 
      render 'new'
    end
  end

  def edit

  end

  def update
    if @student.update(student_params)
      flash[:green] = "You have successfully updated your profile!"
      redirect_to @student
    else
      render 'edit'
      flash.now[:orange] = "there was some errors"
    end
  end

  def destroy
    @student.destroy
    redirect_to root_path
    flash[:red] = "Profile has been deleted"
  end

  private
    def set_student
      @student = Student.find(params[:id])  
    end

    def student_params
      params.require(:student).permit(:name, :email, :password)
    end
end
