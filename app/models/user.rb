class User < ActiveRecord::Base
  has_many :secrets
  has_many :likes, dependent: :destroy
  has_many :secrets_liked, through: :likes, source: :secret

  before_save do
    self.email.downcase! if self.email
  end

  has_secure_password
  validates_presence_of :name, :email
  validates_uniqueness_of :email
  validates_format_of  :email, :with => /\A[\+A-Z0-9\._%-]+@([A-Z0-9-]+\.)+[A-Z]{2,4}\z/i
  validates :password, presence: true, confirmation: true
end
