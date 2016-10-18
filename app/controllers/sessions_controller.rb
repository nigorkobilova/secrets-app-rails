class SessionsController < ApplicationController
  def new
  end
  def create
    user = User.find_by_email(params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_path(user.id), notice: "Logged in successfully"
    else
      redirect_to :back, alert: "Invalid credentials"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to new_session_path
  end
end
