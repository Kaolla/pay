class AddColumnsToCharges < ActiveRecord::Migration[6.0]
  def change
    add_column :pay_charges, :payment_intent, :string
    add_column :pay_charges, :captured, :boolean
  end
end