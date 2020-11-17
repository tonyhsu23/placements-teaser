class Pagination
  attr_reader :page, :per, :order, :direction, :resources, :length, :use_sort

  def initialize(obj_list, args = {})
    @resources  = obj_list.compact
    @length     = resources.length
    @page       = args[:page].try(:to_i) || 1
    @per        = args[:per].blank? ? length : args[:per].to_i
    @order      = args[:sort] || 'id'
    @direction  = args[:asc?]
    @use_sort   = args[:use_sort?]
  end

  def paginate
    results = @use_sort == false ? resources : sort_resources
    Kaminari.paginate_array(results).page(page).per(per)
  end

  def total_pages
    length.positive? ? (length / per.to_f).ceil : 0
  end

  private

  def sort_resources
    results = resources.sort_by { |resource| [resource[order] ? 1 : 0, resource[order]] }.reverse
    results.reverse! if direction.present?
    results
  end
end
