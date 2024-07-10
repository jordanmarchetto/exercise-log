# spec/factories/weight_workout_sets.rb
FactoryBot.define do
  factory :distance_workout_set, parent: :workout_set, class: 'DistanceWorkoutSet' do
    distance { 5 }
    duration { 60 }
  end
end
