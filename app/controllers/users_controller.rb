class UsersController < ApplicationController

  def login
    auth_object = Authentication.new( login_params )

    if auth_object.authenticate
      render_result(
        auth_object.user,
        {
          name: 'users',
          type_name: 'user',
          token: auth_object.generate_token
        }
      )
    else
      render_error(
        {
          type: 'unauthorized_error',
          status_code: '401',
          message: 'Incorrect email/password combination.'
        }
      )
    end
  end

  def write
    if user_params[ :email ].present?
      user = User.find_by( email: user_params[ 'email' ] ) rescue nil

      unless user.present?
        user = User.new( user_params )

        if user.save
          auth_object = Authentication.new(
            { email: user.email, password: user_params[ :password ] }
          )

          render_result(
            user,
            {
              name: 'users',
              type_name: 'user',
              token: auth_object.generate_token
            }
          )
        end
      else
        render_error(
          {
            type: 'invalid_parameter_error',
            status_code: '400',
            message: 'An account with this email already exists'
          }
        )
      end
    else
      render_error(
        {
          type: 'missing_parameter_error',
          status_code: '400',
          message: 'The email parameter is required.'
        }
      )
    end
  end

  def update
    if id = user_params.delete( :id )
      user = User.find( id ) rescue nil
      if user.present?
        auth_object = Authorization.new( request )
        current_user = auth_object.current_user

        if current_user == user.id
          user.update( user_params )
          user.save

          render_result(
            user,
            {
              name: 'users',
              type_name: 'user',
              token: auth_object.token
            }
          )
        else
          render_error(
            {
              type: 'unauthorized_error',
              status_code: '401',
              message: 'User not permitted to perform that action.'
            }
          )
        end
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
      auth_object = Authorization.new( request )
      current_user = auth_object.current_user

      if current_user == params[ :id ].to_i
        user = User.find( params[ :id ] ) rescue nil

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
            type: 'unauthorized_error',
            status_code: '401',
            message: 'User not permitted to perform that action.'
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

  def login_params
    params.permit( :email, :password )
  end

  def user_params
    params.require( :user ).permit( :email, :name, :password, :id )
  end

end
