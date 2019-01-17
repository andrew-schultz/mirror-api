module RendersResults

  def render_result( entity, options = {} )
    result_response = {
      type_name: options[ :type_name ],
    }

    if options[ :count ].present?
      result_response[ 'count' ] = options[ :count ]
    else
      entity = [ entity ]
    end

    if options[ :include ].present?
      parsed_entities = []

      entity.each do | resource |
        included_resources = resource.send( options[ :include ] ).to_a
        resource_json = resource.to_json
        parsed_resource = JSON.parse( resource_json )
        parsed_resource[ options[ :include ] ] = included_resources
        parsed_entities.push( parsed_resource )
      end

      entity = parsed_entities
    end

    result_response[ options[ :name ] ] = entity

    render json: result_response
  end

  def render_error( error )
    error_response = {
      type_name: error[ :type ],
      status: error[ :status_code ],
      errors: [ error ]
    }

    render status: error[ :status_code ], json: error_response
  end

end
