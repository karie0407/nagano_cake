class Public::HomesController < ApplicationController
  before_action :set_items, only: [:top]
def top
  @items = @new_items.first(4)
  @genres = Genre.all
end
def about
end

private
def set_items
  @new_items = Item.all.order("created_at DESC")
end
end
