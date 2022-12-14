class Public::CartItemsController < ApplicationController
  def index

  end

  def update
  end

  def destroy
  end

  def destroy_all
  end

  def create
    @item = Item.find(params[:id])
    @cart_item = Cart_item.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    @cart_item.save
    redirect_to public_cart_items(@cart_item.id)
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:amount)
  end
end
