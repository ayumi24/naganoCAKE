class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create

  end

  def index
    @orders = Order.all
  end

  def show
  end

  def confirm
    @cart_items = current_customer.cart_items
    @total = 0
    @order = Order.new(order_params)
    @order.customer_id = current_customer
    if params[:order][:address_option] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name
      @order.postage = 800
    elsif params[:order][:addresss_option] == "1"
      @order.postage = 800
    end
  end

  private

  def order_params
  params.require(:order).permit(:payment_method, :postal_code, :address, :name, :price, :postage)
  end
end
