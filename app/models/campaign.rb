class Campaign < ApplicationRecord
  has_many :line_items
  has_many :campaigns_invoices
  has_many :invoices, through: :campaigns_invoices

  def sub_totals
    line_items.sum(&:billable_amount)
  end
end
