class WorkoutSet < ApplicationRecord
  belongs_to :exercise

  # if descendants aren't properly autoloading:
  # Dir["#{Rails.root}/app/models/workout_sets/*.rb"].each do |file|
  #   require_dependency file
  # end

  def self.has_reps?
    false
  end

  def self.has_weight?
    false
  end

  def self.has_rpe?
    false
  end
end
