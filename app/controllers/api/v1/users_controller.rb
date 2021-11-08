class API::V1::UsersController < ApplicationController
  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      render json: {
        status: :created,
        logged_in: true,
        user: @user
      }
    else
      render json: {
        status: 401,
        error: 'This username already exists. Please Choose another one.'
      }
    end
  rescue StandardError
    'This username already exists. Please Choose another one.'
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
    params.require(:user).permit(:name, :username)
  end
end
