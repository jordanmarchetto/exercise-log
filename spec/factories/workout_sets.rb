# spec/factories/workout_sets.rb
FactoryBot.define do
  factory :workout_set do
    association :exercise
  end
end
