class Public::HomesController < ApplicationController
  def top
    @items = Item.page(params[:page])
    @items = Item.limit(4)
  end

  def about
  end
end