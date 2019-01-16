class CreateExercises < ActiveRecord::Migration[5.2]
  def change
    create_table :exercises do |t|
      t.timestamps null: false
      t.string     :name
      t.string     :description
    end
  end
end
