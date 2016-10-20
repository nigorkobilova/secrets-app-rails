class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create]
  before_action :require_correct_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end
  def show
    @user = User.find(params[:id])
    @secret = Secret.new
  end

  def new
    @user = User.new
  end
  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to user_path(user.id)
    else
      redirect_to new_user_path, flash: { error: user.errors.full_messages}
    end
  end

  def edit
    @user = User.find(params[:id])
  end
  def update
    user = User.find(params[:id])
    if user.update_attributes(user_params)
      redirect_to user_path(user.id), flash: {alert: "Updated"}
    else
      redirect_to edit_user_path, flash: { error: user.errors.full_messages}
    end
  end

  def destroy
    user = User.find(params[:id])
    if user.delete
      session[:user_id] = nil
      redirect_to new_session_path, notice: "User successfully deleted"
    else
      redirect_to :back, notice: "Unable to delete user"
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
