class StaticPagesController < ApplicationController

  def home
   if logged_in?
   end
   @products = Product.all
 end


 def about
 end

 def contact
 end
end
