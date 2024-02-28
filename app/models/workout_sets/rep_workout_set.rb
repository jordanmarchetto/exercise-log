class RepWorkoutSet < WorkoutSet
  # generic rep based set where we don't track weight; ex: pushups

  def self.has_reps?
    true
  end

  def self.has_rpe?
    true
  end
end
