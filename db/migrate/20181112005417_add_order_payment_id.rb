class AddOrderPaymentId < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :payment_id, :integer
    add_column :orders, :status, :string, default: 'initial'

    add_index :orders, [:payment_id]
  end
end
