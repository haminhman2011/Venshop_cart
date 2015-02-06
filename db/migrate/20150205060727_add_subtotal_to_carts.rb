class AddSubtotalToCarts < ActiveRecord::Migration
  def change
    add_column :carts, :subtotal, :string
  end
end
