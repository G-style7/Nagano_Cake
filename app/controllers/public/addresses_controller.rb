class Public::AddressesController < ApplicationController
  def index
    @address = Address.new
    @addresses = current_customer.addresses
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    @address.save
    redirect_to addresses_path
  end

  def edit
  end

  def destroy
    address = current_customer.address
    address.destroy
    redirect_to edit_address_path
  end

private
  def address_params
    params.require(:address).permit(:postal_code, :address, :name)

  end
end
