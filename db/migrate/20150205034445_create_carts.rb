class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.integer :id_cart
      t.integer :id_user
      t.string :name
      t.string :phone
      t.string :email
      t.string :address
      t.string :status

      t.timestamps null: false
    end
  end
end
