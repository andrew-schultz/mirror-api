class UsersController < ApplicationController

  def write
    user = User.find_by( email: user_params[ 'email' ] )

    if user.present?
      user.update( user_params )
    else
      user = User.create( user_params )
    end

    render_result(
      user,
      {
        name: 'users',
        type_name: 'user'
      }
    )
  end

  def update
    if id = user_params.delete( :id )
      user = User.find( id ) rescue nil
      if user.present?
        user.update( user_params )
        user.save

        render_result(
          user,
          {
            name: 'users',
            type_name: 'user'
          }
        )
      else
        render_error(
          {
            type: 'not_found_error',
            status_code: '404',
            message: 'User with that ID could not be found.'
          }
        )
      end
    else
      render_error(
        {
          type: 'missing_parameter_error',
          status_code: '400',
          message: 'The user id is required.'
        }
      )
    end
  end

  def read
    if params[ :id ].present?
      user = User.find( params[ :id ] )

      if user.present?
        render_result(
          user,
          {
            name: 'users',
            type_name: 'user'
          }
        )
      else
        render_error(
          {
            type: 'not_found_error',
            status_code: '404',
            message: 'User with that ID could not be found.'
          }
        )
      end
    else
      render_error(
        {
          type: 'missing_parameter_error',
          status_code: '400',
          message: 'The user id is required.'
        }
      )
    end
  end

  private

  def user_params
    params.require( :user ).permit( :email, :name, :password, :id )
  end

end
