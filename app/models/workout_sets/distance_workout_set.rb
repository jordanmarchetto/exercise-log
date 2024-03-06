class DistanceWorkoutSet < WorkoutSet
  # distance based set; ex: jogging

  def self.has_distance?
    true
  end

  def self.has_duration?
    true
  end
end
