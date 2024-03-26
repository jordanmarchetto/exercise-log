module WorkoutSetsHelper
  def calc_1rm(sets)
    best_max = 0
    sets.each do |set|
      next unless set.is_a?(WeightWorkoutSet) && set.rep_value

      max = (set.rep_count * set.rep_value * 0.0333) + set.rep_value
      best_max = max if max > best_max
    end
    best_max.to_i
  end
end
