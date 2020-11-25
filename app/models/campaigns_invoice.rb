class CampaignsInvoice < ApplicationRecord
  belongs_to :campaign
  belongs_to :invoice
end
