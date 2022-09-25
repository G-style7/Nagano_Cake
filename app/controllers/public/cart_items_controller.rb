class Public::CartItemsController < ApplicationController
  def index
    @cart_item = CartItem.new
    @cart_items= current_customer.cart_items.all
    # カートに入ってる商品の合計金額
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_price }
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    @cart_item.save
    redirect_to cart_items_path
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
      params.require(:cart_item).permit(:item_id, :amount)
  end
end
