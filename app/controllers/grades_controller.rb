class GradesController < InheritedResources::Base

  def index
    @user = User.find(params[:user_id])
    @grades = @user.grade
  end
  
  def new
    @user = User.find(params[:user_id])
    @grade = Grade.new
  end
  
  def create
    @user = User.find(params[:user_id])
    @grade = Grade.create(params[:post])
    if @grade.save
        redirect_to user_grade_path(@user, @grade)
    else
        render :edit
    end
  end
  
  def edit
    @user = User.find(params[:user_id])
    @grade = Grade.find(params[:id])
  end
  
  def show
    require 'Jbuilder'
    @user = User.find(params[:user_id])
    @grade = Grade.find(params[:id])
  end
  
  
end
