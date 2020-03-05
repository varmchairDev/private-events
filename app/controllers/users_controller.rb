class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :auth_check, only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new 
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user 
      flash[:success] = "Account created."
      redirect_to @user 
    else
      flash[:error] = "Failed to create account."
      render :new
    end
  end

  def edit
  end

  def update 
    if @user.update_attributes(user_params)
      flash[:success] = "Edited account."
      redirect_to @user 
    else
      flash[:error] = "Failed to edit account."
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = "Account deleted."
      redirect_to users_path
    else
      flash[:error] = "Failed to delete account."
      redirect_back(fallback_location: root_path)
    end
  end 

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
