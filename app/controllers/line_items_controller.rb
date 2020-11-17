class LineItemsController < ApplicationController
  def index
    @items = LineItem.includes(:campaign)
    @items = Pagination.new(@items, paginate_params).paginate
  end
end
