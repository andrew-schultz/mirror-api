class ExercisesController < ApplicationController
  def read
    id = params[ :id ]

    if id.present?
      exercise = Exercise.find( id )

      if exercise.present?
        render_result(
          exercise,
          {
            name: 'exercises',
            type_name: 'exercise'
          }
        )
      else
        render_error(
          {
            type: 'not_found_error',
            status_code: '404',
            message: 'Exercise with that ID could not be found.'
          }
        )
      end
  end

  def query
    exercises = Exercise.all
    render_result(
      exercises,
      {
        name: 'exercises',
        type_name: 'exercise',
        count: exercises.count
      }
    )
  end
end
