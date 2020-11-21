class InvoicesController < ApplicationController
  include FileUploadable

  before_action :set_campaign_selection, only: %i[index show]
  before_action :set_campaigns, only: %i[create update]
  before_action :set_invoice, only: %i[show remove_campaign upload]
  before_action :set_filename, only: %i[show upload]

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
        response.headers['Content-Disposition'] = "attachment; filename=\"#{@filename}\""
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

  def upload
    spreadsheet = render_to_string(template: 'invoices/show.xlsx.axlsx',
                                   format: :axlsx, locals: { data: @invoice })

    if object_uploaded?("invoices/#{@filename}", spreadsheet)
      flash[:success] = 'Upload successfully'
    else
      flash[:warning] = 'Error uploading object'
    end

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

  def set_filename
    @filename = "#{Date.today}-INVOICE-#{@invoice.code}.xlsx"
  end
end
