class Admin::OrdersController < ApplicationController
  def show
    @orders = Order.all
    @order = Order.find(params[:id])
  
  end
end
