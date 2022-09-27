class Admin::OrderDetailsController < ApplicationController

def update
    @order = Order.find(params[:id])
    @order_detail = @order.order_details(params[:id])
    if @order_detail.update(order_detail_params)
      redirect_to admin_path(@order.id)
    else
      render admin_path(@order.id)
    end
end

private
  def order_detail_params
      params.require(:order_detail).permit(:making_status)
  end
end
