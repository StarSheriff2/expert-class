class API::V1::UsersController < ApplicationController
  def index
    @users = User.all

    render json: @users
  end
  # POST /users
  def create
    @user = User.create!(user_params)
    json_response(@user, :created)
  end
  # DELETE /users/:id
  def destroy
    @user.destroy
    head :no_content
  end
  
end
