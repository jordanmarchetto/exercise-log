class AddDurationUnitToWorkoutSets < ActiveRecord::Migration[7.1]
  def change
    add_column :workout_sets, :duration_unit, :string
  end
end
