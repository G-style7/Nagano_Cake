class Public::AddressesController < ApplicationController
  def index
    @address = Address.new
    @addresses = current_customer.addresses #ここにはcurrent_customerの登録してある住所を持ってきたい
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    @address.save
    redirect_to addresses_path
  end

  def edit
    @address = current_customer(address.id) #ここにはcurrent_customerの登録してある1つの住所を持ってきたい
  end

  def update
    if @address.update(address_params)
       redirect_to addresses_path
    else
      render edit
    end
  end

  def destroy
    address = Addresses.find(params[:id]) #複数形？ current customerいらない？
    address.destroy
    redirect_to addresses_path
  end

private
  def address_params
    params.require(:address).permit(:postal_code, :address, :name)

  end
end
