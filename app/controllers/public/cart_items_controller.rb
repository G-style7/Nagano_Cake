class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_item = CartItem.new
    @cart_items = current_customer.cart_items.all
    # カートに入ってる商品の合計金額
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_price }
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id # @cart_item.amount = @cart_item.amount.to_i
    @cart_items = current_customer.cart_items.all
     if @cart_items.find_by(item_id: @cart_item.item_id ) #find_byは見つかった場合trueになる
       cart_item = @cart_items.find_by(item_id: @cart_item.item_id)
       new_amount = cart_item.amount + @cart_item.amount
          cart_item.update_attribute(:amount, new_amount) #　左記はamountをnew_amountに変更する記述
          @cart_item.delete
     else
          @cart_item.save
     end
    redirect_to cart_items_path, notice: "カートに商品が入りました"
  end

  def update
    @items = CartItem.find(params[:id])
    if @items.update(cart_item_params)
       redirect_to cart_items_path
    else
       render :index
    end
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path

  end

  def destroy_all
    cart_items = CartItem.all
    cart_items.destroy_all # railsのdefaultとなっている書き方
    redirect_to cart_items_path

  end

  private
  def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount, :customer_id)
  end
end
