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
      entity = extract_includes( options[ :include ], entity )
    end

    if options[ :token ].present?
      entity = include_token( options[ :token ], entity )
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

  private

  def extract_includes( include_param, entity )
    parsed_entities = []

    entity.each do | resource |
      included_resources = resource.send( include_param ).to_a
      resource_json = resource.to_json
      parsed_resource = JSON.parse( resource_json )
      parsed_resource[ include_param ] = included_resources
      parsed_entities.push( parsed_resource )
    end

    parsed_entities
  end

  def include_token( token, entity )
    parsed_entities = []

    entity.each do | resource |
      resource_json = resource.to_json
      parsed_resource = JSON.parse( resource_json )
      parsed_resource[ :token ] = token
      parsed_entities.push( parsed_resource )
    end

    parsed_entities
  end

end
