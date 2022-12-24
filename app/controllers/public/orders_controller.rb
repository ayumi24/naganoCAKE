class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create
    @cart_items = current_customer.cart_items.all
    @order = current_customer.orders.new(order_params)
    @order.postage = 800
    @order.save
    redirect_to complete_public_orders_path
    @cart_items.destroy_all
  end

  def complete
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @orders = current_customer.orders
    @order = Order.find(params[:id])
    @total = 0
  end

  def confirm
    @cart_items = current_customer.cart_items
    @total = 0
    @order = Order.new(order_params)
    @order.customer_id = current_customer
    if params[:order][:address_option] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
      @order.postage = 800
    elsif params[:order][:addresss_option] == "1"
      @order.postage = 800
    end
  end

  private

  def order_params
  params.require(:order).permit(:payment, :postal_code, :address, :name, :price, :postage)
  end
end
