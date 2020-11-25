class AddStatusToLineItems < ActiveRecord::Migration[5.1]
  def change
    add_column :line_items, :status, :string, default: 'unreviewed'
  end
end
