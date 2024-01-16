class WorkoutSetsController < ApplicationController

  def create
    exercise = Exercise.find(params[:exercise_id])
    @set = WorkoutSet.new(exercise: exercise)

    if @set.save
      redirect_to exercise
    else
      redirect_to exercise
      # render :new, status: :unprocessable_entity
    end
  end
end
