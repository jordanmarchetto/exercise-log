class RecentWorkoutsController < ApplicationController
  def index
    @workouts = [{date: "12/29/2022", sets: [WorkoutSet.last(6)]}, {date: "12/27/2022", sets: [WorkoutSet.first(6)]}]
    @workout = {date: "12/29/2022", sets: [WorkoutSet.last(6)]}
  end
end
