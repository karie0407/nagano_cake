class Public::CartItemsController < ApplicationController
  def index
  @cart_items= CartItem.all
  @total = 0
  end
  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    current_cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item] [:item_id])
    # 選択した商品が既にカート内に存在する場合
    if current_cart_item.present?
       current_cart_item.amount += params[:cart_item] [:amount].to_i
       current_cart_item.save
    redirect_to cart_items_path
    # 選択した商品がカート内に存在しない場合
    else
    @cart_item.save
    redirect_to cart_items_path
    end
  end

  def update
    cart_item = CartItem.find(params[:id])
    cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end
  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end

  def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount)
  end

end
