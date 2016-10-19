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

  describe 'relationships' do
    it 'has many secrets' do
      user = create_user
      secret1 = user.secrets.create(content: 'secret 1')
      secret2 = user.secrets.create(content: 'secret 2')
      expect(user.secrets).to include(secret1)
      expect(user.secrets).to include(secret2)
    end
    it 'has many likes' do
      user = create_user
      secret1 = user.secrets.create(content: 'Oops')
      secret2 = user.secrets.create(content: 'I did it again')
      like1 = Like.create(user: user, secret: secret1)
      like2 = Like.create(user: user, secret: secret2)
      expect(user.likes).to include(like1)
      expect(user.likes).to include(like2)
    end
  end
end
