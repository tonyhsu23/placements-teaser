class CreateCampaignsInvoices < ActiveRecord::Migration[5.1]
  def change
    create_table :campaigns_invoices do |t|
      t.references :campaign, foreign_key: true
      t.references :invoice, foreign_key: true
    end
  end
end
