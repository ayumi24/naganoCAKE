class Admin::HomesController < ApplicationController
  def top
    @orders = Order.all
    @order_details = OrderDetail.all
  end
end
