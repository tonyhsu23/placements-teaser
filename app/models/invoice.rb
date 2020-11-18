class Invoice < ApplicationRecord
  has_many :campaigns_invoices
  has_many :campaigns, through: :campaigns_invoices

  before_create :generate_code

  def self.create_with_campaigns(campaign_ids)
    ActiveRecord::Base.transaction do
      campaigns = Campaign.where(id: campaign_ids)
      invoice   = Invoice.create!
      invoice.campaigns << campaigns
    end
  end

  private

  def generate_code
    self.code = DateTime.current.strftime('%Q')
  end
end
