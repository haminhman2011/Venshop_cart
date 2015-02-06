class Product < ActiveRecord::Base
  has_many :product_categories
  has_many :categories, :through => :product_categories

  has_many :cart_details
  has_many :carts , through: :cart_details

  # def self.search(search)
  #   if search
  #     return where(['name like ? OR name like ? OR name like ?', "%#{search.upcase}%","%#{search.downcase}%", "%#{search.capitalize}%"])
  #   else
  #     self.all
  #   end
  # end

end
