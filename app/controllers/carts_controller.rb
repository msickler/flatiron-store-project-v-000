class CartsController < ApplicationController
  def show
    @cart = Cart.find(params[:id])
  end

  def checkout
    cart = Cart.find(params[:id])
    cart.checkout
    cart.save
    redirect_to cart_path(cart),  { notice: 'Checkout was successful'}
  end


end
