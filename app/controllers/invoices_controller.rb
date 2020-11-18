class InvoicesController < ApplicationController
  def index
    @campaigns_select = Campaign.all.collect { |c| [c.name, c.id] }

    @invoices = Invoice.includes(campaigns: :line_items)
    @invoices = Pagination.new(@invoices, paginate_params).paginate
  end

  def create
    invoice = Invoice.create_with_campaigns(campaign_ids)

    redirect_back(fallback_location: invoices_path)
  end

  private

  def campaign_ids
    params.require(:invoice).require(:campaigns).reject(&:blank?)
  end
end
