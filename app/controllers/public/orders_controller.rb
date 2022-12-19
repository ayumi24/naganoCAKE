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
    if params[:order][:address_number] == "1"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name
    elsif params[:order][:address_number] == "2"
      address_new = current_customer.addresses.new(address_params)
      if address_new.save
      else
        render :new
      end
    end
  end

  private

  def order_params
  params.require(:order).permit(:payment_method, :postal_code, :address, :name, :price)
  end

  def address_params
    params.require(:order).permit(:postal_code, :address, :name)
  end

end
