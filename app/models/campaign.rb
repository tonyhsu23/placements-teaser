class Campaign < ApplicationRecord
  has_many :line_items
  has_many :campaigns_invoices
  has_many :invoices, through: :campaigns_invoices
end
