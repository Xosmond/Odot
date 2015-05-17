FactoryGirl.define do
  factory :usuario do
    sequence(:email) { |n| "user#{n}@odot.com" }
    password    "newpassnew"
    password_confirmation "newpassnew"
  end

  factory :todo_list do
    title  "Todo List Title"
    user
  end

  factory :todo_item do
    content "Todo Item"
  end
end