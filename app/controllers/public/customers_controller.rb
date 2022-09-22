class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end
  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to customers_my_page_path
    else
      render :edit
    end
  end

  def unsubscribe #退会確認
  end

  def withdraw #退会処理
   @customer = current_customer
   if @customer.update(is_deleted: true) # 左の書き方はis_deletedをtrueにさせる　bookers2では@book.update(book_params)と記述していたため、ストロングパラメータの内容をupdateさせていた
      reset_session  #ログイン状態を解除する
      flash[:notice] = "退会処理を実行いたしました" #viewに記述しないと反映されない
      redirect_to root_path
   else
      render :show
   end
  end

  private
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email)

  end

end
