class API::V1::CoursesController < ApplicationController
  def index
    @courses = Course.all

    render json: @courses
  end
end
