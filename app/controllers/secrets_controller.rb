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
    secret = Secret.find(params[:id])
    if secret.user == current_user and Secret.find(params[:id]).destroy
      redirect_to current_user
    else
      redirect_to :back, alert: "Secret could not be deleted"
    end
  end
  private
    def secret_params
      params.require(:secret).permit(:content).merge(user: current_user)
    end
end
