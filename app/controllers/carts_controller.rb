class CartsController < ApplicationController
  def show
    @cart = Cart.find(params[:id])
  end

  def checkout
    @cart = Cart.find(params[:id])
    current_cart.checkout
    current_user.current_cart = nil
    current_user.save
    redirect_to cart_path(@cart), { notice: 'Checkout was successful!' }
  end


end
