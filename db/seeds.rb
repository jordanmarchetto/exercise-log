# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

  #add some exercises
  ["Front Squat", "Deadlift", "Bench Press", "Back Squat"].each do |lift|
    Exercise.find_or_create_by!(name: lift, set_types: ['WeightWorkoutSet'], icon: 'bi-trophy-fill')
  end
  ["Jog", "Row"].each do |lift|
    Exercise.find_or_create_by!(name: lift, set_types: ['DistanceWorkoutSet'], icon: 'bi-scooter')
  end
  ["Plank"].each do |lift|
    Exercise.find_or_create_by!(name: lift, set_types: ['TimedWorkoutSet'], icon: 'bi-person-arms-up')
  end
  ["Biceps"].each do |lift|
    Exercise.find_or_create_by!(name: lift, set_types: ['RepWorkoutSet', 'WeightWorkoutSet'], icon: 'bi-person-arms-up')
  end

  #add some sets
  s = WeightWorkoutSet.new(exercise: Exercise.first, rep_value: 155, rep_count: 5, rpe: 5.5)
  s.save!
  s = WeightWorkoutSet.new(exercise: Exercise.first, rep_value: 155, rep_count: 5,rpe: 6)
  s.save!
  s = WeightWorkoutSet.new(exercise: Exercise.first, rep_value: 155, rep_count: 5,rpe: 9)
  s.save!

  s = DistanceWorkoutSet.new(exercise: Exercise.find(5), distance: 5, duration: 60)
  s.save!
