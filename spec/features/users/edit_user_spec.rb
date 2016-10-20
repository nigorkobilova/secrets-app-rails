require 'rails_helper'
RSpec.describe 'editing user' do
  it 'displays prepopulated form' do
    user = create(:user)
    log_in user
    click_link 'Edit Profile'
    expect(page).to have_field('Email')
    expect(find_field('Email').value).to eq(user.email)
    expect(page).to have_field('Name')
    expect(find_field('Name').value).to eq(user.name)
  end
end