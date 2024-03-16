class TimedWorkoutSet < WorkoutSet
  # time based workout set; ex: planking
  NAME = "Timed Set"
  DESCRIPTION = "Tracks an amount of time."

  def self.has_duration?
    true
  end
end
