class AddStatusToCampaigns < ActiveRecord::Migration[5.1]
  def change
    add_column :campaigns, :status, :string, default: 'unreviewed'
  end
end
