module ResourceManageable
  extend ActiveSupport::Concern

  def manage(resources)
    resources = sort(resources)
    resources = filter(resources)
    resources = paginate(resources)
  end

  def sort(resources)
    resources.order("#{sort_by_field || table_id} #{direction || 'desc'}")
  end

  def paginate(resources)
    resources.page(page || 1).per(per || 25)
  end

  def filter(resources)
    keyword.present? ? resources.where(filter_query, *keyword_str) : resources
  end

  def filter_query
    searchable_fields.each_with_object([]) do |field, query|
      query.push("#{field} LIKE LOWER(?)")
    end.join(' OR ')
  end

  def keyword_str
    (["%#{keyword}%"] * searchable_fields.length).flatten
  end

  def searchable_fields
    class_name = controller_name.classify
    "#{class_name}::#{class_name.upcase}_SEARCHABLE_FIELDS".constantize
  end

  def table_id
    "#{controller_name}.id"
  end
end
