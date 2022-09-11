class Admin::ItemsController < ApplicationController
  def new
    @item = Item.new
  end
  def create
    @item = Item.new(item_params)
    @item.admin_id = current_admin.id
    @item.save
    redirect_to admin_item_path
  end
  
  
  
   private

  def item_params
    params.require(:item).permit(:name, :image, :introduction, :price, :is_active)
  end
end
