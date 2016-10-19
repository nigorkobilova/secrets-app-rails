require 'rails_helper'
RSpec.describe 'updating user' do
  it 'updates user and redirects to profile page' do
    user = create(:user)
    log_in user
    expect(page).to have_text(user.name)
    click_link 'Edit Profile'
    old_name = user.name
    fill_in 'Name', with: 'drake'
    click_button 'Update'
    expect(page).not_to have_text(old_name)
    expect(page).to have_text('drake')
  end
end