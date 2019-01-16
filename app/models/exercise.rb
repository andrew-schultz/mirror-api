class Exercise < ActiveRecord::Base

  #----------------------------------------------------------------------------
  # validations

  validates         :name,
                    presence: true

  #----------------------------------------------------------------------------
  # associations

  has_many :workouts, through: :workout_exercises, source: :workouts
  has_many :workout_exercises
end
