class CreateLineItems < ActiveRecord::Migration[5.1]
  def change
    create_table :line_items do |t|
      t.string :name, null: false
      t.decimal :booked_amount, precision: 10, scale: 20,  default: 0
      t.decimal :actual_amount, precision: 10, scale: 20,  default: 0
      t.decimal :adjustments, precision: 10, scale: 20,  default: 0
      t.integer :lock_version, default: 0
      t.references :campaign, foreign_key: true

      t.timestamps
    end
  end
end
