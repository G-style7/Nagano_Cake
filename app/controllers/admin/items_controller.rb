class Admin::ItemsController < ApplicationController
  def new
    @item = Item.new
  end
  
  def create
    @item = Item.new(item_params)
    @item.save
    redirect_to admin_item_path(@item.id)
  end
    
  def index
    @item =Item.all
    
  end
  
  def show
  end

  def edit
  end
end
