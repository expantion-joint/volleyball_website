class AddPaymentStatusToOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :payment_status, :string
    add_column :orders, :results, :string
  end
end
