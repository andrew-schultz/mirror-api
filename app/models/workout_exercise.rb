class WorkoutExercise < ActiveRecord::Base

  #----------------------------------------------------------------------------
  # validations

  validates         :user,
                    presence: true

  validates         :exercise,
                    presence: true

  validates         :workout,
                    presence: true

  #----------------------------------------------------------------------------
  # associations

  belongs_to :user
  belongs_to :exercise
  belongs_to :workout
end
