class RecentWorkoutsController < ApplicationController
  WORKOUTS_TO_FETCH = 5

  def index
    # Example:
    # @workouts = [
    #   {date: "12/29/2022", movements: [
    #     {exercise: Exercise.find(3), sets: WorkoutSet.where(exercise: Exercise.find(3)).last(3) },
    #     {exercise: Exercise.find(4), sets: WorkoutSet.where(exercise: Exercise.find(4)).last(3) },
    #     ]},
    #   {date: "12/27/2022", movements: [
    #     {exercise: Exercise.find(3), sets: WorkoutSet.where(exercise: Exercise.find(3)).last(3) },
    #     {exercise: Exercise.find(4), sets: WorkoutSet.where(exercise: Exercise.find(4)).last(3) },
    #     ]}
    #   ]

    # fetch all workout sets, find the last 3 dates
    recent_dates = WorkoutSet.select("DISTINCT DATE(created_at) AS created_date").order("created_date DESC").limit(WORKOUTS_TO_FETCH).map{|r| r.created_date}

    # for each of those dates, find which exercises were done
    exercise_ids = WorkoutSet.where("DATE(created_at) IN (?)", recent_dates).pluck(:exercise_id).uniq

    # for each of those exercises, pull all the sets done that day
    @workouts = recent_dates.map do |date|
      movements = exercise_ids.map do |exercise_id|
        sets = WorkoutSet.where("DATE(created_at) = ? AND exercise_id = ?", date, exercise_id)
        { exercise: Exercise.find(exercise_id), sets: sets }
      end
      {date:, movements:}
    end
  end
end
