class WorkoutsController < ApplicationController
  def read
    id = params[ :id ]

    if id.present?
      workout = Workout.find( id )

      if workout.present?
        render_result(
          workout,
          {
            name: 'workouts',
            type_name: 'workout'
          }
        )
      else
        render_error(
          {
            type: 'not_found_error',
            status_code: '404',
            message: 'Workout with that ID could not be found.'
          }
        )
      end
    else
      render_error(
        {
          type: 'missing_parameter_error',
          status_code: '400',
          message: 'The workout id is required.'
        }
      )
    end
  end

  def write
    if workout_params[ :user_id ].present?
      user = User.find( workout_params[ :user_id ] )

      if user.present?
        workout = Workout.new( workout_params )

        if workout.save

          # check for workout_params[ :exercises ], if present, loop through and create workoutExcersize for each
          render_result(
            workout,
            {
              name: 'workouts',
              type_name: 'workout'
            }
          )
        else
          render_error(
            {
              type: 'invalid_parameter_error',
              status_code: '400',
              message: 'One or more of the workout parameters are missing or invalid, please review and try again.'
            }
          )
        end
      else
        render_error(
          {
            type: 'not_found_error',
            status_code: '404',
            message: 'User with that user_id could not be found.'
          }
        )
      end
    else
      render_error(
        {
          type: 'missing_parameter_error',
          status_code: '400',
          message: 'The user_id parameter is required.'
        }
      )
    end
  end

  def update
    if params[ :id ].present?
      workout = Workout.find( params[ :id ] )

      if workout_params[ :exercises ].present?
        add_workout_exercises( workout )
      end

      if workout.update( workout_params )

      # how are we going to handle including exercises in this?
      render_result(
        workout,
        {
          name: 'workouts',
          type_name: 'workout'
        }
      )
    else
      render_error(
        {
          type: 'missing_parameter_error',
          status_code: '400',
          message: 'The id parameter is required.'
        }
      )
    end
  end

  private

  def add_workout_exercises( workout )
    exercises_params = workout_params.delete( :exercises )

    exercises_params.each do | exercise |
      workout_exercise = WorkoutExcersize.create(
        workout_id: workout.id, exercise_id: exercise[ :id ], user_id: workout_params[ :user_id ]
      )
    end
  end

  def workout_params
    params.require( :workout ).permit(
      :name,
      :description,
      :id,
      :user_id,
      exercises: [
        :id
      ]
    )
  end
end
