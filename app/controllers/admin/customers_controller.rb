class Admin::CustomersController < ApplicationController
  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])

  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = "You have updated book successfully."
    redirect_to admin_customer_path(@customer.id)
    else
    render :edit
    end
  end

  private
  def customer_params #privateメソッドの名前は、「モデル名_params」とすることが多い
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email, :is_deleted) #bookはモデルのtitle.bodyカラムを承認
  end
end
