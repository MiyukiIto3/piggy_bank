FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }
  end

  factory :other, class: "User" do
    email { "other@gmail.com" }
    password { "password2" }
  end
end
