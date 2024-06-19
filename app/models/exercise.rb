class Exercise < ApplicationRecord
    has_many :workout_sets

    validates :name, presence: true, allow_blank: false, uniqueness: true
    validates :set_types, presence: true, allow_blank: false

    def weight_workout_sets
        WeightWorkoutSet.where(exercise_id: id)
    end

    def highest_weight
        weight_workout_sets.sort_by(&:rep_value).pluck(:rep_value).last.round(2)
    end

    def estimated_highest_weight
        estimated_weights = weight_workout_sets.map do |set|
            (set.rep_count * set.rep_value * 0.0333) + set.rep_value
        end
        estimated_weights.sort.last.round(2)
    end

    def estimated_highest_set
        estimated_weights = weight_workout_sets.map do |set|
            { weight: (set.rep_count * set.rep_value * 0.0333) + set.rep_value, set:}
        end
        estimated_weights.sort_by { |set| set[:weight] }.last[:set]
    end
end
