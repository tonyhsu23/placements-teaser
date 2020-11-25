module FieldSearchable
  extend ActiveSupport::Concern

  CAMPAIGN_SEARCHABLE_FIELDS = %w[campaigns.name].freeze
  LINEITEM_SEARCHABLE_FIELDS = %w[line_items.name campaigns.name].freeze
  INVOICE_SEARCHABLE_FIELDS  = %w[invoices.code campaigns.name].freeze
  VERSION_SEARCHABLE_FIELDS  = %w[versions.item_type users.email].freeze
end
