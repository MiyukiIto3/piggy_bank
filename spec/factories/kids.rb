FactoryBot.define do
  factory :kid do
    name { "kid" }
    sex { 0 }
    target { "target" }
    target_amount { 1000 }
    user
  end

  factory :kid2, class: "Kid" do
    name { "kid2" }
    sex { 1 }
    target { "target2" }
    target_amount { 2000 }
    user
  end

  factory :kid3, class: "Kid" do
    name { "kid3" }
    sex { 0 }
    target { "target3" }
    target_amount { 3000 }
    user
  end
end
