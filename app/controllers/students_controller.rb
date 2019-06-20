class StudentsController < ApplicationController
  skip_before_action :require_user, only: [:new, :create]
  before_action :set_student, only: [:show, :edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update]
  before_action :require_admin, only: [:destroy]


  def index
    @students = Student.paginate(page: params[:page], per_page: 4)
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

    def require_same_user
      if current_user != @student and !current_user.admin?
        flash[:orange] = "you can only edit your own profile"
        redirect_to student_path(current_user)
      end
    end

    def require_admin
      if logged_in? and current_user.admin?
        flash.now[:orange] = "Administrator"
      end
    end
end
