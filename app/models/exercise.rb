class Exercise < ApplicationRecord
    has_many :workout_sets

    validates :name, presence: true, allow_blank: false, uniqueness: true
    validates :set_types, presence: true, allow_blank: false
end
