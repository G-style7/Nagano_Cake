class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
  end

  def edit
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

end
