class Customer::SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && (user.authenticate params[:session][:password])
      log_in user
      redirect_back_or root_url
    else
      flash.now[:danger] = Settings.invalid_login
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
