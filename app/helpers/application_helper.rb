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
end
