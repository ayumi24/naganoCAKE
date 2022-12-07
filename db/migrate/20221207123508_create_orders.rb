class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|

      t.string :postal_code, null: false
      t.string :address, null: false
      t.string :name, null: false
      t.integer :postage, null: false
      t.integer :price, null: false
      t.integer :payment, null: false, default: 0
      t.integer :status, null: false, default: 0
      t.references :customer, foreign_key: true

      t.timestamps
    end
  end
end
