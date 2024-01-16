class Exercise < ApplicationRecord
    has_many :workout_sets

    validates :name, presence: true
end
