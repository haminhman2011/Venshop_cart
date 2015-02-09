class CartController < ApplicationController

  def index
    @products = []
    cart[:products].each do |product|
      @products << {product: Product.find(product[:id_product]), quantity: product[:quantity]}

    end
  end

  def destroy
   cart[:products].reject! {|h| h[:id_product] == params[:product] }
   redirect_to cart_path
 end
 def new
   @products = []
    cart[:products].each do |product|
      @products << {product: Product.find(product[:id_product]), quantity: product[:quantity]  }
    end
  @cart = Cart.new
  if logged_in?
    @user = current_user
  end
  @sub_total_price = 0
    # Initial array cart product
    @cart_products = []
    if !session[:cart].nil?
      session[:cart].deep_symbolize_keys!
      session[:cart][:products].each do |product|
        temp = Product.find(product[:id_product])
        total_price = (temp.amount/100).to_f * product[:quantity].to_f
        @sub_total_price += total_price
        @cart_products << {product: Product.find(product[:id_product]), quantity: product[:quantity], total: total_price}
      end
    end
  end

 def update
    if !session[:cart].nil?
      session[:cart]["products"].each_with_index do |cart_products, index|
        cart_products["quantity"] = params[:quantity][index]
      end
      flash[:success] = "update successfully"
      redirect_to cart_path
    else
      flash[:danger] = "Cart empty, please add product to cart"
      redirect_to cart_path
    end
  end
def cart_params
 params.require(:cart).permit(:name, :email, :phone, :address)
end
  def create
    if !params[:cart].nil?
      @cart = Cart.new(cart_params)
      @cart.id_user = session[:cart][:id_user]
      @cart.status = 'Preparing'
      if @cart.save
        flash[:success] = 'Check out successfully'
        session[:cart]["products"].each do |product|
          CartDetail.create!(id_cart_id: @cart.id, id_product_id: product["id_product"], quantity: product["quantity"].to_s.to_i)
        end
        session[:cart].delete("products")
        session[:cart]["products"] = []
        redirect_to root_path
      else
        render 'new'
      end
    end
  end
end