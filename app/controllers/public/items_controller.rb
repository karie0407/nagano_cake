class Public::ItemsController < ApplicationController
  def index
  @genres = Genre.all
  if params[:genre_id]
  @genre = Genre.find(params[:genre_id])
  @items= Item.where(genre_id:@genre.id).page(params[:page]).per(8).order(created_at: :desc)
  else
   @items = Item.all.page(params[:page]).per(8).order(created_at: :desc)
  end
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @genres = Genre.all
  end

  def item_params
    params.require(:item).permit(:name, :image, :introduction, :price, :is_active, :genre_id)
  end
end
