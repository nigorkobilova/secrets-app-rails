require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  before do
    @user = create(:user)
    @secret = @user.secrets.create(content: "this is my secret")
    @like = @secret.likes.create(user: @user)
  end
  describe "when not logged in" do
    before do
      session[:user_id] = nil
    end
    it "cannot access create" do
      post :create, secret_id: @secret.id
      expect(response).to redirect_to('/sessions/new')
    end
    it "cannot access destroy" do
      delete :destroy, id: @like, secret_id: @secret.id
      expect(response).to redirect_to('/sessions/new')
    end
  end

  describe "when signed in as the wrong user" do
    before :each do
      @wrong_user = create(:user, name: 'julius', email: 'julius@lakers.com')
      log_in(@wrong_user)
      session[:user_id] = @wrong_user.id
      @request.env["HTTP_REFERER"] = user_path(@wrong_user.id)
    end
    it "cannot create a like for another user" do
      post :create, secret_id: @secret.id, user: @user
      expect(response).to redirect_to("/users/#{@wrong_user.id}")
      visit secrets_path
      expect(page).to have_content("Unlike")
    end
    it "cannot destroy another user's like" do
      delete :destroy, id: @like, secret_id: @secret.id
      expect(response).to redirect_to("/users/#{@wrong_user.id}")
      visit secrets_path
      expect(page).to have_text("1 like")
    end
  end
end
