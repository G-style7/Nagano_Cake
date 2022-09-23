class Public::CartItemsController < ApplicationController
  def index
    @cart_items = Item.new
  end
  
  def create
    @cart_items = Item.new(cart_item_params)
  
  end
  
  def destroy
  
  end
  
  def destroy_all
  
  end
  
  private
  def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount)
  end
end
