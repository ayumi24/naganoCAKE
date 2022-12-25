class Public::OrdersController < ApplicationController
  def new
    @cart_items = current_customer.cart_items.all
    @order = Order.new
    unless @cart_items.exists?
      redirect_to public_cart_items_path
    end
  end

  def create
    @order = current_customer.orders.new(order_params)
    @order.postage = 800
    @order.save
    @cart_items = current_customer.cart_items.all
    @cart_items.each do |cart_item|
      @order_detail = OrderDetail.new
      @order_detail.order_id = @order.id
      @order_detail.item_id = cart_item.item_id
      @order_detail.price = cart_item.subtotal
      @order_detail.amount = cart_item.amount
      @order_detail.save
    end
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
    elsif params[:order][:address_option] == nil
      redirect_to new_public_order_path
    end
  end

  private

  def order_params
  params.require(:order).permit(:payment, :postal_code, :address, :name, :price, :postage)
  end
end
