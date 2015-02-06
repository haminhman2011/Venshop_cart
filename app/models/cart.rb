class Cart < ActiveRecord::Base
  has_many :cart_details
 has_many :products, through: :cart_details


end
