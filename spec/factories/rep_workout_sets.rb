# spec/factories/weight_workout_sets.rb
FactoryBot.define do
  factory :rep_workout_set, parent: :workout_set, class: 'RepWorkoutSet' do
    rep_count { 5 }
    data { {} }
  end
end
