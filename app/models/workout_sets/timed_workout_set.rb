class TimedWorkoutSet < WorkoutSet
  # time based workout set; ex: planking

  def self.has_duration?
    true
  end
end
