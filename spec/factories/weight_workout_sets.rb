# spec/factories/weight_workout_sets.rb
FactoryBot.define do
  factory :weight_workout_set, parent: :workout_set, class: 'WeightWorkoutSet' do
    rep_count { 5 }
    rep_value { 225 }
    rpe { 8 }
    data { {} }
  end
end
