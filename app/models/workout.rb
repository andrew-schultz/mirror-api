class Workout < ActiveRecord::Base

  #----------------------------------------------------------------------------
  # validations

  validates         :user,
                    presence: true

  validates         :name,
                    presence: true

  #----------------------------------------------------------------------------
  # associations

  belongs_to :user
  has_many   :exercises, through: :workout_exercises, source: :exercises
  has_many   :workout_exercises
end
