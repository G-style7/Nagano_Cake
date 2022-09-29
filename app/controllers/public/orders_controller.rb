class Public::OrdersController < ApplicationController

   before_action :check_cart_item, only: [:new]

  def new
    @order = Order.new
  end

  def index
    @orders = current_customer.orders.all # 複数のorderがあるためordersになる
  end

  def show
    @order = Order.find(params[:id])
    @order_detail = @order.order_details
  end

  def confirm  #注文情報に送るためだけのアクション
   @order = Order.new(order_params)
   @cart_items = current_customer.cart_items #理解できない
   @order.shipping_cost = 800
   @sum = 0
    @cart_items.each do |cart_item|
      @sum = @sum + cart_item.sum_price
  end

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
        order_detail.price = cart_item.item.price
        order_detail.making_status = "make_wait"
        # 購入が完了したらカート情報は削除するのでこちらに保存する
        # カート情報を削除するので item との紐付けが切れる前に保存します
        order_detail.save
      end
      cart_items.destroy_all
      redirect_to orders_complete_path

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
  params.require(:order).permit(:payment_method, :postal_code, :address, :name, :shipping_cost, :total_payment, :status ) # ここにselect_addressはカラムにないため記述できない
  end

  def check_cart_item
    @cart_items = current_customer.cart_items
    if @cart_items.empty? #空か確認できるメソッド
       redirect_to items_path
    end
  end
end
