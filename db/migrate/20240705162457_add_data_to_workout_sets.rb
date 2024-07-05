class AddDataToWorkoutSets < ActiveRecord::Migration[7.1]
  def change
    add_column :workout_sets, :data, :jsonb, default: {}
  end
end
