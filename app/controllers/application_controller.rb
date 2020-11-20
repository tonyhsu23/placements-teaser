class ApplicationController < ActionController::Base
  include ParameterMappings
  include ResourceManageable

  protect_from_forgery with: :exception

  before_action :authenticate_user!
end
