module ResourceManageable
  def manage(resources)
    resources = sort(resources)
    resources = paginate(resources)
  end

  def sort(resources)
    resources.order("#{sort_by_field || 'id'} #{direction || 'desc'}")
  end

  def paginate(resources)
    resources.page(page || 1).per(per || 25)
  end

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
end
