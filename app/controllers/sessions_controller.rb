class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(email: params[:sessions][:email])
    if @user && @user.authenticate(params[:sessions][:password]) && !logged_in?
      log_in @user 
      params[:sessions][:remember_me] == "1" ? remember(@user) : forget(@user)
      flash[:success] = "Logged in."
      redirect_to @user 
    else
      flash[:error] = "Failed to log in."
      render :new
    end
  end

  def destroy 
    log_out @user if logged_in?
    redirect_to root_path
  end

end
