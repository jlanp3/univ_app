class StudentsController < ApplicationController

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
      flash[:success] = "Great!"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
    @student = Student.find(params[:id])
  end

  def update
    @student = Student.find(params[:id])
    if @student.update(student_params)
      flash[:success] = "You have successfully updated your profile!"
      redirect_to @student
    else
      render 'edit'
      flash.now[:notice] = "there was some errors"
    end
  end

  def destroy
    @student = Student.find(params[:id])
    @student.destroy
    redirect_to root_path
  end

  private
    def set_student
      @student = Student.find(params[:id])  
    end

    def student_params
      params.require(:student).permit(:name, :email)
    end
end
