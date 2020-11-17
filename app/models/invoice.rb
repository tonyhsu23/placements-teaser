class Invoice < ApplicationRecord
  has_many :campaigns_invoices
  has_many :campaigns, through: :campaigns_invoices
end
