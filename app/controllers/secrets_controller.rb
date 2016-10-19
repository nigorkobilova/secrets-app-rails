class SecretsController < ApplicationController
  before_action :require_login, only: [:index, :create, :destroy]
  def index
    @secrets = Secret.all
  end

  def create
    if Secret.create(secret_params)
      redirect_to :back, notice: "Secret created"
    else
      redirect_to :back, alert: "Secret not created"
    end
  end

  def destroy
    @user = User.find(session[:user_id])
    if Secret.find(params[:id]).destroy
      redirect_to @user
    else
      redirect_to :back, alert: "Secret could not be deleted"
    end
  end
  private
    def secret_params
      params.require(:secret).permit(:content, :user_id)
    end
end
