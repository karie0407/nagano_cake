class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create
    order = Order.new(order_params)
    current_order.id = current_customer.id
    cart_items = current_customer.cart_item
    if order.save
      cart_items.each do |cart|
        order_detail = OrderDetail.new
        order_detail.item_id = cart.item_id
        order_detail.order_id = order.id
        order_detail.amount = cart.item.amount
        order_item.price = cart.item.price
        order_detail.save
    end
    cart_items.destroy_all
    redirect_to orders_confirm_path
    else
     redirect_to new_order_path
    end
  end
  def confirm
    @total = 0
    @cart_items=current_customer.cart_items
  if params[:order][:select_address] == "0"
  @order = Order.new(order_params)
  @order.postal_code = current_customer.postal_code
  @order.address = current_customer.address
  @order.name = current_customer.full_name
  elsif params[:order][:select_address] == "1"
  @address = Address.find(params[:order][:address_id])
  @order.postal_code = @address.postal_code
  @order.address = @address.address
  @order.name = @address.name
  elsif params[:order][:select_address] =="2"
  @order = Order.new(order_params)
  end
  end

  def index
  end

  def show
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name)
  end
end