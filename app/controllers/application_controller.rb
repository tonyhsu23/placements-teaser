class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  private

  def paginate_params
    { page: params[:page], per: params[:per] || default_per_page }
  end

  def default_per_page
    25
  end
end
