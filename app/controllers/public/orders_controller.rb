class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create
    order = Order.new(order_params)
    current_order.id = current_customer.id
    order.save
  end


  def index
  end

  def show
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :name, :postal_code, :address, :shipping_cost, :total_payment, :payment_method, :status)
  end
end
