class Admin::ItemsController < ApplicationController
  before_action :move_to_signed_in
  def new
    @item = Item.new
  end
  def create
    @item = Item.new(item_params)
    if @item.save
    redirect_to admin_item_path(@item.id)
    else
      render :new
    end
  end
  def index
  @genres = Genre.all
  if params[:genre_id]
    @genre = Genre.find(params[:genre_id])
    @items = Item.where(genre_id:@genre.id).page(params[:page]).per(4).order(created_at: :desc)
  else
  @items= Item.page(params[:page]).per(4).order(created_at: :desc)
  end
  end
  def show
  @item = Item.find(params[:id])
  @cart_item =CartItem.new
  @genres = Genre.all
  end

  def edit
    @item = Item.find(params[:id])
  end
  def update
    item = Item.find(params[:id])
    if item.update(item_params)
    redirect_to admin_item_path(item.id)
    else
      render :edit
    end
  end

   private

  def item_params
    params.require(:item).permit(:name, :image, :introduction, :price, :is_active, :genre_id)
  end

  def move_to_signed_in
    unless  admin_signed_in?
      redirect_to root_path
    end
  end
end
