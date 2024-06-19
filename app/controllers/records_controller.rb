class RecordsController < ApplicationController
  def index
    # fetch all exercises that we track totals, then calc the totals
    @exercises = Exercise.where(show_on_records: true)

    real_total = @exercises.reduce(0) { |sum, exercise| sum + exercise.highest_weight }
    estimated_total = @exercises.reduce(0) { |sum, exercise| sum + exercise.estimated_highest_set.estimated_max }
    @totals = {real_total:, estimated_total:}
  end
end
