class SessionsController < ApplicationController

 def add_cart

   hash_product = cart[:products].find {|product| product[:id_product] == params[:id_product]}
   if (hash_product.nil?)
    cart[:products] << {id_product: params[:id_product], quantity:1}
  else
    hash_product[:quantity] += 1
  end
    # message = cart
    # flash[:warning] = message
    redirect_to root_path
  end
  def new
   user = User.new
 end



 def create
  user = User.find_by(email: params[:session][:email].downcase)
  if user && user.authenticate(params[:session][:password])
   # log_in user

   # params[:session][:remember_me] == '1' ? remember(user) : forget(user)
   # redirect_back_or user
   if user.activated?
    log_in user
    params[:session][:remember_me] == '1' ? remember(user) : forget(user)
    redirect_back_or user
  else
    message  = "Account not activated. "
    message += "Check your email for the activation link."
    flash[:warning] = message
    redirect_to root_url
  end
else
  flash.now[:danger] = 'Invalid email/password combination'
  render 'new'
end
end

def destroy
  log_out if logged_in?
  redirect_to root_url
end
end