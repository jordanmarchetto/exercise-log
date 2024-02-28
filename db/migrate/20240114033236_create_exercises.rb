class CreateExercises < ActiveRecord::Migration[7.1]
  def change
    create_table :exercises do |t|
      t.string :name
      t.text :description
      t.text :set_types, array: true, default: []

      t.timestamps
    end
  end
end
