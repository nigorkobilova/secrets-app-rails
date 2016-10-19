require 'rails_helper'
RSpec.describe 'user profile page' do
  before do
    @user = create(:user)
    log_in @user
  end
  it "displays a user's secrets on profile page" do
    secret = @user.secrets.create(content: 'secret')
    visit "/users/#{@user.id}"
    expect(page).to have_text("#{secret.content}")
  end
  it "displays everyone's secrets" do
    user2 = create_user 'julius', 'julius@lakers.com'
    secret1 = @user.secrets.create(content: 'secrets are very fun')
    secret2 = user2.secrets.create(content: 'this is a 2nd secret')
    visit '/secrets'
    expect(page).to have_text(secret1.content)
    expect(page).to have_text(secret2.content)
  end
end