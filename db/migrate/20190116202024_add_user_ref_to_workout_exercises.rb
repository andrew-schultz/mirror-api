class AddUserRefToWorkoutExercises < ActiveRecord::Migration[5.2]
  def change
    add_reference :workout_exercises, :user, foreign_key: true
  end
end
