class Admin::OrderDetailsController < ApplicationController
  def update
    order_detail = OrderDetail.find(params[:id])
    order_detail.update(order_detail.params)
    redirect_to admin_path
  end

  private
  def order_detail.params
    params.require(:order_detail).permit(:making_status)
  end
end
