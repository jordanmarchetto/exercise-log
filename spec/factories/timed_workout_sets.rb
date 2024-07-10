# spec/factories/weight_workout_sets.rb
FactoryBot.define do
  factory :timed_workout_set, parent: :workout_set, class: 'TimedWorkoutSet' do
    duration { 60 }
  end
end
