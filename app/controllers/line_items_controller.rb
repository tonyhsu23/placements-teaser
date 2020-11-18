class LineItemsController < ApplicationController
  include Currency

  def index
    @items = LineItem.includes(:campaign)
    @items = Pagination.new(@items, paginate_params).paginate
  end

  def update
    @item = LineItem.find(params[:id])
    @item.update!(adjustments: update_params)
  end

  private

  def line_item_params
    params.require(:line_item).permit(:adjustments)
  end

  def update_params
    currency_to_number(line_item_params['adjustments'])
  end
end
