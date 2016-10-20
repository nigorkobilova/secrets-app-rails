class LikesController < ApplicationController
  before_action :require_login

  def create
    Like.create(secret: Secret.find(params[:secret_id]), user: current_user)
    redirect_to :back
  end

  def destroy
    like = Like.find(params[:id])
    if like.user == current_user
      like.destroy
    end
    redirect_to :back
  end
end
