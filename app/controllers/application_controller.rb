class ApplicationController < ActionController::API
  include ExceptionHandler
  include RendersResults
end
