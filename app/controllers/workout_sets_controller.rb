class WorkoutSetsController < ApplicationController

  def create
    #TODO: add param parsing
    exercise = Exercise.find(params[:exercise_id])
    @set = WorkoutSet.new(exercise: exercise, type: params[:type], rep_count: params[:rep_count].to_i, rep_value: params[:rep_value].to_i, rpe: params[:rpe].to_f, distance: params[:distance].to_i, distance_unit: params[:distance_unit], duration: params[:duration].to_f, timer_direction: params[:timer_direction] )

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

  def edit
    @set = WorkoutSet.find(params[:id])
  end

  def update
    @set = WorkoutSet.find(params[:id])

    if @set.update(params)
      redirect_to @set
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @set = WorkoutSet.find(params[:id])
    @set.destroy

    redirect_to root_path, status: :see_other
  end
end
