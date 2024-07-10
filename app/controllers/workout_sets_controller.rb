class WorkoutSetsController < ApplicationController

  def create
    exercise = Exercise.find(params[:exercise_id])
    @set = WorkoutSet.new(workout_set_params)

    if @set.save
      redirect_to exercise
    else
      redirect_to exercise
      # render :new, status: :unprocessable_entity
    end
  end

  def show
    @set = WorkoutSet.find(params[:id])
  end

  def update
    @set = WorkoutSet.find(params[:id])

    if @set.update(workout_set_params)
      redirect_to @set.exercise
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @set = WorkoutSet.find(params[:id])
    exercise = @set.exercise
    @set.destroy

    redirect_to exercise, status: :see_other
  end

  private

  def workout_set_params
    rep_count = params[:rep_count].to_i
    rep_value = params[:rep_value].to_i
    rpe = params[:rpe].to_i
    distance = params[:distance].to_i
    duration = params[:duration].to_f
    params.permit(:exercise_id, :created_at, :type, :timer_direction, :distance_unit, :duration_unit).merge(rep_count:, rep_value:, rpe:, distance:, duration:)
  end
end
