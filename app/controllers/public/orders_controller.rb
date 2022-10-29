class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create
    order = Order.new(order_params)
    order.customer_id=current_customer.id
    if order.save
      current_customer.cart_items.each do |cart|
        order_detail = OrderDetail.new
        order_detail.item_id = cart.item_id
        order_detail.order_id = order.id
        order_detail.amount = cart.amount
        order_detail.price  =  cart.item.with_tax_price
        order_detail.save
    end
    current_customer.cart_items.destroy_all
    redirect_to orders_complete_path
    else
     redirect_to new_order_path
    end
  end
  def confirm
    @order = Order.new(order_params)
    @cart_items=current_customer.cart_items.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
    @order.shipping_cost = 800
    @total_payment = @total + @order.shipping_cost
  if params[:order][:select_address] == "0"
  @order.postal_code = current_customer.postal_code
  @order.address = current_customer.address
  @order.name = current_customer.full_name
  elsif params[:order][:select_address] == "1"
  @address = Address.find(params[:order][:address_id])
  @order.postal_code=@address.postal_code
  @order.address = @address.address
  @order.name = @address.name
  elsif params[:order][:select_address] ="2"
  @order.postal_code = params[:order][:postal_code]
  @order.address = params[:order][:address]
  @order.name = params[:order][:name]
  end
  end

  def index
  @orders =Order.all
  end

  def show
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :shipping_cost, :total_payment, :status, :customer_id)
  end
end