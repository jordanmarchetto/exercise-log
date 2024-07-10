# spec/factories/workout_sets.rb
FactoryBot.define do
  factory :workout_set do
    association :exercise
    data { {is_pr: false} }
  end
end
