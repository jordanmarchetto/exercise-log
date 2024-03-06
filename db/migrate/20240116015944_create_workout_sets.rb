class CreateWorkoutSets < ActiveRecord::Migration[7.1]
  def change
    create_table :workout_sets do |t|
      t.references :exercise, null: false, foreign_key: true
      t.string :type
      t.integer :rep_count
      t.integer :rep_value
      t.integer :rpe
      t.integer :distance
      t.string :distance_unit
      t.float :duration
      t.boolean :timer_direction

      t.timestamps
    end
  end
end
