class ExercisesController < ApplicationController
  def index
    @exercises = Exercise.all.order("name ASC")
  end

  def show
    @exercise = Exercise.find(params[:id])
    @sets = WorkoutSet.where(exercise: @exercise).order("created_at DESC")
    @set = WorkoutSet.new
  end

  def new
    @exercise = Exercise.new
  end

  def create
    @exercise = Exercise.new(exercise_params)

    if @exercise.save
      redirect_to @exercise
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @exercise = Exercise.find(params[:id])
  end

  def update
    @exercise = Exercise.find(params[:id])

    if @exercise.update(exercise_params)
      redirect_to @exercise
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @exercise = Exercise.find(params[:id])
    @exercise.destroy

    redirect_to root_path, status: :see_other
  end

  private

  def exercise_params
    filtered_params = params.require(:exercise).permit(:name, :description, :show_on_records, set_types: [])

    if params[:set_types]
      filtered_params[:set_types] = params[:set_types].keys
    end
    filtered_params
  end
end
