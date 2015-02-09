class CartController < ApplicationController

  def index
    @products = []
    cart[:products].each do |product|
      @products << {product: Product.find(product[:id_product]), quantity: product[:quantity]  }
    end
  end

  def destroy
   cart[:products].reject! {|h| h[:id_product] == params[:product] }
   redirect_to cart_path
 end

end
