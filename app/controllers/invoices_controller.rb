class InvoicesController < ApplicationController
  def index
    @campaigns_select = Campaign.all.collect { |c| [c.name, c.id] }
  end

  def create
    invoice = Invoice.create_with_campaigns(campaign_ids)
  end

  private

  def campaign_ids
    params.require(:invoice).require(:campaigns).reject(&:blank?)
  end
end
