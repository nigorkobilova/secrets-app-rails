require 'rails_helper'

RSpec.describe User, type: :model do
  it 'requires a name' do
    user = build(:user, name: '')
    user.valid?
    expect(user.errors[:name].any?).to eq(true)
  end

  it 'requires an email' do
    user = build(:user, email: '')
    user.valid?
    expect(user.errors[:email].any?).to eq(true)
  end
  it 'accepts properly formatted email' do
    user = build(:user)
    user.valid?
    expect(user.errors[:email].any?).to eq(false)
  end
  it 'rejects improperly formatted email' do
    user = build(:user, email: 'test@com')
    user.valid?
    expect(user.errors[:email].any?).to eq(true)
  end
  it 'requires a unique, case insensitive email address' do
    create(:user)
    user = build(:user, email:"ZAK@strass.com")
    user.valid?
    expect(user.errors[:email].any?).to eq(true)
  end
  it 'requires a password' do
    user = build(:user, password: '')
  end
  it 'requires the password to match the password confirmation' do
    user = build(:user, password_confirmation: "not password")
    user.valid?
    expect(user.errors[:password_confirmation].any?).to eq(true)
  end
  it 'automatically encrypts the password into the password_digest attribute' do
    user = build(:user)
    expect(user.password_digest.present?).to eq(true)
  end
  it 'can authenticate a user' do
    user = create(:user)
    expect(user.authenticate("password")).to eq(user)
  end
end
