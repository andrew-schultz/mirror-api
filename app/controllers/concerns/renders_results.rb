module RendersResults

  def render_result( entity, options = {} )
    result_response = {
      type_name: options.type_name,
    }

    if options.count.present?
      result_response[ 'count' ] = options.count
    end

    result_response[ options.name ] = [ entity ]

    render json: result_response
  end

  def render_error( error )
    error_response = {
      type_name: error.type_name,
      status: error.status_code,
      errors: [ error ]
    }

    render status: error.status_code, json: error_response
  end

end
