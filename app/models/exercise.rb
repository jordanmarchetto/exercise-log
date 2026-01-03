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

    #TODO: all these "_ever" methods should be dry'd up with the non-ever versions
    #TODO: add specs for these methods
    def highest_weight(all_records: false)
        highest_weight_set(all_records: all_records)&.rep_value&.floor || 0
    end

    def highest_weight_set(all_records: false)
        scope = all_records ? all_time_weight_workout_sets : weight_workout_sets
        return nil if scope.empty?

        scope.sort_by(&:rep_value).last
    end

    # do the estimated weight calc on every set and return the "best" set
    def estimated_highest_set(all_records: false)
        scope = all_records ? all_time_weight_workout_sets : weight_workout_sets
        return if scope.empty?

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
