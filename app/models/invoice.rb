class Invoice < ApplicationRecord
  has_paper_trail

  include FieldSearchable

  has_many :campaigns_invoices
  has_many :campaigns, through: :campaigns_invoices

  before_create :generate_code

  def self.associate_to_campaigns(campaigns, **opt)
    transaction do
      invoice = opt[:invoice_id].present? ? find(opt[:invoice_id]) : create!
      invoice.campaigns << campaigns
    end
  end

  def remove_campaign(campaign_id)
    transaction do
      campaign = Campaign.find(campaign_id)
      campaigns.delete(campaign)
    end
  end

  def grand_totals
    campaigns.sum(&:sub_totals)
  end

  private

  def generate_code
    self.code = DateTime.current.strftime('%Q')
  end
end
