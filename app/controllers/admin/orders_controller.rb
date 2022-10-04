class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_detail = @order.order_details
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      if @order.status == "payment_confirmation" #1は入金確認
         @order.order_details.each do |order_detail|
           order_detail.update(making_status: 1)
         end
      end
      redirect_to admin_order_path(@order.id)
    else
      render :show
    end
  end

  private
  def order_params
      params.require(:order).permit(:status)
  end
end