class WeightWorkoutSet < WorkoutSet
  # weight based set; ex: most barbell movements
  alias_attribute :weight, :rep_value
  NAME = "Weight Set"
  DESCRIPTION = "Tracks a number of reps, how heavy each rep was, and RPE."

  def self.has_reps?
    true
  end

  def self.has_weight?
    true
  end

  def self.has_rpe?
    true
  end
end
