# spec/factories/exercises.rb
FactoryBot.define do
  factory :exercise do
    name { "Bench Press" }
    description { "An upper body strength exercise." }
    icon { "bi-trophy-fill" }
    show_on_records { true }
    set_types { ["WeightWorkoutSet"] }
  end
end
