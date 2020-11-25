class LineItemsController < ApplicationController
  include Currency

  before_action :set_line_item, only: %i[show update update_status]

  def index
    @items = LineItem.includes(:campaign).left_joins(:campaign)
    @items = manage(@items)
  end

  def show; end

  def update
    if @item.reviewed?
      flash.now[:warning] = 'Cannot change reviewed line item'
    else
      @item.update!(adjustments: update_params)
      flash.now[:success] = 'Update adjustments successfully'
    end
  end

  def update_status
    @item.send("#{params[:event]}!")
    flash[:success] = "#{@item.reload.status} successfully"
  rescue AASM::InvalidTransition
    flash[:warning] = 'Invalid status transition'
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
