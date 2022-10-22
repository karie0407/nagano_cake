class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create
    order = Order.new(order_params)
    current_order.id = current_customer.id
    cart_items = current_customer.cart_items
    if order.save
      cart_items.each do |cart|
        order_detail = OrderDetail.new
        order_detail.price = cart_item.item.price
        order_detail.amount = cart_item.amount
        order_detail.item_id = cart_item.item_id
        order_detail.save
    end
    redirect_to orders_complete_path
   else
     redirect_to new_order_path
   end
  end
  def confirm
    @order = Order.new
    @order.payment_method = params[:order][:payment_method]
    # 配送料
    @order.shipping_cost = 800
    # カート商品
    @cart_items = current_customer.cart_items
    # 合計金額
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
    # 請求金額
    @total_payment = @total + @order.shipping_cost

　　# 配送先選択
    if params[:order][:address_select] =="0"
    @order.postal_code =current_customer.postal_code
    @order.address =current_customer.address
    @order.name = current_customer.first_name + current_customer.last_name
    elsif params[:order][:address_select] =="1"
      @order.postal_code = Address.find(params[:order][:address_id]).post_code
      @order.address = Address.find(params[:order][:address_id]).address
      @order.name =Address.find(params[:order][:address_id]).name
    elsif params[:order][:address_select] =="2"
      @order.post_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
    end
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