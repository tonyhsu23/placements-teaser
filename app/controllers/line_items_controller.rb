class LineItemsController < ApplicationController
  include Currency

  before_action :set_line_item, only: %i[update update_status]

  def index
    @items = LineItem.includes(:campaign).left_joins(:campaign)
    @items = manage(@items)
  end

  def update
    return @status = 'failure' if @item.reviewed?
    @item.update!(adjustments: update_params)
  end

  def update_status
    @item.send("#{params[:event]}!")
  rescue AASM::InvalidTransition
    @status = 'failure'
  end

  private

  def line_item_params
    params.require(:line_item).permit(:adjustments)
  end

  def update_params
    currency_to_number(line_item_params['adjustments'])
  end

  def set_line_item
    @item = LineItem.find(params[:id])
  end
end
