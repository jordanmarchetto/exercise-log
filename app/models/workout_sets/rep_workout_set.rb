class RepWorkoutSet < WorkoutSet
  # generic rep based set where we don't track weight; ex: pushups
  NAME = "Rep Set"
  DESCRIPTION = "Tracks a number of reps (and RPE)."

  def self.has_reps?
    true
  end

  def self.has_rpe?
    true
  end
end
