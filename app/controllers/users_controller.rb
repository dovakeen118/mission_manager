class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :update, :destroy]
  before_action :user_params, only: [:show, :update, :destroy]

  after_action :verify_authorized, only: [:show, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    authorize @user
  end

  def update
    authorize @user
    @user.update(new_user_params)

    if @user.save
      redirect_to users_path, notice: "User was updated!"
    else
      redirect_to users_path, notice: "Unable to update user."
    end
  end

  def destroy
    authorize @user

    if @user.destroy
      redirect_to users_path, notice: "User was deleted!"
    else
      redirect_to users_path, notice: "Unable to delete user."
    end
  end

  private

  def user_params
    @user = User.find(params[:id])
  end

  def new_user_params
    params.require(:user).permit(:role)
  end
end
