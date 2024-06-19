class RecordsController < ApplicationController
  def index
    # This is where you can fetch data for your view if needed
    @exercises = Exercise.where(show_on_records: true)
    real_total = @exercises.reduce(0) { |sum, exercise| sum + exercise.highest_weight }
    estimated_total = @exercises.reduce(0) { |sum, exercise| sum + exercise.estimated_highest_weight }
    @totals = {real_total:, estimated_total:}
  end
end
