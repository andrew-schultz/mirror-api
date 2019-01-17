class User < ActiveRecord::Base
  has_secure_password

  #----------------------------------------------------------------------------
  # validations

  validates                 :email,
                            uniqueness: true

  validates                 :email,
                            presence: true

  validates_confirmation_of :password

  validates_presence_of     :password,
                            on: :create

  validates_presence_of     :email,
                            on: :create

  #----------------------------------------------------------------------------
  # associations


  has_many :workouts
  has_many :workout_exercises
  has_many :exercises, through: :workout_exercises, source: :exercises
end
