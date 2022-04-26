FactoryBot.define do
  factory :post do
    date { "2022-01-01" }
    post_type { "income" }
    amount { 10000 }
    description { "description1" }
    user
    kid
  end

  factory :post2, class: "Post" do
    date { "2022-01-02" }
    post_type { "income" }
    amount { 200 }
    description { "description2" }
    user
    kid
  end

  factory :post3, class: "Post" do
    date { "2022-01-03" }
    post_type { "income" }
    amount { 300 }
    description { "description3" }
    user
    kid
  end

  factory :post4, class: "Post" do
    date { "2022-01-04" }
    post_type { "outgo" }
    amount { 400 }
    description { "description4" }
    user
    kid
  end
end
