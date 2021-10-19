class API::V1::CoursesController < ApplicationController
  before_action :set_courses, only: [:index]
  before_action :set_course, only: [:show]

  def index
    render json: @courses
  end

  def show
    render json: @course
  end
end

private

def set_courses
  @courses = Course.all
end

def set_course
  @course = Course.find(params[:id])
end
