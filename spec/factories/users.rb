FactoryGirl.define do
  factory :user do
    name "Zak"
    email "zak@strass.com"
    password "password"
    password_confirmation "password"
  end
end
