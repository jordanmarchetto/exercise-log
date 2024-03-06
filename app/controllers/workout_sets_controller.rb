class WorkoutSetsController < ApplicationController

  def create
    #TODO: add param parsing
    exercise = Exercise.find(params[:exercise_id])
    @set = WorkoutSet.new(exercise: exercise, type: params[:type], rep_count: params[:rep_count], rep_value: params[:rep_value], rpe: params[:rpe] )

    if @set.save
      redirect_to exercise
    else
      redirect_to exercise
      # render :new, status: :unprocessable_entity
    end
  end
end
