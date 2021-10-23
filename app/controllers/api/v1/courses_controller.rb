class API::V1::CoursesController < ApplicationController
  before_action :set_courses, only: [:index]
  before_action :set_course, only: %i[show destroy]
  before_action :create_course, only: [:create]

  def index
    render json: @courses
  end

  def show
    render json: @course
  end

  def create
    if @course.save
      render json: { message: 'Course successfully created' }, status: 201
    else
      render json: { message: 'Unable to create course' }, status: 400
    end
  end

  def destroy
    if @course
      @course.destroy
      render json: { message: 'Course successfully deleted' }, status: 204
    else
      render json: { message: 'Unable to delete course' }, status: 400
    end
  end
end

private

def set_courses
  @courses = Course.all
end

def set_course
  @course = Course.find(params[:id])
  @course['image-url'] = course.image_url
  @course
end

def create_course
  @course = Course.new(course_params)
  @course.attach_image
end

def course_params
  params.require(:course).permit(:title, :description, :instructor, :duration, :image)
end
