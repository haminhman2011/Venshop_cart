class SearchsController < ApplicationController

  def show
    @products = nil
    render 'search'
  end

  def search
    if (params[:keyword]!='')
      @products = Product.where('name like ?', "%#{params[:keyword]}%")
    end
  end

end
