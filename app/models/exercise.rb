class Exercise < ActiveRecord::Base

  #----------------------------------------------------------------------------
  # validations

  validates         :name,
                    presence: true

  #----------------------------------------------------------------------------
  # associations

  has_many :workout_exercises
  has_many :workouts, through: :workout_exercises, source: :workouts
end
