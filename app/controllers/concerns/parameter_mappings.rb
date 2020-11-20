module ParameterMappings
  extend ActiveSupport::Concern

  def sort_by_field
    params[:sort_by]
  end

  def direction
    params[:direction]
  end

  def page
    params[:page]
  end

  def per
    params[:per]
  end

  def keyword
    params[:keyword]
  end
end
