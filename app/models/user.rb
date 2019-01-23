class User < ActiveRecord::Base
  has_secure_password

  #----------------------------------------------------------------------------
  # validations

  validates_presence_of     :name, :email, :password_digest

  validates                 :email, uniqueness: true

  #----------------------------------------------------------------------------
  # associations


  has_many :workouts
  has_many :workout_exercises
  has_many :exercises, through: :workout_exercises, source: :exercises
end
