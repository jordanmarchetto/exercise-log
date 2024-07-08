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
    data = fetch_pr_data(colors)
    data + calculate_totals_from_data(data, colors[data.length/2]) # next available color
  end

  # yields the best of each exercise on every day there was a workout
  def fetch_pr_data(colors)
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

  # yields the sum of tracked exercises every day
  def calculate_totals_from_data(workout_data, color)
    data = []

    # filter the workout_data so that we only have "dates" for when there was a PR
    # track which dates we should expect a new PR
    dates_with_new_maxes = []
    workout_data.each do |exercise|
      max = 0
      exercise[:data].sort.each do |date, weight|
        if weight > max
          max = weight
          dates_with_new_maxes << date
        end
      end
    end

    maxes, real_data, est_data = {}, {}, {}
    # iterate over every date where there's a new pr
    dates_with_new_maxes.sort.uniq.each do |date|
      # look at all exercises, and if they have a new pr this day
      # update that exercise's max with the new value
      workout_data.each do |exercise|
        next unless exercise[:data].include?(date)
        maxes[exercise[:name]] = 0 unless maxes.keys.include?(exercise[:name])
        if exercise[:data][date] > maxes[exercise[:name]]
          maxes[exercise[:name]] = exercise[:data][date]
        end
      end

      # get our new totals
      real_total = 0
      est_total = 0
      maxes.keys.each do |lift|
        if lift.include?(" (EST)")
          est_total += maxes[lift]
        else
          real_total += maxes[lift]
        end
      end

      # only put the totals on the chart once all exercises are accounted for
      if workout_data.length == maxes.length
        real_data[date] = real_total
        est_data[date] = est_total
      end
    end

    data << {name: "Total", color:, data: real_data}
    data << {name: "Total (EST)", color: lighten_color(color, 60), data: est_data}
    data
  end
end
