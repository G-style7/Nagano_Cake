class Public::OrdersController < ApplicationController
  def new
    @order = Order.new


  end

  def index
  end

  def show
  end

  def confirm
   @order = Order.new(order_params) #注文情報に送るためだけのアクション？

   if params[:select_address] == "1"
     @order.postal_code = current_customer.postal_code #
     @order.address = current_customer.address
     @order.name = current_customer.first_name + current_customer.last_name
   elsif params[:select_address] == "2"
     @address = Address.find(params[:order][:address_id])
     @order.postal_code = @address.postal_code
     @order.address = @address.address
     @order.name = @address.name
   else
     @order = Order.new(order_params) # params[:select_address] == "3"
   end
  end

  #. ⬆️⬇️注文機能実装時に登録するデータでもあるためこの時点でストロングパラメーターに登録をし
  #  注文(Order)モデルをnewメソッドで作成した際にデータが入るようにする
private

  def order_params
  params.require(:order).permit(:payment_method, :postal_code, :address, :name) # ここにselect_addressはカラムにないため記述できない
  end
end
