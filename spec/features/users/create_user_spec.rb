require 'rails_helper'

RSpec.describe 'creating a user' do
  before do
    visit 'users/new'
  end
  it 'should create new user and redirect to profile page with proper credentials' do
    fill_in 'Name', with: "Zak S"
    fill_in 'Email', with: "Zak@Strass.com"
    fill_in 'Password', with: "password", match: :prefer_exact
    fill_in 'Password confirmation', with: "password", match: :prefer_exact
    click_button 'Create User'
    new_user = User.last
    expect(current_path).to eq("/users/#{new_user.id}")
  end
  it 'shows validation errors without proper credentials' do
    click_button 'Create User'
    expect(page).to have_content('Validation errors')
  end
end