class InvoicesController < ApplicationController
  before_action :set_campaign_selection, only: %i[index show]
  before_action :set_campaigns, only: %i[create update]
  before_action :set_invoice, only: %i[show remove_campaign]

  def index
    @invoices = Invoice.includes(campaigns: :line_items).joins(campaigns: :line_items)
    @invoices = manage(@invoices)
  end

  def create
    Invoice.associate_to_campaigns(@campaigns)

    redirect_back(fallback_location: invoices_path)
  end

  def show
    respond_to do |format|
      format.html
      format.xlsx {
        filename = "#{Date.today}-INVOICE-#{@invoice.code}"
        response.headers['Content-Disposition'] = "attachment; filename=\"#{filename}.xlsx\""
      }
    end
  end

  def update
    invoice = Invoice.associate_to_campaigns(@campaigns, invoice_id: params[:id])

    redirect_back(fallback_location: invoices_path(invoice))
  end

  def remove_campaign
    @invoice.remove_campaign(campaign_id)

    redirect_back(fallback_location: invoice_path(@invoice))
  end

  private

  def campaign_ids
    params.require(:invoice).require(:campaigns).reject(&:blank?)
  end

  def campaign_id
    params.require(:campaign)
  end

  def set_invoice
    @invoice = Invoice.includes(campaigns: :line_items).find(params[:id])
  end

  def set_campaign_selection
    @campaigns_select = Campaign.all.collect { |c| [c.name, c.id] }
  end

  def set_campaigns
    @campaigns = Campaign.where(id: campaign_ids)
  end
end
