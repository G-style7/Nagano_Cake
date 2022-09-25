class Public::OrdersController < ApplicationController
  def new
    @order = Order.new


  end

  def index
  end

  def show
  end

  def confirm  #注文情報に送るためだけのアクション
   @order = Order.new(order_params)
   @cart_items = current_customer.cart_items #理解できない

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
  
  def create 
      # Order に情報を保存します
     cart_items = current_customer.cart_items.all
     # ログインユーザーのカートアイテムをすべて取り出して cart_items に入れる
     @order = current_customer.orders.new(order_params)
     # 渡ってきた値を @order に入れる
     if @order.save
        cart_items.each do |cart_item|
            # 取り出したカートアイテムの数繰り返す
            # order_item にも一緒にデータを保存する必要があるのでここで保存する
        order_detail = OrderDetail.new
        order_detail.item_id = cart_item.item_id
        order_detail.order_id = @order.id
        order_detail.amount = cart_item.amount
        # 購入が完了したらカート情報は削除するのでこちらに保存する
        order_detail.sum_price = cart_item.item.price #sum_priceは(cart_item.rbだが)呼び出せる
        # カート情報を削除するので item との紐付けが切れる前に保存します
        order_detail.save
      end
      redirect_to orders_complete_path
      order_detail.destroy_all
      # ユーザーに関連するカートのデータ(購入したデータ)をすべて削除する(カートを空にする)
     else
      @order = Order.new(order_params)
      render :new
     end
  end
  
  def complete
      
  end

private
  

  def order_params
  params.require(:order).permit(:payment_method, :postal_code, :address, :name) # ここにselect_addressはカラムにないため記述できない
  end
end