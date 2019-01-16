class CreateWorkouts < ActiveRecord::Migration[5.2]
  def change
    create_table :workouts do |t|
      t.timestamps null: false
      t.string     :name
      t.references :user, index: true
      t.string     :description
    end
  end
end
