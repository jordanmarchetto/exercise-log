class RecordsController < ApplicationController
  def index
    # fetch all exercises that we track totals
    @exercises = Exercise.where(show_on_records: true).includes(:workout_sets)

    # get totals for those exercises
    real_total = @exercises.reduce(0) { |sum, exercise| sum + exercise.highest_weight }.round(2)
    estimated_total = @exercises.reduce(0) { |sum, exercise| sum + (exercise.highest_estimated_weight || 0) }.round(0)
    @totals = {real_total:, estimated_total:}

    @chart_data = build_chart_data
  end

  # build chart data/options
  # chart_data[] => {name:, color:, data: {date: weight_lifted_that_day,}}
  # ex: {:color=>"#FF6384", :name=>"Deadlift", :data=>{Wed, 19 Jun 2024=>310, Fri, 21 Jun 2024=>330, Sun, 23 Jun 2024=>350}}
  def build_chart_data
    colors = Chartkick.options[:colors]
    data = []
    @exercises.each.with_index do |exercise, index|
      all_workouts = exercise.weight_workout_sets.where('created_at >= ?', Constants::MAX_PROGRESS_HISTORY.days.ago).group_by { |set| set.created_at.to_date }
      real_data, est_data = {}, {}
      all_workouts.each do |date, sets|
        real_data[date] = sets.sort_by(&:rep_value).last.rep_value
        est_data[date] = sets.map{|s|s.estimated_max}.sort.last
      end
      data << {color: colors[index], name: exercise.name, data: real_data}
      data << {color: lighten_color(colors[index], 60), name: exercise.name + " (EST)", data: est_data}
    end
    data
  end
end
