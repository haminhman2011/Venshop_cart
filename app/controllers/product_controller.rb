class ProductController < ApplicationController
  def show
    @product = Product.find(params[:id])
  end
  def index
    @products = Product.paginate(page:params[:page], per_page: 10)
  end
  def edit
    @product = Product.find(params[:id])
  end
def update
 @product = Product.find(params[:id])
    if @product.update_attributes(product_params)
      flash[:success] = "product updated"
      redirect_to products_url
    else
      render 'edit'
    end
end
def destroy
    Product.find(params[:id]).destroy
    flash[:success] = "product deleted"
    redirect_to products_url
  end

  def new
    @product = Product.new
  end

  # def search
  #   @search_results = Product.search params[:search]
  # end

private

  def product_params
      params.require(:product).permit(:name, :image_url, :description, :formattedprice)
    end

end
