class CreateJoinTableWorkoutExercises < ActiveRecord::Migration[5.2]
  def change
    create_join_table :workouts, :exercises, table_name: :workout_exercises do |t|
      t.index [:workout_id, :exercise_id]
      t.index [:exercise_id, :workout_id]
      t.timestamps null: false
    end
  end
end
