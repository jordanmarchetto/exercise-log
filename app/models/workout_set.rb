class WorkoutSet < ApplicationRecord
  belongs_to :exercise

  # def self.descendants
  #   [WeightWorkoutSet]
  # end

  # Dir["#{Rails.root}/app/models/workout_sets/*.rb"].each do |file|
  #   require_dependency file
  # end
end
