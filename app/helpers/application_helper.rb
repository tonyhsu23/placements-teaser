module ApplicationHelper
  def nav_item
    content_tag(:ul, class: 'navbar-nav') do
      yield
    end
  end

  def nav_link(text, path)
    active = text.parameterize.underscore == controller_name ? 'active' : ''

    content_tag(:li, class: "nav-item #{active}") do
      link_to(text, path, class: 'nav-link')
    end
  end

  def sort_link(text, sort_field, params)
    if params[:sort_by] == sort_field
      direction = params[:direction] == 'desc' ? 'asc' : 'desc'
    else
      direction = 'asc'
    end

    link_to(text, params.merge(sort_by: sort_field, direction: direction))
  end
end
