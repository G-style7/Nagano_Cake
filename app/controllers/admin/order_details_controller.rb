class Admin::OrderDetailsController < ApplicationController

def update
    @order = Order.find(params[:order_id])
    @order_detail = OrderDetail.find(params[:id]) # @order.order_details.find(params[:id])と同じ
    if @order_detail.update(order_detail_params)
      
      redirect_to admin_order_path(@order.id)
    else
      render admin_path(@order.id)
    end

end

private
  def order_detail_params
      params.require(:order_detail).permit(:making_status)
  end
end
