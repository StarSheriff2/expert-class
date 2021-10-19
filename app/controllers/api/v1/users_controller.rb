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
    @user = User.find(params[:id])
    @user.destroy if @user.present?
    head :no_content
  end

  private

  def user_params
    # whitelist params
    params.permit(:name, :username)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
