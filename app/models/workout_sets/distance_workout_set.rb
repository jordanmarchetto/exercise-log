class DistanceWorkoutSet < WorkoutSet
  # distance based set; ex: jogging
  NAME = "Distance Set"
  DESCRIPTION = "Tracks a distance and duration."

  def self.has_distance?
    true
  end

  def self.has_duration?
    true
  end
end
