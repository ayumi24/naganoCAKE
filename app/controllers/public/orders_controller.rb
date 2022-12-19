class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create
  end

  def index
  end

  def show
  end

  def confirm
    @order = Order.new(order_params)
    if [:address_option] == "0"
      @order.podtal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name
      @order.postage = 800
    elsif [:addresss_option] == "1"
      @order.postage = 800
    end
  end

  private

  def order_params
  params.require(:order).permit(:payment_method, :postal_code, :address, :name, :price)
  end
end
