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
  ["Deadlift", "Bench Press", "Back Squat"].each do |lift|
    Exercise.find_or_create_by!(name: lift, set_types: ['WeightWorkoutSet'], icon: 'bi-trophy-fill', show_on_records: true)
  end
  ["Jog", "Row"].each do |lift|
    Exercise.find_or_create_by!(name: lift, set_types: ['DistanceWorkoutSet'], icon: 'bi-scooter')
  end
  ["Plank"].each do |lift|
    Exercise.find_or_create_by!(name: lift, set_types: ['TimedWorkoutSet'], icon: 'bi-person-arms-up')
  end
  ["Front Squat"].each do |lift|
    Exercise.find_or_create_by!(name: lift, set_types: ['WeightWorkoutSet'], icon: 'bi-person-arms-up')
  end
  ["Biceps"].each do |lift|
    Exercise.find_or_create_by!(name: lift, set_types: ['RepWorkoutSet', 'WeightWorkoutSet'], icon: 'bi-person-arms-up')
  end

  #add some sets
  WeightWorkoutSet.new(exercise: Exercise.find(1), rep_value: 155, rep_count: 5,rpe: 5.5).save!
  WeightWorkoutSet.new(exercise: Exercise.find(1), rep_value: 155, rep_count: 5,rpe: 6).save!
  WeightWorkoutSet.new(exercise: Exercise.find(1), rep_value: 155, rep_count: 5,rpe: 9).save!

  DistanceWorkoutSet.new(exercise: Exercise.find(5), distance: 5, distance_unit: "mi", duration: 60).save!
  DistanceWorkoutSet.new(exercise: Exercise.find(6), distance: 5, distance_unit: "m", duration: 60).save!

  # seed some example workouts
  starting_weights = [300, 100, 200]
  [DateTime.now - 4.days, DateTime.now - 2.days, DateTime.now].each.with_index do |date, day_index|
    (0..2).each do |index|
      WeightWorkoutSet.new(created_at: date, exercise: Exercise.find(index+1), rep_value: starting_weights[index]+(20*day_index), rep_count: 5).save!
      WeightWorkoutSet.new(created_at: date, exercise: Exercise.find(index+1), rep_value: starting_weights[index]+(20*day_index)+5, rep_count: 3).save!
      WeightWorkoutSet.new(created_at: date, exercise: Exercise.find(index+1), rep_value: starting_weights[index]+(20*day_index)+10, rep_count: 1).save!
    end
  end
