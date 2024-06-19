module WorkoutSetsHelper
  def calc_1rm(sets)
    best_max = 0
    sets.each do |set|
      next unless set.is_a?(WeightWorkoutSet) && set.rep_value

      best_max = set.estimated_max if set.estimated_max > best_max
    end
    best_max.to_i
  end
end
