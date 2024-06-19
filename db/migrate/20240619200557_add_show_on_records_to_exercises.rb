class AddShowOnRecordsToExercises < ActiveRecord::Migration[7.1]
  def change
    add_column :exercises, :show_on_records, :boolean
  end
end
