class Exercise < ApplicationRecord
    has_many :workout_sets, dependent: :destroy

    validates :name, presence: true, allow_blank: false, uniqueness: true
    validates :set_types, presence: true, allow_blank: false

    def weight_workout_sets
        WeightWorkoutSet.where(exercise_id: id)
    end

    def all_time_weight_workout_sets
        WeightWorkoutSet.unscoped.where(exercise_id: id)
    end

    def highest_weight
        return 0 if weight_workout_sets.empty?

        weight_workout_sets.sort_by(&:rep_value).pluck(:rep_value).last.floor
    end

    def highest_weight_set
        return nil if weight_workout_sets.empty?

        weight_workout_sets.sort_by(&:rep_value).last
    end

    def highest_weight_ever
        return 0 if all_time_weight_workout_sets.empty?

        all_time_weight_workout_sets.sort_by(&:rep_value).pluck(:rep_value).last.floor
    end

    def highest_weight_set_ever
        return nil if all_time_weight_workout_sets.empty?

        all_time_weight_workout_sets.sort_by(&:rep_value).last
    end

    # do the estimated weight calc on every set and return the "best" set
    def estimated_highest_set
        return if weight_workout_sets.empty?

        estimated_weights = weight_workout_sets.map do |set|
            { weight: set.estimated_max, set:}
        end
        estimated_weights.sort_by { |set| set[:weight] }.last[:set]
    end

    def highest_estimated_weight
        estimated_highest_set&.estimated_max
    end

    # do the estimated weight calc on every set and return the "best" set
    def estimated_highest_set_ever
        return if all_time_weight_workout_sets.empty?

        estimated_weights = all_time_weight_workout_sets.map do |set|
            { weight: set.estimated_max, set:}
        end
        estimated_weights.sort_by { |set| set[:weight] }.last[:set]
    end

    def highest_estimated_weight_ever
        estimated_highest_set_ever&.estimated_max
    end
end
