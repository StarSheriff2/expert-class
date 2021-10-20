class API::V1::CoursesController < ApplicationController
  before_action :set_courses, only: [:index]
  before_action :set_course, only: [:show]
  before_action :create_course, only: [:create]

  def index
    render json: @courses
  end

  def show
    render json: @course
  end

  def create
    if @course.save
      render json: { message: 'User successfully created' }, status: 200
    else
      render json: { message: 'Unable to create user' }, status: 400
    end
  end
end

private

def set_courses
  @courses = Course.all
end

def set_course
  @course = Course.find(params[:id])
end

def create_course
  @course = Course.new(course_params)
end

def course_params
  params.require(:course).permit(:title, :description, :instructor, :duration, :image)
end
