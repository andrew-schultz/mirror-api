class Workout < ActiveRecord::Base

  #----------------------------------------------------------------------------
  # validations

  validates_presence_of   :user, :name

  #----------------------------------------------------------------------------
  # associations

  belongs_to :user
  has_many   :workout_exercises
  has_many   :exercises, through: :workout_exercises, source: :exercise

  def add_workout_exercises( params )
    exercises_params = params.delete( :exercises )

    exercises_params.each do | exercise |
      WorkoutExercise.create(
        workout_id: self.id, exercise_id: exercise, user_id: params[ :user_id ]
      )
    end
  end

end
