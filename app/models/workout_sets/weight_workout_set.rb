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

  def estimated_max
    return 0 if rep_count == 0 || rep_value == 0

    ((rep_count * rep_value * 0.0333) + rep_value).round(0)
  end
end
