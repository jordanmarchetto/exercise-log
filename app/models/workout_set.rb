class WorkoutSet < ApplicationRecord
  belongs_to :exercise

  # These should be defined in every child class
  NAME = "Workout Set Base Class"
  DESCRIPTION = "Base class for all other workout set subclasses."

  class TimerDirections
    TIMER_DIRECTIONS = %i[up down]
    TIMER_DIRECTIONS.each do |type|
      const_set type.to_s.upcase, type.to_s
    end
    VALID_TIMER_DIRECTIONS = [UP, DOWN].freeze
  end

  # if descendants aren't properly autoloading:
  Dir["#{Rails.root}/app/models/workout_sets/*.rb"].each do |file|
    require_dependency file
  end

  # we're using a bool db column, so true is up and false is down
  def timer_direction
    self[:timer_direction] ? TimerDirections::UP : TimerDirections::DOWN
  end

  def self.has_reps?
    false
  end

  def self.has_weight?
    false
  end

  def self.has_rpe?
    false
  end

  def self.has_distance?
    false
  end

  def self.has_duration?
    false
  end
end
